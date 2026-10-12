from pathlib import Path
p=Path('/private/tmp/fwp-numeric-fusion-workspace-evidence/source/numerics.rs')
assert p.exists()
s=p.read_text().replace('    db: Vec<f64>,\n}', '    db: Vec<f64>,\n    adj: Vec<f64>,\n}',1)
anchor='static TAPES: Mutex<Vec<Tape>> = Mutex::new(Vec::new());'
insert='''

const TAPE_WORKSPACE_BUDGET: usize = 512 * 1024;
static TAPE_WORKSPACE: Mutex<Option<Tape>> = Mutex::new(None);

fn workspace_enabled() -> bool {
    std::env::var("FWP_AD_WORKSPACE").as_deref() != Ok("0")
}

impl Tape {
    fn workspace_bytes(&self) -> usize {
        self.pa.capacity().saturating_add(self.pb.capacity()).saturating_mul(4)
            .saturating_add(self.da.capacity().saturating_add(self.db.capacity())
                .saturating_add(self.adj.capacity()).saturating_mul(8))
    }
}

fn recycle_workspace(mut tape: Tape) {
    if !workspace_enabled() || tape.workspace_bytes() > TAPE_WORKSPACE_BUDGET {
        return;
    }
    tape.gen = 0;
    tape.live = false;
    tape.leaves = 0;
    tape.pa.clear();
    tape.pb.clear();
    tape.da.clear();
    tape.db.clear();
    tape.adj.clear();
    *TAPE_WORKSPACE.lock().unwrap() = Some(tape);
}

struct TapeOwner(Tape);
impl Drop for TapeOwner {
    fn drop(&mut self) {
        recycle_workspace(std::mem::take(&mut self.0));
    }
}

fn reserve_nodes(tape: &mut Tape, required: usize) {
    let target = required.max(tape.pa.capacity().saturating_mul(2).max(64))
        .min(tape_limit());
    macro_rules! grow {
        ($field:ident) => {
            if tape.$field.capacity() < required {
                tape.$field.reserve_exact(target - tape.$field.len());
            }
        };
    }
    grow!(pa);
    grow!(pb);
    grow!(da);
    grow!(db);
}
'''
s=s.replace(anchor,anchor+insert)
s=s.replace('                tapes[slot].gen = tape.gen;','                tapes[slot].gen = tape.gen;\n                recycle_workspace(tape);',1)
a=s.index('    let t = &mut tapes[slot];',s.index('fn tape_new'));b=s.index('    let id = ',a)
s=s[:a]+'''    let gen = tapes[slot].gen + 1;
    let mut workspace = if workspace_enabled() {
        TAPE_WORKSPACE.lock().unwrap().take().unwrap_or_default()
    } else {
        Tape::default()
    };
    reserve_nodes(&mut workspace, n as usize);
    workspace.pa.resize(n as usize, -1);
    workspace.pb.resize(n as usize, -1);
    workspace.da.resize(n as usize, 0.0);
    workspace.db.resize(n as usize, 0.0);
    workspace.gen = gen;
    workspace.live = true;
    workspace.leaves = n as usize;
    tapes[slot] = workspace;
    let t = &tapes[slot];
'''+s[b:]
s=s.replace('    t.pa.push((ra & 0xffff_ffff) as i32);','    reserve_nodes(t, idx + 1);\n    t.pa.push((ra & 0xffff_ffff) as i32);',1)
a=s.index('    let mut adj = vec![0.0f64; t.pa.len()];',s.index('fn backward'));b=s.index('\n}\n',a)
body=s[a:b]
body=body.replace('    let mut adj = vec![0.0f64; t.pa.len()];','''    let mut owner = TapeOwner(t);
    let t = &mut owner.0;
    if t.adj.capacity() < t.pa.len() {
        t.adj.reserve_exact(t.pa.len() - t.adj.len());
    }
    t.adj.resize(t.pa.len(), 0.0);
    t.adj.fill(0.0);
    let adj = &mut t.adj;''').replace('    adj.truncate(t.leaves);\n    Ok(adj)','    Ok(adj[..t.leaves].to_vec())')
s=s[:a]+body+s[b:]
# Buffer identity controls verify reuse, zeroing, exceptional return and bounds.
pos=s.rfind('\n}')
s=s[:pos]+'''
    #[test]
    fn workspace_reuse_clears_adjoint_and_preserves_token_lifetimes() {
        let _serial = TAPE_TEST_LOCK.lock().unwrap();
        if !workspace_enabled() { return; }
        *TAPE_WORKSPACE.lock().unwrap() = None;
        let first = tape_new(129).unwrap();
        let node = push(first, 4.0, first + 1, 5.0).unwrap();
        assert_eq!(backward(first, &[node], &[2.0]).unwrap()[..2], [8.0, 10.0]);
        let pointers = {
            let pool = TAPE_WORKSPACE.lock().unwrap();
            let t = pool.as_ref().unwrap();
            assert!(t.workspace_bytes() <= TAPE_WORKSPACE_BUDGET);
            (t.pa.as_ptr(), t.pb.as_ptr(), t.da.as_ptr(), t.db.as_ptr(), t.adj.as_ptr())
        };
        let second = tape_new(129).unwrap();
        assert_ne!(first, second);
        let slot = ((second >> 32) & 0xffff) as usize - 1;
        {
            let tapes = TAPES.lock().unwrap();
            let t = &tapes[slot];
            assert_eq!((t.pa.as_ptr(), t.pb.as_ptr(), t.da.as_ptr(), t.db.as_ptr(), t.adj.as_ptr()), pointers);
        }
        assert_eq!(backward(second, &[second], &[3.0]).unwrap()[..2], [3.0, 0.0]);
        expect_trap(backward(first, &[], &[]), USED_OUTSIDE);
        let failed = tape_new(129).unwrap();
        expect_trap(backward(failed, &[failed + 129], &[1.0]), INVALID_NODE);
        assert!(TAPE_WORKSPACE.lock().unwrap().is_some());
        let current = tape_new(129).unwrap();
        assert!(backward(current, &[], &[]).unwrap().iter().all(|v| v.to_bits() == 0));
        *TAPE_WORKSPACE.lock().unwrap() = None;
        let large = tape_new(32769).unwrap();
        backward(large, &[], &[]).unwrap();
        assert!(TAPE_WORKSPACE.lock().unwrap().is_none());
    }
'''+s[pos:]
out=Path('/private/tmp/fwp-phase4-ad-workspace-draft/numerics.rs');out.write_text(s)
print('Prepared bounded interpreter workspace and lifetime regression controls')
