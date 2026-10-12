"""Prepare zero-byte record count and target-width decoding repairs."""
from pathlib import Path
BASE=Path('/private/tmp/fwp-numeric-representation-phase2-candidate-source')
OUT=Path('/private/tmp/fwp-packed-array-runtime-draft')
s=(BASE/'src/proto.rs').read_text()
s=s.replace('let n = r.leb128()? as usize;', 'let n = usize::try_from(r.leb128()?).map_err(|_| "truncated value")?;')
s=s.replace('let tag = r.leb128()? as usize;', 'let tag = usize::try_from(r.leb128()?).map_err(|_| "bad constructor tag")?;')
a=s.index('    /// An element count:');b=s.index('    fn arr<const N:',a)
s=s[:a]+'''    /// Check wire and allocation bounds before constructing a collection.
    fn count(&mut self, empty_wire: bool, unique: bool) -> Result<usize, String> {
        let n = self.leb128()?;
        if n > (isize::MAX as usize / std::mem::size_of::<Value>()) as u64
            || (!empty_wire && n > self.data.len() as u64)
            || (empty_wire && unique && n > 1)
        {
            return Err("truncated value".into());
        }
        Ok(n as usize)
    }

'''+s[b:]
marker='pub fn decode('
at=s.index(marker)
# Keep the existing decode documentation attached to decode itself.
at=s.rfind('///',0,at)
s=s[:at]+'''fn wire_empty(mt: &MT, prog: &Program) -> bool {
    fn inner<'a>(mt: &'a MT, prog: &'a Program, path: &mut Vec<&'a MT>) -> bool {
        if path.contains(&mt) { return false; }
        let fields = match mt {
            MT::Record(fields) => fields,
            _ => match prog.shapes.get(mt) {
                Some(TypeShape::Record(fields)) => fields,
                _ => return false,
            },
        };
        path.push(mt);
        let empty = fields.iter().all(|(_, field)| inner(field, prog, path));
        path.pop();
        empty
    }
    inner(mt, prog, &mut Vec::new())
}

'''+s[at:]
s=s.replace('let n = r.count()?;\n                let t = args.first().cloned().unwrap_or(MT::unit());\n                let mut items = Vec::new();', '''let t = args.first().cloned().unwrap_or(MT::unit());
                let empty_wire = wire_empty(&t, prog);
                let n = r.count(empty_wire, false)?;
                let mut items = Vec::new();
                if empty_wire {
                    items.try_reserve_exact(n).map_err(|_| "allocation failed")?;
                }''')
s=s.replace('let n = r.count()?;\n                let kt = args.first().cloned().unwrap_or(MT::unit());\n                let vt = args.get(1).cloned().unwrap_or(MT::unit());', '''let kt = args.first().cloned().unwrap_or(MT::unit());
                let vt = args.get(1).cloned().unwrap_or(MT::unit());
                let empty_wire = wire_empty(&kt, prog)
                    && (prim(mt) == "Set" || wire_empty(&vt, prog));
                let n = r.count(empty_wire, true)?;''')
(OUT/'proto.rs').write_text(s)
s=(OUT/'fwp_rt_exec.c').read_text()
marker='static int fwp_decode(fwp_rd *r, const fwp_desc *d, V *out) {'
assert 'fwp_decode_count(' not in s
s=s.replace(marker,Path('/private/tmp/fwp-protocol-empty-wire-draft.c').read_text()+'\n'+marker)
a=s.index('    case K_LIST: case K_ARRAY: {',s.index(marker));b=s.index('    case K_RECORD: {',a)
part=s[a:b];assert part.count('if (!rd_leb(r, &x) || x > r->n) return 0;')==2
part=part.replace('if (!rd_leb(r, &x) || x > r->n) return 0;', 'if (!fwp_decode_count(r, d->elem, 0, &x)) return 0;',1)
part=part.replace('if (!rd_leb(r, &x) || x > r->n) return 0;', '''int empty_values = d->kind == K_SET || fwp_wire_empty_inner(d->elem2, 0);
        if (!fwp_decode_count(r, d->elem, empty_values, &x)) return 0;''')
# A map with an empty key and nonempty value still needs the byte-count bound.
part=part.replace('if (!fwp_decode_count(r, d->elem, empty_values, &x)) return 0;', 'if (!fwp_decode_count(r, d->elem, empty_values, &x) || (!empty_values && x > r->n)) return 0;')
part=part.replace('''        V *items = (V *)fwp_alloc((size_t)(x + 1) * sizeof(V));''','''        if (d->kind == K_ARRAY) {
            V array = fwp_array_new_packed((size_t)x, d->elem);
            for (size_t i = 0; i < (size_t)x; i++) {
                V value;
                if (!fwp_decode(r, d->elem, &value)) return 0;
                fwp_array_store(array, i, value, d->elem);
            }
            *out = array; FWP_KEEP_ALIVE(array); return 1;
        }
        V *items = (V *)fwp_alloc((size_t)(x + 1) * sizeof(V));''')
part=part.replace('*out = d->kind == K_ARRAY ? fwp_p_array_from_list_with_elem(l, d->elem) : l;', '*out = l;')
s=s[:a]+part+s[b:];(OUT/'fwp_rt_exec.c').write_text(s)
print('Prepared zero-byte record counts and checked target-width decoding; runner controls pending')
