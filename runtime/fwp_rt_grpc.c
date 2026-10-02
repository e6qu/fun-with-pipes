/* fwp runtime: services (see docs/services.md and src/services.rs, the
 * interpreter's side). A client stub encodes its arguments canonically,
 * transcodes them to a protobuf request and makes a gRPC unary call; a
 * service executable serves a module's exported functions. Embedded only
 * in programs that call or serve services. */

#ifndef __wasi__

/* a function served by another process */
typedef struct {
    const char *what;          /* module.function, for messages */
    const char *path;          /* the gRPC path */
    const char *env;           /* FWP_SERVICE_<MODULE> */
    const char *default_addr;
    const char *fingerprint;
    int arity;
    const fwp_desc *const *params;
    const fwp_desc *result;
    const fwp_desc *error;     /* 0 when the function cannot fail */
    const int *schema;
    int req, resp;             /* schema nodes */
} fwp_remote;

static void fwp_trapf(const char *fmt, ...) {
    char buf[1024];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, sizeof buf, fmt, ap);
    va_end(ap);
    fwp_trap(buf);
}

static V fwp_remote_call(const fwp_remote *r, V *args) {
    fwp_buf canon = {0};
    for (int i = 0; i < r->arity; i++) fwp_encode(&canon, args[i], r->params[i]);
    h2_buf req = {0}, resp = {0}, out = {0};
    if (!pb_encode(r->schema, r->req, (const unsigned char *)canon.d, canon.len, &req))
        fwp_trapf("cannot encode the arguments of %s: %s", r->what, h2_err);
    free(canon.d);
    const char *addr = getenv(r->env);
    if (!addr || !*addr) addr = r->default_addr;
    int rc = h2_call(addr, r->path, r->fingerprint, req.d, req.len, &resp);
    h2b_free(&req);
    if (rc == GRPC_INTERNAL && strncmp(h2_err, "trap: ", 6) == 0) fwp_trap(h2_err + 6);
    if (rc < 0) fwp_trapf("service call %s (%s) failed: %s", r->what, addr, h2_err);
    if (rc > 0) fwp_trapf("service call %s (%s) failed: gRPC status %d: %s", r->what, addr, rc, h2_err);
    if (!pb_decode(r->schema, r->resp, resp.d, resp.len, &out))
        fwp_trapf("bad response from %s (%s): %s", r->what, addr, h2_err);
    h2b_free(&resp);
    fwp_rd rd = {out.d, out.len, 0};
    V v;
    if (r->error) {
        uint64_t tag;
        if (!rd_leb(&rd, &tag)) fwp_trapf("bad response from %s (%s): truncated value", r->what, addr);
        if (tag == 1) {
            if (!fwp_decode(&rd, r->error, &v)) fwp_trapf("bad response from %s (%s): truncated value", r->what, addr);
            h2b_free(&out);
            fwp_fail(v, r->error);
        }
    }
    if (!fwp_decode(&rd, r->result, &v)) fwp_trapf("bad response from %s (%s): truncated value", r->what, addr);
    h2b_free(&out);
    return v;
}

/* ------------------------------------------------------------------ server */

typedef struct {
    const char *name, *path, *fingerprint;
    uint32_t fn;
    int arity;
    const fwp_desc *const *params;
    const fwp_desc *result, *error;
    int req, resp;
} fwp_method;

typedef struct {
    const char *module, *env, *default_addr;
    const int *schema;
    int n;
    const fwp_method *methods;
} fwp_service;

/* traps are recoverable in the root task (the call being served) */
static int fwp_trap_in_root(void) { return fwp_cur == 0 || fwp_cur == fwp_root; }

static char *fwp_strdupf(const char *fmt, ...) {
    char buf[1024];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, sizeof buf, fmt, ap);
    va_end(ap);
    return strdup(buf);
}

