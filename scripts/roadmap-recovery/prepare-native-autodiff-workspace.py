"""Prepare a single bounded numeric workspace cache with explicit owners."""
from pathlib import Path
base=Path('/private/tmp/fwp-phase4-ad-draft/fwp_rt_kernel.c');out=Path('/private/tmp/fwp-phase4-ad-workspace-draft');out.mkdir(exist_ok=True)
s=base.read_text()
s=s.replace('''    double *da, *db;
    fwp_tape_scope *scope;''','''    double *da, *db, *adj;
    int64_t adjcap;
    fwp_tape_scope *scope;''')
s=s.replace('''static int64_t fwp_ntapes = 0;''','''static int64_t fwp_ntapes = 0;
static void fwp_tape_retire(fwp_tape *t);
static void fwp_tape_finish(void);''')
a='''        t->live = 0;
        free(t->pa);free(t->pb);free(t->da);free(t->db);
        t->pa = t->pb = 0;t->da = t->db = 0;
        t->len = t->cap = t->leaves = 0;''';assert s.count(a)==1;s=s.replace(a,'''        fwp_tape_retire(t);''')
a=s.index('typedef struct {\n    int32_t *pa, *pb;');b=s.index('\nstatic void *fwp_k_malloc',a)
s=s[:a]+'''typedef struct {
    int32_t *pa, *pb;
    double *da, *db, *adj;
    int64_t cap, adjcap;
} fwp_tape_buffers;

/* A single detached owner bounds idle memory even across many tape slots. */
#define FWP_AD_WORKSPACE_BUDGET ((size_t)512 * 1024)
static fwp_tape_buffers fwp_tape_workspace;
static size_t fwp_tape_cached_bytes;
static int fwp_tape_workspace_enabled(void) {
    const char *setting = getenv("FWP_AD_WORKSPACE");
    return !setting || strcmp(setting, "0") != 0;
}
static void fwp_tape_buffers_dispose(fwp_tape_buffers *b) {
    free(b->pa);
    free(b->pb);
    free(b->da);
    free(b->db);
    free(b->adj);
    memset(b, 0, sizeof *b);
}
static size_t fwp_tape_workspace_size(const fwp_tape_buffers *b) {
    if (b->cap < 0 || b->adjcap < 0 || (uint64_t)b->cap > FWP_AD_WORKSPACE_BUDGET / 24) return SIZE_MAX;
    size_t nodes = (size_t)b->cap * 24;
    if ((uint64_t)b->adjcap > (FWP_AD_WORKSPACE_BUDGET - nodes) / sizeof(double)) return SIZE_MAX;
    return nodes + (size_t)b->adjcap * sizeof(double);
}
static void fwp_tape_buffers_release(void *arg) {
    fwp_tape_buffers *b = (fwp_tape_buffers *)arg;
    size_t bytes = fwp_tape_workspace_size(b);
    if (fwp_tape_workspace_enabled() && bytes && bytes <= FWP_AD_WORKSPACE_BUDGET) {
        fwp_tape_buffers_dispose(&fwp_tape_workspace);
        fwp_tape_workspace = *b;
        fwp_tape_cached_bytes = bytes;
        memset(b, 0, sizeof *b);
    } else fwp_tape_buffers_dispose(b);
}
static void fwp_tape_retire(fwp_tape *t) {
    fwp_tape_buffers buffers = {t->pa, t->pb, t->da, t->db, t->adj, t->cap, t->adjcap};
    t->pa = t->pb = 0;t->da = t->db = t->adj = 0;
    t->live = 0;t->len = t->cap = t->leaves = t->adjcap = 0;
    fwp_tape_buffers_release(&buffers);
}
static void fwp_tape_finish(void) {
    /* Shutdown releases both the bounded cache and unscoped live tapes. */
    fwp_tape_buffers_dispose(&fwp_tape_workspace);fwp_tape_cached_bytes = 0;
    for (int64_t i = 0; i < fwp_ntapes; i++) {
        fwp_tape *t = &fwp_tapes[i];
        fwp_tape_buffers buffers = {t->pa, t->pb, t->da, t->db, t->adj, t->cap, t->adjcap};
        fwp_tape_buffers_dispose(&buffers);
    }
    free(fwp_tapes);fwp_tapes = 0;fwp_ntapes = 0;
}
'''+s[b:]
a='''    free(t->pa);free(t->pb);free(t->da);free(t->db);
    t->pa = t->pb = 0;t->da = t->db = 0;
    t->live = 0;t->len = t->cap = t->leaves = 0;''';assert s.count(a)==1;s=s.replace(a,'''    free(t->pa);free(t->pb);free(t->da);free(t->db);free(t->adj);
    t->pa = t->pb = 0;t->da = t->db = t->adj = 0;
    t->live = 0;t->len = t->cap = t->leaves = t->adjcap = 0;''')
