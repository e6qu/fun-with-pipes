"""Prepare exact-source typed State transforms; compilation stays on runners."""
from pathlib import Path
import hashlib, json

BASE = Path('/private/tmp/fwp-phase2-next-audit-source')
OUT = Path('/private/tmp/fwp-typed-state-draft')
OUT.mkdir(exist_ok=True)
patches = {}

def change(name, old, new):
    source = (OUT / name).read_text() if (OUT / name).exists() else (BASE / name).read_text()
    assert source.count(old) == 1, (name, old[:120], source.count(old))
    patches.setdefault(name, []).append(dict(old=old, new=new))
    target = OUT / name
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(source.replace(old, new, 1))

change('runtime/fwp_rt.c', 'static size_t fwp_state_len = 0, fwp_state_cap = 0;', '''static size_t fwp_state_len = 0, fwp_state_cap = 0;
typedef struct fwp_state_owner {
    struct fwp_state_owner *prev;
    size_t index;
    V value;
    void (*duplicate)(V);
    void (*drop)(V);
} fwp_state_owner;
static fwp_state_owner *fwp_state_owners = 0;''')
name = 'runtime/fwp_rt_task.c'
change(name, '    size_t st_len, st_cap;', '    size_t st_len, st_cap;\n    fwp_state_owner *state_owners;')
change(name, '    fwp_state_cap = to->st_cap;', '    fwp_state_cap = to->st_cap;\n    fwp_state_owners = to->state_owners;')
change(name, '    from->st_cap = fwp_state_cap;', '    from->st_cap = fwp_state_cap;\n    from->state_owners = fwp_state_owners;')
change(name, '    fwp_state_len = fwp_state_cap = 0;', '    fwp_state_len = fwp_state_cap = 0;\n    fwp_state_owners = 0;')
name = 'runtime/fwp_rt_prims.c'
anchor = 'static V fwp_p_get(void) { return fwp_state_len ? fwp_state[fwp_state_len - 1] : FWP_UNIT; }'
change(name, anchor, anchor + '\n\n' + Path('/private/tmp/fwp-typed-state-runtime.c').read_text())
change(name, '''static V fwp_p_put(V s) {
    if (fwp_state_len) fwp_state[fwp_state_len - 1] = s;
    return FWP_UNIT;
}''', '''static V fwp_p_put(V s) {
    return fwp_p_put_owned(s, NULL);
}''')
name = 'src/ownership.rs'
change(name, '    OwnedAttempt,', '''    OwnedAttempt,
    /// Typed State slots retain their own references and return owned aliases.
    OwnedState,''')
anchor = '        // Raw address words are not managed owners.'
change(name, anchor, '''        "get" | "put" => (&[B], ResultOwnership::OwnedState, None, &[]),
        "modify" => (&[B], ResultOwnership::OwnedState, Some(Callback::Borrowed(0)), &[]),
        "run-state" => (&[B, B, B], ResultOwnership::OwnedState, Some(Callback::Borrowed(1)), &[0, 1, 2]),
''' + anchor)
name = 'src/cgen.rs'
anchor = '                            ResultOwnership::OwnedAttempt => {'
change(name, anchor, '''                            ResultOwnership::OwnedState => {
                                let returned = func.ty.params(func.arity as usize).1.clone();
                                match sym.as_str() {
                                    "get" => {
                                        let dup = if crate::rc::needs_rc(&self.prog.shapes, &returned) {
                                            self.value_dup(&returned)
                                        } else { "NULL" };
                                        s = format!("return fwp_p_get_owned({dup});");
                                    }
                                    "put" => {
                                        let state = &func.locals[0];
                                        let dup = if crate::rc::needs_rc(&self.prog.shapes, state) {
                                            self.value_dup(state)
                                        } else { "NULL" };
                                        s = format!("return fwp_p_put_owned(l0, {dup});");
                                    }
                                    "modify" => {
                                        let state = func.locals[0].params(1).1.clone();
                                        let dup = if crate::rc::needs_rc(&self.prog.shapes, &state) {
                                            self.value_dup(&state)
                                        } else { "NULL" };
                                        let drop = self.value_drop(&state);
                                        s = format!("return fwp_p_modify_owned(l0, {dup}, {drop});");
                                    }
                                    "run-state" => {
                                        let MT::Record(fields) = &returned else {
                                            return Err("run-state has a non-pair result".into());
                                        };
                                        if fields.len() != 2 || fields[1].1 != func.locals[0] {
                                            return Err("run-state result lacks its state type".into());
                                        }
                                        let state = &func.locals[0];
                                        let dup = if crate::rc::needs_rc(&self.prog.shapes, state) {
                                            self.value_dup(state)
                                        } else { "NULL" };
                                        let drop_state = self.value_drop(state);
                                        let drop_result = self.value_drop(&fields[0].1);
                                        s = format!("return fwp_p_run_state_owned(l0, l1, l2, {dup}, {drop_state}, {drop_result});");
                                    }
                                    _ => return Err(format!("unmodeled State contract: {sym}")),
                                }
                            }
''' + anchor)
Path('/private/tmp/fwp-typed-state-ownership-patch.json').write_text(json.dumps(patches, indent=2) + '\n')
record = dict(base='9550aab94bf5cb2adb4f6a462381537d37ce3644',
    sourceHashes={name: hashlib.sha256((BASE/name).read_bytes()).hexdigest() for name in patches},
    draftHashes={name: hashlib.sha256((OUT/name).read_bytes()).hexdigest() for name in patches},
    stage='Exact-source draft prepared; no compiled or runtime checks executed')
Path('/private/tmp/fwp-typed-state-preparation.json').write_text(json.dumps(record, indent=2) + '\n')
print('Prepared five typed State source transforms; runner validation pending')