static int fwp_service_call(void *ctx, const char *path, const h2_hdrs *hs, const unsigned char *msg, size_t n,
                            h2_buf *out, char **err) {
    const fwp_service *s = (const fwp_service *)ctx;
    const fwp_method *m = 0;
    for (int i = 0; i < s->n; i++)
        if (strcmp(s->methods[i].path, path) == 0) m = &s->methods[i];
    if (!m) { *err = fwp_strdupf("unknown method %s", path); return GRPC_UNIMPLEMENTED; }
    const char *fp = h2_get(hs, "fwp-fingerprint");
    if (fp && strcmp(fp, m->fingerprint) != 0) {
        *err = fwp_strdupf("interface mismatch: the caller of %s.%s was built against a different version of it",
                           s->module, m->name);
        return GRPC_FAILED_PRECONDITION;
    }
    h2_buf canon = {0};
    if (!pb_decode(s->schema, m->req, msg, n, &canon)) {
        h2b_free(&canon);
        *err = strdup(h2_err);
        return GRPC_INVALID_ARGUMENT;
    }
    fwp_rd rd = {canon.d, canon.len, 0};
    V *args = (V *)fwp_alloc((size_t)(m->arity + 1) * sizeof(V));
    for (int i = 0; i < m->arity; i++)
        if (!fwp_decode(&rd, m->params[i], &args[i])) {
            h2b_free(&canon);
            *err = strdup("truncated value");
            return GRPC_INVALID_ARGUMENT;
        }
    h2b_free(&canon);
    fwp_buf res = {0};
    int status = 0;
    jmp_buf tj;
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = fwp_state_len;
    fwp_trap_jb = &tj;
    if (setjmp(tj) != 0) {
        fwp_trap_jb = 0;
        fwp_handlers = h.prev;
        fwp_state_len = h.state_depth;
        fwp_tasks_abort();
        fflush(fwp_prog_out);
        fprintf(stderr, "fwp: trap: %s (in %s.%s)\n", fwp_trap_msg, s->module, m->name);
        *err = fwp_strdupf("trap: %s", fwp_trap_msg);
        free(res.d);
        return GRPC_INTERNAL;
    }
    fwp_handlers = &h;
    if (setjmp(h.jb) == 0) {
        V r = fwp_apply(fwp_pap(m->fn, 0, args), (uint32_t)m->arity, args);
        fwp_handlers = h.prev;
        fwp_tasks_finish();
        if (m->error) buf_putc(&res, 0);
        fwp_encode(&res, r, m->result);
    } else {
        fwp_handlers = h.prev;
        fwp_state_len = h.state_depth;
        fwp_tasks_abort();
        if (m->error) {
            buf_putc(&res, 1);
            fwp_encode(&res, h.value, m->error);
        } else {
            fwp_buf b = {0};
            fwp_write(&b, h.value, h.desc, 1);
            *err = fwp_strdupf("error: %.*s", (int)b.len, b.d ? b.d : "");
            free(b.d);
            status = GRPC_INTERNAL;
        }
    }
    fwp_trap_jb = 0;
    fflush(fwp_prog_out);
    if (status == 0 && !pb_encode(s->schema, m->resp, (const unsigned char *)res.d, res.len, out)) {
        *err = strdup(h2_err);
        status = GRPC_INTERNAL;
    }
    free(res.d);
    return status;
}

static int fwp_serve(const fwp_service *s, int argc, char **argv) {
    const char *listen_at = 0;
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--listen") == 0 && i + 1 < argc) listen_at = argv[++i];
        else if (strncmp(argv[i], "--listen=", 9) == 0) listen_at = argv[i] + 9;
        else {
            fprintf(stderr, "usage: %s [--listen host:port]\n", argv[0]);
            return 2;
        }
    }
    if (!listen_at) {
        listen_at = getenv(s->env);
        if (!listen_at || !*listen_at) listen_at = s->default_addr;
    }
    char bound[300];
    int fd = h2_listen(listen_at, bound, sizeof bound);
    if (fd < 0) {
        fprintf(stderr, "fwp serve: %s\n", h2_err);
        return 1;
    }
    fprintf(stderr, "fwp: service %s listening on %s\n", s->module, bound);
    fflush(stderr);
    fwp_trap_recover = fwp_trap_in_root;
    h2_serve(fd, fwp_service_call, (void *)s);
    fprintf(stderr, "fwp serve: %s\n", h2_err);
    return 1;
}

#endif /* __wasi__ */
