"""Prepare checked tape capacities and preserve owners on allocator failure."""
from pathlib import Path
out=Path('/private/tmp/fwp-phase4-ad-draft');out.mkdir(exist_ok=True)
s=Path('/private/tmp/fwp-phase4-source/runtime/fwp_rt_kernel.c').read_text()
a=s.index('static void fwp_tape_reserve(');b=s.index('\nstatic V fwp_p_ad_tape',a)
s=s[:a]+'''/* Match Rust Vec's byte bound, independently of native pointer width. */
static int64_t fwp_tape_limit(void) {
    size_t limit = (size_t)PTRDIFF_MAX / sizeof(double);
    return limit < (size_t)INT32_MAX ? (int64_t)limit : INT32_MAX;
}

static void fwp_tape_reserve(fwp_tape *t, int64_t n) {
    int64_t limit = fwp_tape_limit();
    if (n < 0 || n > limit) fwp_trap("autodiff: the tape is full");
    if (n <= t->cap) return;
    int64_t cap = t->cap ? t->cap : (limit < 64 ? limit : 64);
    while (cap < n) cap = cap > limit / 2 ? limit : cap * 2;
    /* Commit each successful realloc; a failed call still owns the old buffer. */
    void *next = realloc(t->pa, (size_t)cap * sizeof(int32_t));
    if (!next) goto oom;
    t->pa = (int32_t *)next;
    next = realloc(t->pb, (size_t)cap * sizeof(int32_t));
    if (!next) goto oom;
    t->pb = (int32_t *)next;
    next = realloc(t->da, (size_t)cap * sizeof(double));
    if (!next) goto oom;
    t->da = (double *)next;
    next = realloc(t->db, (size_t)cap * sizeof(double));
    if (!next) goto oom;
    t->db = (double *)next;
    t->cap = cap;
    return;
oom:
    fwp_tape_unlink_scope(t);
    free(t->pa);free(t->pb);free(t->da);free(t->db);
    t->pa = t->pb = 0;t->da = t->db = 0;
    t->live = 0;t->len = t->cap = t->leaves = 0;
    fprintf(stderr, "fwp: out of memory\\n");
    exit(102);
}
'''+s[b:]
s=s.replace('if (n < 0 || n > INT32_MAX) fwp_trap("autodiff: too many inputs");','if (n < 0 || n > fwp_tape_limit()) fwp_trap("autodiff: too many inputs");')
a='''        fwp_tapes = (fwp_tape *)realloc(fwp_tapes, (size_t)(fwp_ntapes + 1) * sizeof(fwp_tape));
        if (!fwp_tapes) {''';b='''        fwp_tape *next = (fwp_tape *)realloc(fwp_tapes, (size_t)(fwp_ntapes + 1) * sizeof(fwp_tape));
        if (!next) {''';assert a in s;s=s.replace(a,b)
a='''        memset(&fwp_tapes[fwp_ntapes], 0, sizeof(fwp_tape));''';assert a in s;s=s.replace(a,'''        fwp_tapes = next;
'''+a)
s=s.replace('if (idx >= INT32_MAX) fwp_trap("autodiff: the tape is full");','if (idx >= fwp_tape_limit()) fwp_trap("autodiff: the tape is full");')
(out/'fwp_rt_kernel.c').write_text(s)
s=Path('/private/tmp/fwp-phase4-ad-source/src/numerics.rs').read_text()
a='''/// `ad.tape n`: a new tape whose first n nodes are the inputs.''';assert a in s;s=s.replace(a,'''fn tape_limit() -> usize {
    (isize::MAX as usize / std::mem::size_of::<f64>()).min(i32::MAX as usize)
}

'''+a).replace('if !(0..=i32::MAX as i64).contains(&n) {','if !(0..=tape_limit() as i64).contains(&n) {').replace('if idx >= i32::MAX as usize {','if idx >= tape_limit() {')
(out/'numerics.rs').write_text(s)
print('Prepared matching native/interpreter tape bounds and owned realloc failure cleanup')