a='''    int64_t slot = 0;
    while (slot < fwp_ntapes''';b='''    static int registered_finish;
    if (!registered_finish) {
        if (atexit(fwp_tape_finish)) { fprintf(stderr, "fwp: out of memory\\n");exit(102); }
        registered_finish = 1;
    }
    int64_t slot = 0;
    while (slot < fwp_ntapes''';assert s.count(a)==1;s=s.replace(a,b)
a='''    fwp_tape *t = &fwp_tapes[slot];
    t->gen++;''';b='''    fwp_tape *t = &fwp_tapes[slot];
    if (fwp_tape_workspace_enabled() && fwp_tape_cached_bytes) {
        t->pa = fwp_tape_workspace.pa;t->pb = fwp_tape_workspace.pb;
        t->da = fwp_tape_workspace.da;t->db = fwp_tape_workspace.db;t->adj = fwp_tape_workspace.adj;
        t->cap = fwp_tape_workspace.cap;t->adjcap = fwp_tape_workspace.adjcap;
        memset(&fwp_tape_workspace, 0, sizeof fwp_tape_workspace);fwp_tape_cached_bytes = 0;
    }
    t->gen++;''';assert s.count(a)==1;s=s.replace(a,b)
a='''    t->da = t->db = 0;
    t->len = t->cap = t->leaves = 0;
    fwp_tape_buffers buffers = {tp.pa, tp.pb, tp.da, tp.db, 0};''';b='''    t->da = t->db = t->adj = 0;
    t->len = t->cap = t->leaves = t->adjcap = 0;
    fwp_tape_buffers buffers = {tp.pa, tp.pb, tp.da, tp.db, tp.adj, tp.cap, tp.adjcap};''';assert s.count(a)==1;s=s.replace(a,b)
a='''    double *adj = (double *)calloc((size_t)(tp.len ? tp.len : 1), sizeof(double));
    buffers.adj = adj;
    if (!adj) {''';b='''    int64_t needed = tp.len ? tp.len : 1;
    double *adj = buffers.adj;
    if (buffers.adjcap < needed) {
        int64_t capacity = tp.cap > needed ? tp.cap : needed;
        adj = buffers.adj ? (double *)realloc(buffers.adj, (size_t)capacity * sizeof(double))
                          : (double *)calloc((size_t)capacity, sizeof(double));
        if (adj) { buffers.adj = adj;buffers.adjcap = capacity; }
    }
    if (!adj) {''';assert s.count(a)==1;s=s.replace(a,b)
a='''    size_t no = fwp_array_len(outs), ns = fwp_array_len(seeds), m = no < ns ? no : ns;''';assert s.count(a)==1;s=s.replace(a,'''    memset(adj, 0, (size_t)needed * sizeof(double));
'''+a)
(out/'fwp_rt_kernel.c').write_text(s)
print('Prepared bounded native workspace ownership; requires cold/warm, unwind, reentrancy and shutdown controls')
