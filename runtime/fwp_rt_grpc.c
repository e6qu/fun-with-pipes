/* fwp runtime: gRPC (see docs/grpc.md, and src/grpc.rs for the
 * interpreter's side, which this file mirrors).
 *
 * HTTP/2 connections and streams run on the task scheduler
 * (fwp_rt_task.c). Every connection has a reader task, which parses frames,
 * updates the streams and wakes the tasks waiting on them (on a server it
 * starts a task per call), and a writer task, which sends the frames other
 * tasks append to the connection's output. A call waits only in its own
 * task: many calls share a connection, other tasks run meanwhile, and a
 * server runs its calls concurrently.
 *
 * Client stubs of split builds (fwp_remote_call), servers of exported
 * functions (fwp_serve) and of GrpcRoutes (grpc.serve), streaming,
 * deadlines, metadata, health checking, server reflection and the grpc.*
 * primitives. Embedded only in programs that use gRPC. */

#ifndef __wasi__

/* ------------------------------------------------------------ descriptions */

/* a function's RPC (src/rpc.rs): its request and response messages */
typedef struct {
    const char *name;          /* the function */
    const char *path;          /* the gRPC path */
    const char *fingerprint;
    int fn;                    /* the function (served methods) */
    int nreq;                  /* request arguments */
    const fwp_desc *const *req;
    const fwp_desc *resp;      /* a response's value */
    const fwp_desc *error;     /* the error in a response's oneof, or 0 */
    int input;                 /* 0: arguments, 1: a stream (Iterator) */
    int output;                /* 0: a value, 1: Iterator, 2: Channel */
    int status_errors;         /* Error[GrpcError]: errors are statuses */
    int iter_fn;               /* grpc._iter at the streamed type, or -1 */
    const int *schema;
    int req_node, resp_node;
    const fwp_desc *grpc_error;
} fwp_rpc;

/* a function served by another process */
typedef struct {
    const char *what;          /* module.function, for messages */
    const char *env;           /* FWP_SERVICE_<MODULE> */
    const char *default_addr;
    fwp_rpc m;
} fwp_remote;

/* a module's exported functions served over gRPC */
typedef struct {
    const char *module, *env, *default_addr;
    int n;
    const fwp_rpc *methods;
    const unsigned char *descriptor;   /* FileDescriptorProto, for reflection */
    size_t descriptor_len;
    const char *file, *package;
    int nservices;
    const char *const *services;       /* full service names */
    const fwp_desc *grpc_error;
    const unsigned char *health;       /* the health service's descriptor */
    size_t health_len;
} fwp_service;

/* ------------------------------------------------------------------- state */

typedef struct g_conn g_conn;
typedef struct g_stream g_stream;
typedef struct g_msg { struct g_msg *next; size_t n; unsigned char d[]; } g_msg;

struct g_stream {
    uint32_t id;
    h2_hdrs headers, trailers;
    h2_hdrs out_headers, out_trailers; /* a server's response metadata */
    int gzip;                  /* messages sent are compressed with gzip */
    int got_headers, got_data, remote_end, local_end, sent_headers, retry, listed;
    h2_buf data;
    g_msg *mhead, *mtail;
    char *reset, *bad;
    int64_t window;
    fwp_wl waiters;
    fwp_task *task;            /* the task serving the call */
    g_stream *next;
    int raw;                   /* an HTTP stream: its data is a body */
};

typedef struct g_server g_server;

struct g_conn {
    int fd, refs;
    SSL *ssl;                  /* the TLS session of a TLS connection */
    const g_server *server;    /* 0 for a client connection */
    char authority[256];       /* a client's: the address it was given */
    h2_hpack dec;
    h2_peer peer;
    int64_t conn_window;
    g_stream *streams;
    h2_buf out, in;
    uint32_t next_stream, last_stream;
    int cont, cont_end;
    uint32_t cont_id;
    h2_buf cont_buf;
    int preface, goaway;
    char *dead;
    fwp_wl writer_wl, space_wl;
    char *tlskey;              /* a client's TLS options (g_tls key), or 0 */
    g_conn *next_pool;
    void *web;                 /* an HTTP server connection's g_web
                                * (fwp_rt_http2.c), or 0 */
};

/* the call a server task is running */
typedef struct g_serving {
    h2_hdrs *headers;
    fwp_task *task;
    int code;                  /* a status for a cancelled call, or -1 */
    char *msg;
    char *peer;                /* the subject of the client's certificate, or 0 */
    size_t peer_users;          /* serving task plus detached language senders */
    g_stream *s;               /* the call's stream */
} g_serving;

static void g_serving_peer_release(g_serving *sv) {
    if (sv && --sv->peer_users == 0) {
        fwp_tls_subject_free(sv->peer);
        sv->peer = 0;
        free(sv->msg);
        sv->msg = 0;
    }
}

/* how a client's calls connect over TLS (`grpc.with-tls`, or the
 * FWP_SERVICE_<M>_CA, ... variables): malloc'ed strings ("" for none);
 * `key` tells connections with these options apart in the pool */
typedef struct {
    char *ca, *name, *cert, *keyfile, *key;
    int insecure;
} g_tls;

/* a task's gRPC context: metadata and deadline of the calls it makes, and
 * the call it serves */
typedef struct {
    const char **kv;
    size_t n;
    int64_t deadline;
    g_serving *serving;
    const g_tls *tls;
    h2_hdrs *capture;          /* response metadata collected, or 0 */
    int gzip;                  /* the calls made compress their requests */
} g_ctx;

static g_ctx g_empty_ctx;
static g_conn *g_pool = 0;
static const fwp_desc *g_grpc_error_desc = 0;

static g_ctx *g_ctx_of(void) {
    fwp_tasks_init();
    return fwp_cur->gctx ? (g_ctx *)fwp_cur->gctx : &g_empty_ctx;
}

static char *g_strdupf(const char *fmt, ...) {
    char buf[1024];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, sizeof buf, fmt, ap);
    va_end(ap);
    return strdup(buf);
}

static void g_trapf(const char *fmt, ...) {
    char buf[1024];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, sizeof buf, fmt, ap);
    va_end(ap);
    fwp_trap(buf);
}

static int64_t g_earliest(int64_t a, int64_t b) {
    if (!a) return b;
    if (!b) return a;
    return a < b ? a : b;
}

/* the current task was cancelled (or its deadline passed) */
static int g_cancelled(void) {
    fwp_task *t = fwp_cur;
    if (t->unwinding) return 0;
    if (t->deadline && !t->cancelled && fwp_now_ns() >= t->deadline) fwp_cancel_tree(t);
    return t->cancelled;
}

static void g_wake_conn(g_conn *c) {
    for (g_stream *s = c->streams; s; s = s->next) fwp_wake_all(&s->waiters);
    fwp_wake_all(&c->space_wl);
    fwp_wake_all(&c->writer_wl);
}

static g_stream *g_find(g_conn *c, uint32_t id) {
    for (g_stream *s = c->streams; s; s = s->next)
        if (s->id == id) return s;
    return 0;
}

static void g_unlink(g_conn *c, g_stream *s) {
    if (!s->listed) return;
    for (g_stream **p = &c->streams; *p; p = &(*p)->next)
        if (*p == s) { *p = s->next; break; }
    s->listed = 0;
    s->next = 0;
}

/* streams and connections are collected (runtime/fwp_rt_gc.c); their
 * malloc'ed buffers are released then */
static void g_stream_final(void *p) {
    g_stream *s = (g_stream *)p;
    h2_hdrs_free(&s->headers);
    h2_hdrs_free(&s->trailers);
    h2_hdrs_free(&s->out_headers);
    h2_hdrs_free(&s->out_trailers);
    h2b_free(&s->data);
    while (s->mhead) {
        g_msg *m = s->mhead;
        s->mhead = m->next;
        free(m);
    }
    free(s->reset);
    free(s->bad);
}

/* Nonallocating failure marker: no stream observes an unpublished connection. */
static char g_connect_start_failed[] = "connection startup failed";

static void g_conn_final(void *p) {
    g_conn *c = (g_conn *)p;
#ifdef FWP_LIBRARY
#ifdef FWP_TLS
    if (c->ssl) { fwp_tls_dispose(c->ssl); c->ssl = 0; }
#endif
    if (c->fd >= 0) { close(c->fd); c->fd = -1; }
#endif
    h2_hpack_free(&c->dec);
    h2b_free(&c->in);
    h2b_free(&c->out);
    h2b_free(&c->cont_buf);
    if (c->dead != g_connect_start_failed) free(c->dead);
    free(c->tlskey);
}

static g_stream *g_stream_new(g_conn *c, uint32_t id) {
    g_stream *s = (g_stream *)fwp_mem_alloc(sizeof *s);
    fwp_gc_finalizer(s, g_stream_final);
    s->id = id;
    s->window = c->peer.init_window;
    s->next = c->streams;
    c->streams = s;
    s->listed = 1;
    return s;
}

static void g_set_reset(g_stream *s, const char *why) {
    if (!s->reset) s->reset = strdup(why);
}

static g_conn *g_conn_new(int fd, const char *authority, const g_server *server) {
    g_conn *c = (g_conn *)fwp_mem_alloc(sizeof *c);
    fwp_gc_finalizer(c, g_conn_final);
    c->fd = fd;
    c->server = server;
    snprintf(c->authority, sizeof c->authority, "%s", authority);
    h2_hpack_init(&c->dec);
    c->peer.max_frame = 16384;
    c->peer.init_window = 65535;
    c->conn_window = 65535;
    c->next_stream = 1;
    if (!server) {
        h2b_put(&c->out, h2_preface, sizeof h2_preface - 1);
        c->preface = 1;
    }
    h2_our_settings(&c->out);
    return c;
}

/* A gRPC address and its transport: `tls://host:port` and
 * `grpcs://host:port` (or `https://`) are TLS, anything else (`host:port`,
 * `grpc://`, `http://`) cleartext h2c; as src/tls.rs `grpc_addr`. Sets
 * *tls and copies host:port to out. */
static void g_addr(const char *addr, int *tls, char *out, size_t n) {
    static const char *const pre[] = {"tls://", "grpcs://", "https://", "grpc://", "http://"};
    *tls = 0;
    for (int i = 0; i < 5; i++) {
        size_t l = strlen(pre[i]);
        if (strncmp(addr, pre[i], l) == 0) {
            *tls = i < 3;
            addr += l;
            break;
        }
    }
    snprintf(out, n, "%s", addr);
    size_t k = strlen(out);
    while (k > 0 && out[k - 1] == '/') out[--k] = 0;
}

/* reads and writes, through the TLS session of a TLS connection: as recv
 * and send, or -2 for a TLS failure (fwp_tls_err); *ww: wait to write */
static ssize_t g_io_recv(g_conn *c, void *buf, size_t n, int *ww) {
    *ww = 0;
    if (c->ssl) return fwp_tls_recv(c->ssl, (char *)buf, n, ww);
    return recv(c->fd, buf, n, 0);
}

static ssize_t g_io_send(g_conn *c, const void *buf, size_t n, int *ww) {
    *ww = 1;
    if (c->ssl) return fwp_tls_send(c->ssl, (const char *)buf, n, ww);
    return send(c->fd, buf, n, MSG_NOSIGNAL);
}

/* --------------------------------------------------------- reading frames */

typedef struct { g_stream **v; size_t n, cap; } g_slist;

static void g_slist_add(g_slist *l, g_stream *s) {
    if (l->n == l->cap) {
        size_t old = l->cap;
        l->cap = l->cap ? l->cap * 2 : 8;
        l->v = (g_stream **)fwp_mem_realloc(l->v, old * sizeof *l->v, l->cap * sizeof *l->v);
    }
    l->v[l->n++] = s;
}

static void g_goaway(g_conn *c, uint32_t code, const char *why, char **dead) {
    unsigned char p[8];
    for (int i = 0; i < 4; i++) p[i] = (unsigned char)(c->last_stream >> (24 - 8 * i));
    for (int i = 0; i < 4; i++) p[4 + i] = (unsigned char)(code >> (24 - 8 * i));
    h2_frame(&c->out, H2_GOAWAY, 0, 0, p, 8);
    if (!*dead) *dead = strdup(why);
}

static void g_split(g_stream *s) {
    while (s->data.len >= 5) {
        size_t n = h2_rd32(s->data.d + 1);
        if (s->data.len < 5 + n) break;
        const unsigned char *src = s->data.d + 5;
        h2_buf plain = {0};
        if (s->data.d[0] != 0) {
            /* compressed with the stream's grpc-encoding */
            const char *enc = h2_get(&s->headers, "grpc-encoding");
            if (!enc || strcmp(enc, "gzip") != 0) {
                if (!s->bad)
                    s->bad = enc ? g_strdupf("unsupported grpc-encoding `%s`", enc)
                                 : strdup("a compressed message without grpc-encoding");
                s->data.len = 0;
                return;
            }
            if (!h2_gunzip(src, n, &plain, H2_GZIP_MAX)) {
                if (!s->bad) s->bad = g_strdupf("bad compressed message: %s", h2_err);
                h2b_free(&plain);
                s->data.len = 0;
                return;
            }
            src = plain.d;
        }
        size_t mn = s->data.d[0] != 0 ? plain.len : n;
        g_msg *m = (g_msg *)malloc(sizeof(g_msg) + mn + 1);
        m->next = 0;
        m->n = mn;
        if (mn) memcpy(m->d, src, mn);
        h2b_free(&plain);
        if (s->mtail) s->mtail->next = m;
        else s->mhead = m;
        s->mtail = m;
        h2b_drop(&s->data, 5 + n);
    }
}

/* a request on an HTTP server connection (fwp_rt_http2.c) */
static void g_web_stream(g_conn *c, uint32_t sid, h2_hdrs *hs, int end, g_slist *fresh);

static void g_header_block(g_conn *c, uint32_t sid, const unsigned char *b, size_t n, int end, g_slist *fresh,
                           char **dead) {
    h2_hdrs hs = {0};
    if (!h2_hpack_decode(&c->dec, b, n, &hs)) {
        h2_hdrs_free(&hs);
        g_goaway(c, 9, "bad header block", dead); /* COMPRESSION_ERROR */
        return;
    }
    g_stream *s = g_find(c, sid);
    if (s) {
        if (!c->server) {
            if (!s->got_headers) { s->headers = hs; s->got_headers = 1; }
            else { h2_hdrs_free(&s->trailers); s->trailers = hs; }
        } else {
            h2_hdrs_free(&hs);
        }
        if (end) s->remote_end = 1;
        return;
    }
    if (c->web) { g_web_stream(c, sid, &hs, end, fresh); return; }
    if (!c->server || sid % 2 == 0 || sid <= c->last_stream) { h2_hdrs_free(&hs); return; }
    c->last_stream = sid;
    const char *method = h2_get(&hs, ":method"), *ct = h2_get(&hs, "content-type");
    if (!method || strcmp(method, "POST") != 0 || !ct || strncmp(ct, "application/grpc", 16) != 0) {
        h2_buf blk = {0};
        h2_hpack_lit(&blk, ":status", "415");
        h2_header_frames(&c->out, sid, &blk, 1, c->peer.max_frame);
        h2b_free(&blk);
        h2_hdrs_free(&hs);
        return;
    }
    s = g_stream_new(c, sid);
    s->headers = hs;
    s->remote_end = end;
    g_slist_add(fresh, s);
}

static void g_on_frame(g_conn *c, const h2_fr *f, g_slist *fresh, char **dead) {
    if (c->cont && (f->type != H2_CONTINUATION || f->stream != c->cont_id)) {
        g_goaway(c, 1, "protocol error", dead);
        return;
    }
    const unsigned char *p;
    size_t n;
    switch (f->type) {
    case H2_HEADERS:
        if (!h2_unpad(f, &p, &n)) { g_goaway(c, 1, "protocol error", dead); return; }
        if (f->flags & H2_END_HEADERS) {
            g_header_block(c, f->stream, p, n, f->flags & H2_END_STREAM, fresh, dead);
        } else {
            c->cont = 1;
            c->cont_id = f->stream;
            c->cont_end = f->flags & H2_END_STREAM;
            c->cont_buf.len = 0;
            h2b_put(&c->cont_buf, p, n);
        }
        return;
    case H2_CONTINUATION:
        if (!c->cont) { g_goaway(c, 1, "protocol error", dead); return; }
        h2b_put(&c->cont_buf, f->p, f->n);
        if (f->flags & H2_END_HEADERS) {
            c->cont = 0;
            g_header_block(c, c->cont_id, c->cont_buf.d, c->cont_buf.len, c->cont_end, fresh, dead);
        }
        return;
    case H2_DATA: {
        if (!h2_unpad(f, &p, &n)) { g_goaway(c, 1, "protocol error", dead); return; }
        int end = f->flags & H2_END_STREAM;
        unsigned char inc[4];
        for (int i = 0; i < 4; i++) inc[i] = (unsigned char)(f->n >> (24 - 8 * i));
        if (f->n > 0) h2_frame(&c->out, H2_WINDOW_UPDATE, 0, 0, inc, 4);
        g_stream *s = g_find(c, f->stream);
        if (!s) return;
        if (f->n > 0 && !end) h2_frame(&c->out, H2_WINDOW_UPDATE, 0, f->stream, inc, 4);
        s->got_data = 1;
        h2b_put(&s->data, p, n);
        if (!s->raw) g_split(s);
        if (end) {
            s->remote_end = 1;
            if (!s->raw && s->data.len && !s->bad) s->bad = strdup("truncated gRPC message");
        }
        return;
    }
    case H2_RST_STREAM: {
        g_stream *s = g_find(c, f->stream);
        if (!s) return;
        g_unlink(c, s);
        int code = f->n >= 4 ? f->p[3] : 0;
        if (c->server) {
            g_set_reset(s, "cancelled by the client");
        } else {
            char buf[400];
            snprintf(buf, sizeof buf, "stream reset by %s (code %d)", c->authority, code);
            g_set_reset(s, buf);
        }
        s->retry = code == 7 && !s->got_headers && !s->got_data; /* REFUSED_STREAM */
        if (s->task) { fwp_cancel_tree(s->task); s->task = 0; }
        fwp_wake_all(&s->waiters);
        return;
    }
    case H2_SETTINGS:
        if (f->stream != 0 || (f->flags & H2_ACK)) return;
        {
            int64_t delta;
            if (!h2_settings(&c->peer, f->p, f->n, &delta)) { g_goaway(c, 1, "bad SETTINGS frame", dead); return; }
            for (g_stream *s = c->streams; s; s = s->next) s->window += delta;
            h2_frame(&c->out, H2_SETTINGS, H2_ACK, 0, 0, 0);
        }
        return;
    case H2_PING:
        if (!(f->flags & H2_ACK)) h2_frame(&c->out, H2_PING, H2_ACK, 0, f->p, f->n);
        return;
    case H2_WINDOW_UPDATE:
        if (f->n == 4) {
            int64_t inc = h2_rd32(f->p) & 0x7fffffffu;
            if (f->stream == 0) {
                c->conn_window += inc;
            } else {
                g_stream *s = g_find(c, f->stream);
                if (s) s->window += inc;
            }
        }
        return;
    case H2_GOAWAY:
        if (f->n < 8) return;
        c->goaway = 1;
        if (!c->server && !c->web) {
            uint32_t last = h2_rd32(f->p) & 0x7fffffffu;
            char buf[300];
            snprintf(buf, sizeof buf, "%s is shutting down", c->authority);
            for (g_stream *s = c->streams, *nx; s; s = nx) {
                nx = s->next;
                if (s->id > last) {
                    g_unlink(c, s);
                    g_set_reset(s, buf);
                    s->retry = !s->got_headers && !s->got_data;
                    fwp_wake_all(&s->waiters);
                }
            }
        }
        return;
    }
}

/* parse what was read; streams of new calls go to `fresh` */
static void g_process(g_conn *c, const unsigned char *b, size_t n, g_slist *fresh, char **dead) {
    h2b_put(&c->in, b, n);
    if (!c->preface) {
        size_t pn = sizeof h2_preface - 1;
        size_t k = c->in.len < pn ? c->in.len : pn;
        if (memcmp(c->in.d, h2_preface, k) != 0) { *dead = strdup("not an HTTP/2 connection"); return; }
        if (c->in.len < pn) return;
        h2b_drop(&c->in, pn);
        c->preface = 1;
    }
    size_t at = 0;
    for (;;) {
        h2_buf view = {c->in.d + at, c->in.len - at, 0};
        h2_fr f;
        size_t size;
        int r = h2_parse(&view, &f, &size);
        if (r == 0) break;
        if (r < 0) { g_goaway(c, 6, "frame too large", dead); break; } /* FRAME_SIZE_ERROR */
        at += size;
        g_on_frame(c, &f, fresh, dead);
        if (*dead) break;
    }
    h2b_drop(&c->in, at);
}

static void g_conn_dead(g_conn *c, const char *why) {
    if (c->dead) return;
    c->dead = strdup(why);
    shutdown(c->fd, SHUT_RDWR);
    for (g_stream *s = c->streams; s; s = s->next) {
        g_set_reset(s, why);
        s->retry = !s->got_headers && !s->got_data;
        if (s->task) { fwp_cancel_tree(s->task); s->task = 0; }
        s->listed = 0;
        fwp_wake_all(&s->waiters);
    }
    c->streams = 0;
    for (g_conn **p = &g_pool; *p; p = &(*p)->next_pool)
        if (*p == c) { *p = c->next_pool; break; }
    fwp_wake_all(&c->space_wl);
    fwp_wake_all(&c->writer_wl);
}

/* the reader or the writer is done; the last one closes the socket */
static void g_conn_release(g_conn *c) {
    if (--c->refs > 0) return;
    fwp_fd_closing(c->fd);
    if (c->ssl) { fwp_tls_free(c->ssl); c->ssl = 0; }
    close(c->fd);
    c->fd = -1;
    h2b_free(&c->in);
    h2b_free(&c->out);
}

static void g_start_call(g_conn *c, g_stream *s);

static void g_writer(void *arg, int cancelled);

/* how long a client may take over the TLS handshake */
#define G_HANDSHAKE_NS 10000000000LL

static void g_reader(void *arg, int cancelled) {
    g_conn *c = (g_conn *)arg;
    if (cancelled) { g_conn_dead(c, "cancelled"); g_conn_release(c); return; }
    fwp_cur->unwinding = 1; /* not cancellable */
    if (c->server) {
        /* a TLS server connection's handshake, in this task; then its
         * writer, a child of this task: it ends with the connection */
        if (c->ssl && !fwp_tls_finish(c->ssl, c->fd, fwp_now_ns() + G_HANDSHAKE_NS)) {
            g_conn_dead(c, fwp_tls_err);
            g_conn_release(c);
            return;
        }
        c->refs++;
        fwp_spawn_task(0, g_writer, c, 0, 0);
    }
    unsigned char buf[65536];
    for (;;) {
        if (c->dead) break;
        int ww;
        ssize_t k = g_io_recv(c, buf, sizeof buf, &ww);
        if (k > 0) {
            g_slist fresh = {0, 0, 0};
            char *dead = 0;
            g_process(c, buf, (size_t)k, &fresh, &dead);
            for (size_t i = 0; i < fresh.n; i++) g_start_call(c, fresh.v[i]);
            fwp_mem_free(fresh.v);
            g_wake_conn(c);
            if (dead) {
                /* send the GOAWAY if it can be sent now */
                if (c->out.len) {
                    ssize_t w = g_io_send(c, c->out.d, c->out.len, &ww);
                    (void)w;
                }
                g_conn_dead(c, dead);
                free(dead);
                break;
            }
            continue;
        }
        if (k == 0) {
            char m[300];
            snprintf(m, sizeof m, "connection to %s closed", c->authority);
            g_conn_dead(c, m);
            break;
        }
        if (k == -1 && (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)) {
            fwp_wait_fd(c->fd, ww, 0);
            continue;
        }
        char m[900];
        snprintf(m, sizeof m, "cannot read from %s: %s", c->authority, k == -2 ? fwp_tls_err : strerror(errno));
        g_conn_dead(c, m);
        break;
    }
    g_conn_release(c);
}

static void g_writer(void *arg, int cancelled) {
    g_conn *c = (g_conn *)arg;
    if (cancelled) { g_conn_release(c); return; }
    fwp_cur->unwinding = 1; /* not cancellable */
    for (;;) {
        if (c->dead) break;
        if (c->out.len == 0) {
            fwp_park(&c->writer_wl, 0);
            continue;
        }
        int ww;
        ssize_t k = g_io_send(c, c->out.d, c->out.len, &ww);
        if (k > 0) {
            h2b_drop(&c->out, (size_t)k);
            fwp_wake_all(&c->space_wl);
            continue;
        }
        if (k == -1 && (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)) {
            fwp_wait_fd(c->fd, ww, 0);
            continue;
        }
        char m[900];
        snprintf(m, sizeof m, "cannot send to %s: %s", c->authority,
                 k == 0 ? "connection closed" : k == -2 ? fwp_tls_err : strerror(errno));
        g_conn_dead(c, m);
        break;
    }
    g_conn_release(c);
}

/* -------------------------------------------------------- sending frames */

#define G_OUT_LIMIT ((size_t)1 << 20)

static void g_reset(g_conn *c, g_stream *s, uint32_t code) {
    g_set_reset(s, "cancelled");
    if (c->dead || !s->listed) return;
    g_unlink(c, s);
    unsigned char p[4] = {(unsigned char)(code >> 24), (unsigned char)(code >> 16), (unsigned char)(code >> 8),
                          (unsigned char)code};
    h2_frame(&c->out, H2_RST_STREAM, 0, s->id, p, 4);
    fwp_wake_all(&c->writer_wl);
}

/* send data within the flow-control windows: 0 when the stream is closed;
 * waiting for a window can be cancelled */
static int g_send_data(g_conn *c, g_stream *s, const unsigned char *d, size_t n, int end) {
    size_t off = 0;
    for (;;) {
        if (c->dead || s->reset || s->local_end) return 0;
        for (;;) {
            size_t rem = n - off;
            if (rem == 0) {
                if (end) {
                    h2_frame(&c->out, H2_DATA, H2_END_STREAM, s->id, 0, 0);
                    s->local_end = 1;
                }
                fwp_wake_all(&c->writer_wl);
                return 1;
            }
            int64_t avail = c->conn_window < s->window ? c->conn_window : s->window;
            if (avail > (int64_t)c->peer.max_frame) avail = (int64_t)c->peer.max_frame;
            if (avail <= 0 || c->out.len >= G_OUT_LIMIT) break;
            size_t k = (size_t)avail < rem ? (size_t)avail : rem;
            int last = k == rem && end;
            h2_frame(&c->out, H2_DATA, last ? H2_END_STREAM : 0, s->id, d + off, k);
            c->conn_window -= (int64_t)k;
            s->window -= (int64_t)k;
            off += k;
            if (last) {
                s->local_end = 1;
                fwp_wake_all(&c->writer_wl);
                return 1;
            }
        }
        fwp_wake_all(&c->writer_wl);
        if (g_cancelled()) fwp_check_cancel();
        fwp_park(&c->space_wl, 0);
    }
}

static void g_h2_buffer_release(void *arg) { h2b_free((h2_buf *)arg); }

/* send one message; a server sends its response headers first */
static int g_send_msg(g_conn *c, g_stream *s, const unsigned char *msg, size_t n, int end) {
    if (c->server && !s->sent_headers && !c->dead && !s->reset) {
        s->sent_headers = 1;
        h2_buf blk = {0};
        h2_hpack_lit(&blk, ":status", "200");
        h2_hpack_lit(&blk, "content-type", "application/grpc");
        h2_hpack_lit(&blk, "grpc-accept-encoding", "gzip");
        if (s->gzip) h2_hpack_lit(&blk, "grpc-encoding", "gzip");
        for (size_t i = 0; i < s->out_headers.n; i++)
            h2_hpack_lit(&blk, s->out_headers.v[i].name, s->out_headers.v[i].value);
        h2_header_frames(&c->out, s->id, &blk, 0, c->peer.max_frame);
        h2b_free(&blk);
    }
    h2_buf b = {0};
    fwp_cleanup message_buffer;
    fwp_cleanup_push(&message_buffer, g_h2_buffer_release, &b);
    if (s->gzip && n >= 64) {
        /* compressed (messages shorter than 64 bytes are sent as they are) */
        h2_buf z = {0};
        h2_gzip(msg, n, &z);
        h2b_byte(&b, 1);
        h2b_be32(&b, (uint32_t)z.len);
        h2b_put(&b, z.d, z.len);
        h2b_free(&z);
    } else {
        h2_grpc_frame(&b, msg, n);
    }
    int r = g_send_data(c, s, b.d, b.len, end);
    fwp_cleanup_pop(&message_buffer);
    h2b_free(&b);
    return r;
}

/* --------------------------------------------------------------- receiving */

enum { G_MSG, G_END, G_LOST };

typedef struct {
    int kind;
    g_msg *m;       /* G_MSG */
    int code;       /* G_END */
    char *text;     /* G_END: grpc-message; G_LOST: why */
    int retry;      /* G_LOST: the request certainly was not processed */
} g_got;

static void g_got_release(void *arg) {
    g_got *g = (g_got *)arg;
    free(g->m);
    free(g->text);
    g->m = 0;
    g->text = 0;
}


static void g_status_of(g_conn *c, g_stream *s, g_got *g) {
    g->kind = G_END;
    const char *st = h2_get(&s->headers, ":status");
    if (st && strcmp(st, "200") != 0) {
        g->code = GRPC_UNAVAILABLE;
        g->text = g_strdupf("HTTP status %s from %s", st, c->authority);
        return;
    }
    const h2_hdrs *hs = s->trailers.n ? &s->trailers : &s->headers;
    const char *gs = h2_get(hs, "grpc-status");
    if (!gs) {
        g->code = GRPC_INTERNAL;
        g->text = g_strdupf("no grpc-status from %s", c->authority);
        return;
    }
    char *end = 0;
    long code = strtol(gs, &end, 10);
    g->code = end == gs ? GRPC_UNKNOWN : (int)code;
    const char *m = h2_get(hs, "grpc-message");
    g->text = strdup(m ? m : "");
    h2_pct_decode(g->text);
}

/* The server ended a call for its deadline, which the task's deadline set
 * (it sends the time left, rounded down): the task is cancelled when its
 * deadline passes, in a moment. */
static void g_deadline_passed(int64_t call) {
    fwp_task *t = fwp_cur;
    int64_t td = t->deadline;
    if (!td || t->unwinding || (call && call < td) || td - fwp_now_ns() > 1000000000LL) return;
    while (fwp_now_ns() < td) {
        fwp_check_cancel();
        fwp_park(0, td);
    }
    fwp_check_cancel();
}

/* response headers and trailers that are not metadata */
static int g_not_response_metadata(const char *k) {
    static const char *const no[] = {"content-type", "grpc-status", "grpc-message", "grpc-encoding",
                                     "grpc-accept-encoding"};
    if (k[0] == ':') return 1;
    for (size_t i = 0; i < sizeof no / sizeof no[0]; i++)
        if (strcmp(k, no[i]) == 0) return 1;
    return 0;
}

static V g_pairs_value(const h2_hdrs *h);

/* the metadata of a response (headers, then trailers) added to `out` */
static void g_metadata_into(const g_stream *s, h2_hdrs *out) {
    for (int t = 0; t < 2; t++) {
        const h2_hdrs *h = t ? &s->trailers : &s->headers;
        for (size_t i = 0; i < h->n; i++)
            if (!g_not_response_metadata(h->v[i].name))
                h2_hdrs_add(out, h->v[i].name, strlen(h->v[i].name), h->v[i].value, strlen(h->v[i].value));
    }
}

/* wait for the next message of a stream; cancellation of the task resets
 * a client's stream, and `deadline` (a call's) ends it with
 * DEADLINE_EXCEEDED */
static void g_recv(g_conn *c, g_stream *s, int64_t deadline, g_got *g) {
    memset(g, 0, sizeof *g);
    for (;;) {
        if (s->mhead) {
            g->kind = G_MSG;
            g->m = s->mhead;
            s->mhead = s->mhead->next;
            if (!s->mhead) s->mtail = 0;
            return;
        }
        if (s->bad) { g->kind = G_LOST; g->text = strdup(s->bad); return; }
        if (s->remote_end) {
            if (c->server) { g->kind = G_END; g->code = 0; g->text = strdup(""); return; }
            if (g_ctx_of()->capture) g_metadata_into(s, g_ctx_of()->capture);
            g_status_of(c, s, g);
            g_unlink(c, s);
            if (g->code == GRPC_DEADLINE_EXCEEDED) g_deadline_passed(deadline);
            return;
        }
        if (s->reset) { g->kind = G_LOST; g->text = strdup(s->reset); g->retry = s->retry; return; }
        if (g_cancelled()) {
            if (!c->server) g_reset(c, s, 8); /* CANCEL */
            fwp_check_cancel();
        }
        if (deadline && fwp_now_ns() >= deadline) {
            g_reset(c, s, 8);
            g->kind = G_END;
            g->code = GRPC_DEADLINE_EXCEEDED;
            g->text = strdup("deadline exceeded");
            return;
        }
        fwp_park(&s->waiters, deadline);
    }
}

/* ------------------------------------------------------------------ client */

static g_tls *g_tls_new(const char *ca, int insecure, const char *name, const char *cert, const char *key) {
    g_tls *t = (g_tls *)calloc(1, sizeof *t);
    t->ca = strdup(ca);
    t->insecure = insecure;
    t->name = strdup(name);
    t->cert = strdup(cert);
    t->keyfile = strdup(key);
    t->key = g_strdupf("%s|%d|%s|%s|%s", ca, insecure, name, cert, key);
    return t;
}

/* the TLS options of a service's variables (FWP_SERVICE_<M>_CA,
 * _INSECURE, _SERVER_NAME, _CERT, _KEY), or 0; read once per service */
static const g_tls *g_env_tls(const char *var) {
    static struct g_env_tls { const char *var; const g_tls *tls; struct g_env_tls *next; } *known = 0;
    for (struct g_env_tls *k = known; k; k = k->next)
        if (strcmp(k->var, var) == 0) return k->tls;
    const char *v[5];
    static const char *const sfx[5] = {"CA", "INSECURE", "SERVER_NAME", "CERT", "KEY"};
    for (int i = 0; i < 5; i++) {
        char name[300];
        snprintf(name, sizeof name, "%s_%s", var, sfx[i]);
        v[i] = getenv(name);
        if (v[i] && !*v[i]) v[i] = 0;
    }
    int insecure = v[1] && strcmp(v[1], "0") != 0 && strcmp(v[1], "false") != 0;
    struct g_env_tls *k = (struct g_env_tls *)calloc(1, sizeof *k);
    k->var = strdup(var);
    k->tls = v[0] || insecure || v[2] || v[3] || v[4]
                 ? g_tls_new(v[0] ? v[0] : "", insecure, v[2] ? v[2] : "", v[3] ? v[3] : "", v[4] ? v[4] : "")
                 : 0;
    k->next = known;
    known = k;
    return k->tls;
}

static int g_same_tls(const char *a, const g_tls *t) {
    if (!t) return a == 0;
    return a && strcmp(a, t->key) == 0;
}

typedef struct { g_conn *c; fwp_task *reader, *writer; } g_connect_start_owner;
static void g_connect_ref_release(void *arg) { g_conn_release((g_conn *)arg); }
static void g_connect_start_abort(void *arg) {
    g_connect_start_owner *owner = (g_connect_start_owner *)arg;
    owner->c->dead = g_connect_start_failed;
    shutdown(owner->c->fd, SHUT_RDWR);
    if (owner->reader) fwp_cancel_tree(owner->reader);
    if (owner->writer) fwp_cancel_tree(owner->writer);
    g_conn_release(owner->c);
}

static void g_connect_ssl_release(void *arg) {
    SSL **ssl = (SSL **)arg;
    if (*ssl) { SSL_free(*ssl); *ssl = 0; }
}

static g_conn *g_connect(const char *given, const g_tls *opts, char **err) {
    char host[256], port[32], addr[300];
    int tls;
    g_addr(given, &tls, addr, sizeof addr);
    if (!fwp_split_addr(addr, host, sizeof host, port, sizeof port)) {
        *err = g_strdupf("cannot connect to %s: invalid socket address", addr);
        return 0;
    }
    struct addrinfo hints, *res = 0;
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_NUMERICSERV;
    int rc = getaddrinfo(host, port, &hints, &res);
    if (rc != 0) {
        *err = g_strdupf("cannot connect to %s: failed to lookup address information: %s", addr, gai_strerror(rc));
        return 0;
    }
    fwp_connect_owner owner = {-1, res};
    fwp_cleanup connect_cleanup;
    fwp_cleanup_push(&connect_cleanup, fwp_connect_finish, &owner);
    int fd = -1, e = 0;
    for (struct addrinfo *ai = res; ai; ai = ai->ai_next) {
        fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
        owner.fd = fd;
        if (fd < 0) { e = errno; continue; }
        fwp_nonblock(fd);
        if (connect(fd, ai->ai_addr, ai->ai_addrlen) == 0) break;
        e = errno;
        if (e == EINPROGRESS) {
            fwp_wait_fd(fd, 1, 0);
            socklen_t el = sizeof e;
            getsockopt(fd, SOL_SOCKET, SO_ERROR, &e, &el);
            if (e == 0) break;
        }
        owner.fd = -1;
        fwp_fd_closing(fd);
        close(fd);
        fd = -1;
    }
    freeaddrinfo(res);
    owner.addresses = 0;
    if (fd < 0) {
        *err = g_strdupf("cannot connect to %s: %s", addr, strerror(e));
        fwp_cleanup_pop(&connect_cleanup);
        return 0;
    }
    int one = 1;
    setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof one);
    SSL *ssl = 0;
    fwp_cleanup ssl_cleanup;
    fwp_cleanup_push(&ssl_cleanup, g_connect_ssl_release, &ssl);
    if (tls) {
        /* verified with the system's CA certificates (SSL_CERT_FILE,
         * SSL_CERT_DIR) unless the options say otherwise, offering h2 */
        ssl = opts ? fwp_tls_client_new(fd, opts->ca, !opts->insecure, *opts->name ? opts->name : host,
                                        (const unsigned char *)"\x02h2", 3, opts->cert, opts->keyfile)
                   : fwp_tls_client_new(fd, "", 1, host, (const unsigned char *)"\x02h2", 3, "", "");
        if (!ssl || !fwp_tls_finish(ssl, fd, 0)) {
            *err = g_strdupf("cannot connect to %s: %s", addr, fwp_tls_err);
            fwp_cleanup_pop(&ssl_cleanup);
            g_connect_ssl_release(&ssl);
            fwp_cleanup_pop(&connect_cleanup);
            fwp_connect_finish(&owner);
            return 0;
        }
    }
    g_conn *c = g_conn_new(fd, given, 0);
    c->ssl = ssl;
    ssl = 0;
    fwp_cleanup_pop(&ssl_cleanup);
    owner.fd = -1;
    fwp_cleanup_pop(&connect_cleanup);
    c->tlskey = opts ? strdup(opts->key) : 0;
    c->refs = 1; /* temporary startup owner */
    g_connect_start_owner startup = {c, 0, 0};
    fwp_cleanup startup_cleanup;
    fwp_cleanup_push(&startup_cleanup, g_connect_start_abort, &startup);
    fwp_cleanup reserved_ref;
    c->refs++;
    fwp_cleanup_push(&reserved_ref, g_connect_ref_release, c);
    startup.reader = fwp_spawn_task(0, g_reader, c, 0, 1);
    fwp_cleanup_pop(&reserved_ref); /* reader takes its reserved reference */
    c->refs++;
    fwp_cleanup_push(&reserved_ref, g_connect_ref_release, c);
    startup.writer = fwp_spawn_task(0, g_writer, c, 0, 1);
    fwp_cleanup_pop(&reserved_ref);
    c->next_pool = g_pool;
    g_pool = c;
    fwp_cleanup_pop(&startup_cleanup);
    g_conn_release(c); /* only the reader and writer remain */
    return c;
}

static void g_timeout_header(int64_t deadline, char *out, size_t n) {
    int64_t left = deadline - fwp_now_ns();
    int64_t ms = left <= 0 ? 1 : left / 1000000;
    if (ms < 1) ms = 1;
    if (ms < 100000000) {
        snprintf(out, n, "%lldm", (long long)ms);
    } else {
        int64_t sec = left / 1000000000;
        if (sec > 99999999) sec = 99999999;
        snprintf(out, n, "%lldS", (long long)sec);
    }
}

/* start a call: 0 and the error in *err on a transport failure; with the
 * TLS options of the task's context, else `dflt` */
static g_stream *g_open_tls(const char *addr, const char *path, const char *fp, g_conn **cp, int *reused, char **err,
                            const g_tls *dflt) {
    fwp_tasks_init();
    fwp_check_cancel();
    const g_tls *opts = g_ctx_of()->tls ? g_ctx_of()->tls : dflt;
    g_conn *c = 0;
    for (g_conn *p = g_pool; p; p = p->next_pool)
        if (strcmp(p->authority, addr) == 0 && g_same_tls(p->tlskey, opts) && !p->dead && !p->goaway &&
            p->next_stream < 0x7fff0000u) {
            c = p;
            break;
        }
    *reused = c != 0;
    if (!c) c = g_connect(addr, opts, err);
    if (!c) return 0;
    g_ctx *ctx = g_ctx_of();
    int64_t deadline = g_earliest(ctx->deadline, fwp_cur->deadline);
    uint32_t id = c->next_stream;
    c->next_stream += 2;
    char authority[300];
    int tls;
    g_addr(c->authority, &tls, authority, sizeof authority);
    h2_buf blk = {0};
    h2_hpack_lit(&blk, ":method", "POST");
    h2_hpack_lit(&blk, ":scheme", c->ssl ? "https" : "http");
    h2_hpack_lit(&blk, ":path", path);
    h2_hpack_lit(&blk, ":authority", authority);
    h2_hpack_lit(&blk, "content-type", "application/grpc");
    h2_hpack_lit(&blk, "te", "trailers");
    h2_hpack_lit(&blk, "grpc-accept-encoding", "gzip");
    if (ctx->gzip) h2_hpack_lit(&blk, "grpc-encoding", "gzip");
    if (deadline) {
        char t[32];
        g_timeout_header(deadline, t, sizeof t);
        h2_hpack_lit(&blk, "grpc-timeout", t);
    }
    if (fp) h2_hpack_lit(&blk, "fwp-fingerprint", fp);
    for (size_t i = 0; i < ctx->n; i++) h2_hpack_lit(&blk, ctx->kv[2 * i], ctx->kv[2 * i + 1]);
    h2_header_frames(&c->out, id, &blk, 0, c->peer.max_frame);
    h2b_free(&blk);
    g_stream *s = g_stream_new(c, id);
    s->gzip = ctx->gzip;
    fwp_wake_all(&c->writer_wl);
    *cp = c;
    return s;
}

static V g_grpc_error(int code, const char *msg, const fwp_desc *d) {
    V f[2] = {(V)(int64_t)code, fwp_cstr(msg)};
    fwp_fail(fwp_record(2, f), d);
    return 0;
}

/* a status from a GrpcError value; codes outside 1..16 are UNKNOWN */
static int g_error_code(V e) {
    int64_t code = (int64_t)OBJ(e)->f[0];
    return code >= 1 && code <= 16 ? (int)code : GRPC_UNKNOWN;
}

/* how messages of a stream are decoded or encoded */
typedef struct {
    V fn;                      /* an fwp function, or 0 */
    const int *schema;
    int node;
    const fwp_desc *ty, *error;
} g_codec;

enum { G_DEC_OK, G_DEC_ERROR, G_DEC_BAD };

/* decode a message: its value, the error it carries, or a failure */
static int g_decode(const g_codec *k, const unsigned char *msg, size_t n, V *out, char **why) {
    if (k->fn) {
        fwp_handler h;
        h.prev = fwp_handlers;
        h.state_depth = fwp_state_len;
        h.cleanup = fwp_cleanups;
        fwp_handlers = &h;
        if (setjmp(h.jb) == 0) {
            V r = fwp_apply1(k->fn, fwp_str_new((const char *)msg, n));
            fwp_handlers = h.prev;
            *out = r;
            return G_DEC_OK;
        }
        fwp_handlers = h.prev;
        fwp_state_len = h.state_depth;
        *why = strdup(STR(OBJ(h.value)->f[1])->d);
        return G_DEC_BAD;
    }
    /* the details of malformed messages differ between the backends: a
     * message names none */
    h2_buf canon = {0};
    if (!pb_decode(k->schema, k->node, msg, n, &canon)) {
        h2b_free(&canon);
        *why = strdup("malformed message");
        return G_DEC_BAD;
    }
    fwp_rd rd = {canon.d, canon.len, 0};
    if (k->error) {
        uint64_t tag;
        if (!rd_leb(&rd, &tag)) { h2b_free(&canon); *why = strdup("malformed message"); return G_DEC_BAD; }
        if (tag == 1) {
            int ok = fwp_decode(&rd, k->error, out);
            h2b_free(&canon);
            if (!ok) { *why = strdup("malformed message"); return G_DEC_BAD; }
            return G_DEC_ERROR;
        }
    }
    int ok = fwp_decode(&rd, k->ty, out);
    h2b_free(&canon);
    if (!ok) { *why = strdup("malformed message"); return G_DEC_BAD; }
    return G_DEC_OK;
}

/* encode a message (with the oneof tag of `value` when `tag`) */
static void g_encode(const g_codec *k, V v, int tag, h2_buf *out) {
    if (k->fn) {
        V b = fwp_apply1(k->fn, v);
        h2b_put(out, STR(b)->d, STR(b)->len);
        return;
    }
    fwp_buf canon = {0};
    fwp_cleanup canonical_cleanup;
    fwp_cleanup_push(&canonical_cleanup, fwp_file_buffer_cleanup, &canon);
    if (tag) buf_putc(&canon, 0);
    fwp_encode(&canon, v, k->ty);
    if (!pb_encode(k->schema, k->node, (const unsigned char *)canon.d, canon.len, out))
        g_trapf("cannot encode a message: %s", h2_err);
    fwp_cleanup_pop(&canonical_cleanup);
    free(canon.d);
}

/* --------------------------------------------------------- received streams */

typedef struct {
    g_conn *c;
    g_stream *s;
    int server;
    g_codec dec;
    const char *what;          /* the call, for messages (client side) */
    int64_t deadline;
    int results;               /* elements are Result[R, GrpcError] (client side) */
} g_incoming;

/* a position in a received stream (GrpcCell): forcing it receives the
 * message there, once */
typedef struct {
    g_incoming *src;
    int forced;
    V memo;
} g_cell;

/* fail the call being served with a status: its task is cancelled and
 * answers with it */
static void g_fail_call(int code, const char *msg) {
    g_serving *sv = g_ctx_of()->serving;
    if (!sv) fwp_trap(msg);
    char *copy = strdup(msg);
    if (!copy) { fprintf(stderr, "fwp: out of memory\n"); exit(102); }
    free(sv->msg);
    sv->code = code;
    sv->msg = copy;
    fwp_cancel_tree(sv->task);
    fwp_check_cancel();
    fwp_trap(sv->msg);
}

/* the failure of a client call: a status, or -1 for a transport failure */
typedef struct { int code; char *text; } g_failure;

/* Option[(a, GrpcCell[a])]: the next element; with `first`, failures go
 * to *f or *err_desc (the cell stays unforced) instead of trapping */
/* `Some((Err (GrpcError code text), <the end>))` */
static V g_err_element(g_incoming *src, int code, const char *text) {
    g_cell *last = (g_cell *)fwp_mem_alloc(sizeof *last);
    last->src = src;
    last->forced = 1;
    last->memo = FWP_NONE;
    V f[2] = {(V)(int64_t)code, fwp_cstr(text)};
    V e = fwp_record(2, f);
    return fwp_some(fwp_tuple2(fwp_data(1, 1, &e), PTR(last)));
}

static V g_force(g_cell *cell, int first, g_failure *f, V *err_value, const fwp_desc **err_desc) {
    if (cell->forced) return cell->memo;
    g_incoming *src = cell->src;
    g_got g;
    g_recv(src->c, src->s, src->deadline, &g);
    fwp_cleanup received_cleanup;
    fwp_cleanup_push(&received_cleanup, g_got_release, &g);
    V r = FWP_NONE;
    if (src->results) {
        /* a failure is an `Err` element, then the end */
        if (g.kind == G_MSG) {
            V x;
            char *why = 0;
            int k = g_decode(&src->dec, g.m->d, g.m->n, &x, &why);
            free(g.m);
            g.m = 0;
            fwp_cleanup decode_cleanup;
            fwp_cleanup_push(&decode_cleanup, fwp_tls_subject_free, why);
            if (k == G_DEC_OK) {
                g_cell *next = (g_cell *)fwp_mem_alloc(sizeof *next);
                next->src = src;
                r = fwp_some(fwp_tuple2(fwp_data(0, 1, &x), PTR(next)));
            } else {
                char *t = k == G_DEC_BAD ? g_strdupf("bad response from %s: %s", src->what, why)
                                         : strdup("unexpected error in a response");
                fwp_cleanup text_cleanup;
                fwp_cleanup_push(&text_cleanup, fwp_tls_subject_free, t);
                r = g_err_element(src, GRPC_INTERNAL, t);
                fwp_cleanup_pop(&text_cleanup);
                free(t);
            }
            fwp_cleanup_pop(&decode_cleanup);
            fwp_tls_subject_free(why);
        } else if (g.kind == G_END && g.code == 0) {
            r = FWP_NONE;
        } else {
            r = g_err_element(src, g.kind == G_END ? g.code : GRPC_UNAVAILABLE, g.text);
        }
        fwp_cleanup_pop(&received_cleanup);
        g_got_release(&g);
        cell->forced = 1;
        cell->memo = r;
        return r;
    }
    if (g.kind == G_MSG) {
        V x;
        char *why = 0;
        int k = g_decode(&src->dec, g.m->d, g.m->n, &x, &why);
        free(g.m);
        g.m = 0;
        fwp_cleanup decode_cleanup;
        fwp_cleanup_push(&decode_cleanup, fwp_tls_subject_free, why);
        if (k == G_DEC_BAD) {
            if (src->server) g_fail_call(GRPC_INVALID_ARGUMENT, why);
            g_trapf("bad response from %s: %s", src->what, why);
        }
        if (k == G_DEC_ERROR) {
            if (first) {
                *err_value = x;
                *err_desc = src->dec.error;
                fwp_cleanup_pop(&decode_cleanup);
                fwp_tls_subject_free(why);
                fwp_cleanup_pop(&received_cleanup);
                g_got_release(&g);
                return 0;
            }
            fwp_buf b = {0};
            fwp_cleanup error_buffer;
            fwp_cleanup_push(&error_buffer, fwp_file_buffer_cleanup, &b);
            fwp_write(&b, x, src->dec.error, 1);
            g_trapf("service call %s failed: error: %.*s", src->what, (int)b.len, b.d ? b.d : "");
        }
        g_cell *next = (g_cell *)fwp_mem_alloc(sizeof *next);
        next->src = src;
        r = fwp_some(fwp_tuple2(x, PTR(next)));
        fwp_cleanup_pop(&decode_cleanup);
        fwp_tls_subject_free(why);
    } else if (g.kind == G_END && g.code == 0) {
        r = FWP_NONE;
    } else {
        if (src->server) {
            if (src->s->bad) g_fail_call(GRPC_INVALID_ARGUMENT, src->s->bad);
            fwp_cancel_tree(fwp_cur);
            fwp_check_cancel();
        }
        int code = g.kind == G_END ? g.code : -1;
        if (first) {
            f->code = code;
            f->text = g.text;
            g.text = 0;
            fwp_cleanup_pop(&received_cleanup);
            g_got_release(&g);
            return 0;
        }
        if (code == GRPC_INTERNAL && strncmp(g.text, "trap: ", 6) == 0) fwp_trap(g.text + 6);
        if (code >= 0) g_trapf("service call %s failed: gRPC status %d: %s", src->what, code, g.text);
        g_trapf("service call %s failed: %s", src->what, g.text);
    }
    fwp_cleanup_pop(&received_cleanup);
    g_got_release(&g);
    cell->forced = 1;
    cell->memo = r;
    return r;
}

/* a channel's values sent as messages of a stream */
typedef struct {
    g_conn *c;
    g_stream *s;
    g_codec enc;
    int tag;
} g_sink;

static int g_sink_send(void *ctx, V x) {
    g_sink *k = (g_sink *)ctx;
    h2_buf b = {0};
    g_encode(&k->enc, x, k->tag, &b);
    int r = g_send_msg(k->c, k->s, b.d, b.len, 0);
    h2b_free(&b);
    return r;
}

static V g_sink_value(g_conn *c, g_stream *s, g_codec enc, int tag) {
    V ch = fwp_p_channel_make((V)1);
    fwp_chan *q = (fwp_chan *)(uintptr_t)ch;
    g_sink *k = (g_sink *)fwp_mem_alloc(sizeof *k);
    k->c = c;
    k->s = s;
    k->enc = enc;
    k->tag = tag;
    q->sink = g_sink_send;
    q->sink_ctx = k;
    return ch;
}

/* the values of an Iterator, forced one at a time */
static int g_iter_next(V *cur, V *x) {
    V v = *cur;
    if (fwp_tag(v) != 1) return 0;
    *x = OBJ(v)->f[0];
    *cur = fwp_apply1(OBJ(v)->f[1], FWP_UNIT);
    return 1;
}

/* ---------------------------------------------------------------- senders */

static void g_encode_request(const fwp_remote *r, V *vals, h2_buf *out);

/* a task that sends the requests of a bidirectional call while its caller
 * receives the responses: the elements of an iterator, encoded by `enc`
 * (an fwp function) or as requests of `r`, then the end of the stream. It
 * stops when the call is over; a trap resets the stream with the reason
 * `trap: ...`, which the caller raises. Allocated in the fwp heap: it holds
 * values. */
typedef struct {
    g_conn *c;
    g_stream *s;
    V cur, enc;
    const fwp_remote *r;
    g_serving *serving;
} g_sender;

static void g_sender_peer_finish(void *arg) {
    g_sender *x = (g_sender *)arg;
    g_serving_peer_release(x->serving);
    x->serving = 0;
}

static void g_send_all(void *arg, int cancelled) {
    g_sender *x = (g_sender *)arg;
    if (cancelled) return;
    jmp_buf tj;
    jmp_buf *saved = fwp_cur->trap_jb;
    fwp_cleanup *saved_cleanup = fwp_cur->trap_cleanup;
    fwp_cleanup *cleanup_base = fwp_cleanups;
    if (setjmp(tj) != 0) {
        fwp_cur->trap_jb = saved;
        fwp_cur->trap_cleanup = saved_cleanup;
        char *why = g_strdupf("trap: %s", fwp_trap_msg);
        g_set_reset(x->s, why);
        free(why);
        g_reset(x->c, x->s, 8);
        fwp_wake_all(&x->s->waiters);
        return;
    }
    fwp_cur->trap_jb = &tj;
    fwp_cur->trap_cleanup = cleanup_base;
    V v;
    for (;;) {
        if (!x->s->listed || x->s->remote_end) break;
        V cur = x->cur;
        if (!g_iter_next(&cur, &v)) {
            g_send_data(x->c, x->s, 0, 0, 1);
            break;
        }
        x->cur = cur;
        int ok;
        if (x->r) {
            h2_buf req = {0};
            fwp_cleanup request_buffer;
            fwp_cleanup_push(&request_buffer, g_h2_buffer_release, &req);
            g_encode_request(x->r, &v, &req);
            ok = g_send_msg(x->c, x->s, req.d, req.len, 0);
            fwp_cleanup_pop(&request_buffer);
            h2b_free(&req);
        } else {
            V b = fwp_apply1(x->enc, v);
            ok = g_send_msg(x->c, x->s, (const unsigned char *)STR(b)->d, STR(b)->len, 0);
        }
        if (!ok) break;
        /* let the connection's reader see the end of the call (an
         * iterator may be infinite, and the windows may stay open) */
        fwp_park(0, fwp_now_ns() + 1);
        fwp_check_cancel();
    }
    fwp_cur->trap_jb = saved;
    fwp_cur->trap_cleanup = saved_cleanup;
}

static void g_spawn_sender(g_conn *c, g_stream *s, V iter, V enc, const fwp_remote *r) {
    g_sender *x = (g_sender *)fwp_alloc(sizeof *x);
    x->c = c;
    x->s = s;
    x->cur = iter;
    x->enc = enc;
    x->r = r;
    x->serving = g_ctx_of()->serving;
    if (x->serving) {
        if (x->serving->peer_users == SIZE_MAX) fwp_trap("too many serving context owners");
        x->serving->peer_users++;
    }
    fwp_cleanup peer_cleanup;
    fwp_cleanup_push(&peer_cleanup, g_sender_peer_finish, x);
    fwp_task *t = fwp_spawn_task(0, g_send_all, x, 0, 1);
    t->cfinish = g_sender_peer_finish;
    fwp_cleanup_pop(&peer_cleanup);
}

/* ------------------------------------------------------------- client stubs */

/* Takes ownership of copied transport/status text before raising it. */
static void g_stub_fail(const fwp_remote *r, const char *addr, int code, char *text) {
    fwp_cleanup failure_text;
    fwp_cleanup_push(&failure_text, fwp_tls_subject_free, text);
    if ((code == GRPC_INTERNAL || code < 0) && strncmp(text, "trap: ", 6) == 0) fwp_trap(text + 6);
    if (r->m.status_errors) g_grpc_error(code < 0 ? GRPC_UNAVAILABLE : code, text, r->m.grpc_error);
    if (code >= 0) g_trapf("service call %s (%s) failed: gRPC status %d: %s", r->what, addr, code, text);
    g_trapf("service call %s (%s) failed: %s", r->what, addr, text);
}

/* Transfer copied receive text out of the scoped buffer owner. */
static void g_stub_got_fail(const fwp_remote *r, const char *addr, int code, g_got *g) {
    char *text = g->text;
    g->text = 0;
    g_stub_fail(r, addr, code, text);
}

static void g_encode_request(const fwp_remote *r, V *vals, h2_buf *out) {
    fwp_buf canon = {0};
    fwp_cleanup canonical_cleanup;
    fwp_cleanup_push(&canonical_cleanup, fwp_file_buffer_cleanup, &canon);
    for (int i = 0; i < r->m.nreq; i++) fwp_encode(&canon, vals[i], r->m.req[i]);
    if (!pb_encode(r->m.schema, r->m.req_node, (const unsigned char *)canon.d, canon.len, out))
        g_trapf("cannot encode the arguments of %s: %s", r->what, h2_err);
    fwp_cleanup_pop(&canonical_cleanup);
    free(canon.d);
}

/* a call to a function served by another process (a split build) */
static V fwp_remote_call(const fwp_remote *r, V *args) {
    fwp_tasks_init();
    const char *addr = getenv(r->env);
    if (!addr || !*addr) addr = r->default_addr;
    int64_t deadline = g_ctx_of()->deadline;
    g_codec dec = {0, r->m.schema, r->m.resp_node, r->m.resp, r->m.error};
    g_conn *c = 0;
    g_stream *s = 0;
    g_got first;
    memset(&first, 0, sizeof first);
    fwp_cleanup first_received;
    fwp_cleanup_push(&first_received, g_got_release, &first);
    for (int attempt = 0;; attempt++) {
        int reused = 0;
        char *err = 0;
        s = g_open_tls(addr, r->m.path, r->m.fingerprint, &c, &reused, &err, g_env_tls(r->env));
        if (!s) g_stub_fail(r, addr, -1, err);
        if (r->m.input == 0) {
            h2_buf req = {0};
            fwp_cleanup client_request;
            fwp_cleanup_push(&client_request, g_h2_buffer_release, &req);
            g_encode_request(r, args, &req);
            g_send_msg(c, s, req.d, req.len, 1);
            fwp_cleanup_pop(&client_request);
            h2b_free(&req);
        } else if (r->m.output != 0) {
            /* requests are sent as responses arrive */
            g_spawn_sender(c, s, args[0], 0, r);
        } else {
            V cur = args[0], x;
            while (g_iter_next(&cur, &x)) {
                h2_buf req = {0};
                fwp_cleanup client_request;
                fwp_cleanup_push(&client_request, g_h2_buffer_release, &req);
                g_encode_request(r, &x, &req);
                int ok = g_send_msg(c, s, req.d, req.len, 0);
                fwp_cleanup_pop(&client_request);
                h2b_free(&req);
                if (!ok) break;
            }
            g_send_data(c, s, 0, 0, 1);
        }
        if (r->m.output != 0) break;
        g_recv(c, s, deadline, &first);
        if (first.kind == G_LOST && first.retry && reused && attempt == 0 && r->m.input == 0) {
            g_got_release(&first);
            continue;
        }
        break;
    }
    if (r->m.output == 0) {
        if (first.kind == G_LOST) g_stub_got_fail(r, addr, -1, &first);
        if (first.kind == G_END && first.code != 0) g_stub_got_fail(r, addr, first.code, &first);
        if (first.kind == G_END) g_trapf("bad response from %s (%s): missing response message", r->what, addr);
        V v;
        char *why = 0;
        int k = g_decode(&dec, first.m->d, first.m->n, &v, &why);
        free(first.m);
        first.m = 0;
        fwp_cleanup decode_text;
        fwp_cleanup_push(&decode_text, fwp_tls_subject_free, why);
        if (k == G_DEC_BAD) g_trapf("bad response from %s (%s): %s", r->what, addr, why);
        fwp_cleanup_pop(&decode_text);
        free(why);
        g_got g = {0};
        fwp_cleanup received;
        fwp_cleanup_push(&received, g_got_release, &g);
        g_recv(c, s, deadline, &g);
        if (g.kind == G_MSG) {
            g_reset(c, s, 8);
            g_trapf("bad response from %s (%s): more than one response message", r->what, addr);
        }
        if (g.kind == G_LOST) g_stub_got_fail(r, addr, -1, &g);
        if (g.code != 0) g_stub_got_fail(r, addr, g.code, &g);
        if (k == G_DEC_ERROR) fwp_fail(v, r->m.error);
        fwp_cleanup_pop(&received);
        g_got_release(&g);
        fwp_cleanup_pop(&first_received);
        g_got_release(&first);
        return v;
    }
    if (r->m.output == 2) {
        V ch = args[r->m.input == 1 ? 1 : r->m.nreq];
        for (;;) {
            g_got g = {0};
            fwp_cleanup received;
            fwp_cleanup_push(&received, g_got_release, &g);
            g_recv(c, s, deadline, &g);
            if (g.kind == G_MSG) {
                V v;
                char *why = 0;
                int k = g_decode(&dec, g.m->d, g.m->n, &v, &why);
                free(g.m);
                g.m = 0;
                fwp_cleanup decode_text;
                fwp_cleanup_push(&decode_text, fwp_tls_subject_free, why);
                if (k == G_DEC_BAD) {
                    g_reset(c, s, 8);
                    g_trapf("bad response from %s (%s): %s", r->what, addr, why);
                }
                if (k == G_DEC_ERROR) {
                    g_reset(c, s, 8);
                    fwp_fail(v, r->m.error);
                }
                fwp_cleanup_pop(&decode_text);
                free(why);
                fwp_p_channel_send(ch, v);
                fwp_cleanup_pop(&received);
                g_got_release(&g);
                continue;
            }
            if (g.kind == G_LOST) g_stub_got_fail(r, addr, -1, &g);
            if (g.code != 0) g_stub_got_fail(r, addr, g.code, &g);
            fwp_cleanup_pop(&received);
            g_got_release(&g);
            fwp_cleanup_pop(&first_received);
            g_got_release(&first);
            return FWP_UNIT;
        }
    }
    /* an Iterator: the first element now, so that a failure before it is
     * raised in the caller */
    g_incoming *src = (g_incoming *)fwp_mem_alloc(sizeof *src);
    src->c = c;
    src->s = s;
    src->dec = dec;
    src->what = g_strdupf("%s (%s)", r->what, addr);
    src->deadline = deadline;
    src->results = r->m.output == 3;
    g_cell *cell = (g_cell *)fwp_mem_alloc(sizeof *cell);
    cell->src = src;
    g_failure f = {0, 0};
    V ev = 0;
    const fwp_desc *ed = 0;
    g_force(cell, 1, &f, &ev, &ed);
    if (!cell->forced) {
        if (ed) fwp_fail(ev, ed);
        g_stub_fail(r, addr, f.code, f.text);
    }
    fwp_cleanup_pop(&first_received);
    g_got_release(&first);
    return fwp_apply1(fwp_pap((uint32_t)r->m.iter_fn, 0, 0), PTR(cell));
}

/* ----------------------------------------------------------------- servers */

enum { G_ROUTE_METHOD, G_ROUTE_HEALTH, G_ROUTE_WATCH, G_ROUTE_REFLECTION };

typedef struct {
    const char *path;
    int kind;
    const fwp_rpc *m;
} g_route;

struct g_server {
    g_route *routes;
    size_t n;
    const char *module;        /* for log messages */
    const fwp_service *svc;    /* reflection and health (exported functions) */
    const char **services;     /* full service names (GrpcRoutes) */
    size_t nservices;
    SSL_CTX *tls;              /* serving TLS (h2 with ALPN) */
};

typedef struct {
    g_conn *c;
    g_stream *s;
    const g_server *srv;
    const g_route *route;
    char what[300];
    g_serving sv;
    g_ctx ctx;
} g_job;

/* The serving context is inherited by children; dispose only after their join. */
static void g_job_peer_finish(void *arg) {
    g_job *j = (g_job *)arg;
    g_serving_peer_release(&j->sv);
}


static const g_route *g_route_of(const g_server *srv, const char *path) {
    for (size_t i = 0; i < srv->n; i++)
        if (strcmp(srv->routes[i].path, path) == 0) return &srv->routes[i];
    return 0;
}

static int g_trap_recover(void) {
    if (fwp_cur && fwp_cur->trap_jb) {
        fwp_trap_jb = fwp_cur->trap_jb;
        fwp_trap_cleanup = fwp_cur->trap_cleanup;
        return 1;
    }
    return 0;
}

static void g_handle(void *arg, int cancelled);

/* a `grpc-timeout` header as a deadline (0: none) */
static int64_t g_parse_timeout(const char *t) {
    if (!t) return 0;
    size_t n = strlen(t);
    if (n < 2 || n > 9) return 0;
    uint64_t x = 0;
    for (size_t i = 0; i + 1 < n; i++) {
        if (t[i] < '0' || t[i] > '9') return 0;
        x = x * 10 + (uint64_t)(t[i] - '0');
    }
    uint64_t scale = 0;
    switch (t[n - 1]) {
    case 'H': scale = 3600000000000ull; break;
    case 'M': scale = 60000000000ull; break;
    case 'S': scale = 1000000000ull; break;
    case 'm': scale = 1000000ull; break;
    case 'u': scale = 1000ull; break;
    case 'n': scale = 1; break;
    default: return 0;
    }
    int64_t now = fwp_now_ns();
    uint64_t ns = x > (uint64_t)INT64_MAX / scale ? (uint64_t)INT64_MAX : x * scale;
    return ns > (uint64_t)(INT64_MAX - now) ? INT64_MAX : now + (int64_t)ns;
}

static void g_start_call(g_conn *c, g_stream *s) {
    g_job *j = (g_job *)fwp_mem_alloc(sizeof *j);
    j->c = c;
    j->s = s;
    j->srv = c->server;
    const char *path = h2_get(&s->headers, ":path");
    if (!path) path = "";
    j->route = g_route_of(j->srv, path);
    if (j->route && j->route->kind == G_ROUTE_METHOD)
        snprintf(j->what, sizeof j->what, "%s.%s", j->srv->module, j->route->m->name);
    else
        snprintf(j->what, sizeof j->what, "%s", path[0] == '/' ? path + 1 : path);
    j->sv.headers = &s->headers;
    j->sv.code = -1;
    j->sv.peer = c->ssl ? fwp_tls_peer_subject(c->ssl) : 0;
    j->sv.peer_users = 1;
    fwp_cleanup peer_cleanup;
    fwp_cleanup_push(&peer_cleanup, g_job_peer_finish, j);
    j->sv.s = s;
    /* responses are compressed like the requests */
    const char *enc = h2_get(&s->headers, "grpc-encoding");
    s->gzip = enc && strcmp(enc, "gzip") == 0;
    j->ctx.serving = &j->sv;
    s->task = fwp_spawn_task(0, g_handle, j, g_parse_timeout(h2_get(&s->headers, "grpc-timeout")), 0);
    j->sv.task = s->task;
    s->task->gctx = &j->ctx;
    s->task->cfinish = g_job_peer_finish;
    fwp_cleanup_pop(&peer_cleanup);
}

/* end a served call with its status (code < 0: OK) */
static void g_finish(g_conn *c, g_stream *s, int code, const char *msg) {
    if (c->dead || s->reset || s->local_end) { g_unlink(c, s); return; }
    h2_buf blk = {0};
    int headers_too = !s->sent_headers;
    if (!s->sent_headers) {
        h2_hpack_lit(&blk, ":status", "200");
        h2_hpack_lit(&blk, "content-type", "application/grpc");
    }
    char cs[16];
    snprintf(cs, sizeof cs, "%d", code < 0 ? 0 : code);
    h2_hpack_lit(&blk, "grpc-status", cs);
    if (code > 0) {
        h2_buf m = {0};
        h2_pct_encode(&m, msg ? msg : "");
        h2_hpack_lit(&blk, "grpc-message", (const char *)m.d);
        h2b_free(&m);
    }
    if (headers_too)
        for (size_t i = 0; i < s->out_headers.n; i++)
            h2_hpack_lit(&blk, s->out_headers.v[i].name, s->out_headers.v[i].value);
    for (size_t i = 0; i < s->out_trailers.n; i++)
        h2_hpack_lit(&blk, s->out_trailers.v[i].name, s->out_trailers.v[i].value);
    h2_header_frames(&c->out, s->id, &blk, 1, c->peer.max_frame);
    h2b_free(&blk);
    s->local_end = 1;
    if (!s->remote_end) {
        unsigned char z[4] = {0, 0, 0, 0};
        h2_frame(&c->out, H2_RST_STREAM, 0, s->id, z, 4);
    }
    g_unlink(c, s);
    fwp_wake_all(&c->writer_wl);
}

/* the single request message of a call: 0 and a status on failure */
static g_msg *g_recv_one(g_job *j, int *code, char **msg) {
    g_got g;
    g_recv(j->c, j->s, 0, &g);
    fwp_cleanup first_cleanup;
    fwp_cleanup_push(&first_cleanup, g_got_release, &g);
    if (g.kind != G_MSG) {
        if (g.kind == G_LOST && !j->s->bad) { fwp_cancel_tree(fwp_cur); fwp_check_cancel(); }
        *code = GRPC_INVALID_ARGUMENT;
        *msg = g.kind == G_LOST ? g.text : strdup("missing request message");
        if (g.kind == G_LOST) g.text = 0;
        fwp_cleanup_pop(&first_cleanup);
        g_got_release(&g);
        return 0;
    }
    g_got e;
    g_recv(j->c, j->s, 0, &e);
    fwp_cleanup second_cleanup;
    fwp_cleanup_push(&second_cleanup, g_got_release, &e);
    if (e.kind == G_END) {
        g_msg *result = g.m;
        g.m = 0;
        fwp_cleanup_pop(&second_cleanup);
        g_got_release(&e);
        fwp_cleanup_pop(&first_cleanup);
        g_got_release(&g);
        return result;
    }
    if (e.kind == G_LOST && !j->s->bad) { fwp_cancel_tree(fwp_cur); fwp_check_cancel(); }
    *code = GRPC_INVALID_ARGUMENT;
    *msg = e.kind == G_LOST ? e.text : strdup("expected one request message");
    if (e.kind == G_LOST) e.text = 0;
    fwp_cleanup_pop(&second_cleanup);
    g_got_release(&e);
    fwp_cleanup_pop(&first_cleanup);
    g_got_release(&g);
    return 0;
}

/* apply a function to the arguments of a call: 0 with the result, 1 with
 * an error, 2 after a trap (its message in fwp_trap_msg) */
static int g_apply_user(V f, uint32_t n, V *args, V *out, V *err, const fwp_desc **edesc) {
    fwp_task *t = fwp_cur;
    jmp_buf *saved = t->trap_jb;
    fwp_cleanup *saved_cleanup = t->trap_cleanup;
    fwp_cleanup *cleanup_base = fwp_cleanups;
    jmp_buf tj;
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = fwp_state_len;
    h.cleanup = fwp_cleanups;
    if (setjmp(tj) != 0) {
        t->trap_jb = saved;
        t->trap_cleanup = saved_cleanup;
        fwp_handlers = h.prev;
        fwp_state_len = h.state_depth;
        return 2;
    }
    t->trap_jb = &tj;
    t->trap_cleanup = cleanup_base;
    fwp_handlers = &h;
    if (setjmp(h.jb) == 0) {
        V r = n ? fwp_apply(f, n, args) : fwp_apply1(f, FWP_UNIT);
        fwp_handlers = h.prev;
        t->trap_jb = saved;
        t->trap_cleanup = saved_cleanup;
        *out = r;
        return 0;
    }
    fwp_handlers = h.prev;
    fwp_state_len = h.state_depth;
    t->trap_jb = saved;
    t->trap_cleanup = saved_cleanup;
    *err = h.value;
    *edesc = h.desc;
    return 1;
}

/* cancel the tasks a call started and wait for them */
static void g_abort_children(void) {
    for (fwp_task *c = fwp_cur->first_child; c; c = c->next_sibling) fwp_cancel_tree(c);
    fwp_join_children();
}

/* the outcome of a served function as a status: -1 when it returned (or
 * its error goes in the response, *in_response), else a status code and
 * *msg */
static int g_outcome(g_job *j, int k, V err, const fwp_desc *ed, int *in_response, char **msg) {
    *in_response = 0;
    if (k == 0) { fwp_join_children(); return -1; }
    g_abort_children();
    if (k == 2) {
        fflush(fwp_prog_out);
        fprintf(stderr, "fwp: trap: %s (in %s)\n", fwp_trap_msg, j->what);
        *msg = g_strdupf("trap: %s", fwp_trap_msg);
        return GRPC_INTERNAL;
    }
    if (g_grpc_error_desc && ed == g_grpc_error_desc) {
        *msg = strdup(STR(OBJ(err)->f[1])->d);
        return g_error_code(err);
    }
    if (j->route->kind == G_ROUTE_METHOD && j->route->m->error) { *in_response = 1; return -1; }
    fwp_buf b = {0};
    fwp_write(&b, err, ed, 1);
    *msg = g_strdupf("error: %.*s", (int)b.len, b.d ? b.d : "");
    free(b.d);
    return GRPC_INTERNAL;
}

static int g_run_method(g_job *j, char **msg) {
    const fwp_rpc *m = j->route->m;
    const char *fp = h2_get(&j->s->headers, "fwp-fingerprint");
    if (fp && strcmp(fp, m->fingerprint) != 0) {
        *msg = g_strdupf("interface mismatch: the caller of %s was built against a different version of it", j->what);
        return GRPC_FAILED_PRECONDITION;
    }
    V *args = (V *)fwp_alloc((size_t)(m->nreq + 2) * sizeof(V));
    int na = 0;
    if (m->input == 0) {
        int code;
        g_msg *req = g_recv_one(j, &code, msg);
        if (!req) return code;
        h2_buf canon = {0};
        if (!pb_decode(m->schema, m->req_node, req->d, req->n, &canon)) {
            h2b_free(&canon);
            free(req);
            *msg = strdup("malformed request message");
            return GRPC_INVALID_ARGUMENT;
        }
        free(req);
        fwp_rd rd = {canon.d, canon.len, 0};
        for (int i = 0; i < m->nreq; i++)
            if (!fwp_decode(&rd, m->req[i], &args[na++])) {
                h2b_free(&canon);
                *msg = strdup("malformed request message");
                return GRPC_INVALID_ARGUMENT;
            }
        h2b_free(&canon);
    } else {
        g_incoming *src = (g_incoming *)fwp_mem_alloc(sizeof *src);
        src->c = j->c;
        src->s = j->s;
        src->server = 1;
        g_codec d = {0, m->schema, m->req_node, m->req[0], 0};
        src->dec = d;
        src->what = j->what;
        g_cell *cell = (g_cell *)fwp_mem_alloc(sizeof *cell);
        cell->src = src;
        args[na++] = fwp_apply1(fwp_pap((uint32_t)m->iter_fn, 0, 0), PTR(cell));
    }
    g_codec enc = {0, m->schema, m->resp_node, m->resp, 0};
    if (m->output == 2) args[na++] = g_sink_value(j->c, j->s, enc, m->error != 0);
    V v = 0, err = 0;
    const fwp_desc *ed = 0;
    int k = g_apply_user(fwp_pap((uint32_t)m->fn, 0, 0), (uint32_t)na, args, &v, &err, &ed);
    int in_response;
    int code = g_outcome(j, k, err, ed, &in_response, msg);
    if (code >= 0) return code;
    if (in_response) {
        fwp_buf canon = {0};
        fwp_cleanup error_canonical;
        fwp_cleanup_push(&error_canonical, fwp_file_buffer_cleanup, &canon);
        buf_putc(&canon, 1);
        fwp_encode(&canon, err, m->error);
        h2_buf b = {0};
        fwp_cleanup response_buffer;
        fwp_cleanup_push(&response_buffer, g_h2_buffer_release, &b);
        if (!pb_encode(m->schema, m->resp_node, (const unsigned char *)canon.d, canon.len, &b))
            g_trapf("cannot encode a message: %s", h2_err);
        fwp_cleanup_pop(&response_buffer);
        fwp_cleanup_pop(&error_canonical);
        free(canon.d);
        fwp_cleanup_push(&response_buffer, g_h2_buffer_release, &b);
        g_send_msg(j->c, j->s, b.d, b.len, 0);
        fwp_cleanup_pop(&response_buffer);
        h2b_free(&b);
        return -1;
    }
    if (m->output == 0) {
        h2_buf b = {0};
        fwp_cleanup response_buffer;
        fwp_cleanup_push(&response_buffer, g_h2_buffer_release, &b);
        g_encode(&enc, v, m->error != 0, &b);
        g_send_msg(j->c, j->s, b.d, b.len, 0);
        fwp_cleanup_pop(&response_buffer);
        h2b_free(&b);
    } else if (m->output == 1 || m->output == 3) {
        /* forcing the iterator may trap */
        jmp_buf *saved = fwp_cur->trap_jb;
        fwp_cleanup *saved_cleanup = fwp_cur->trap_cleanup;
        fwp_cleanup *cleanup_base = fwp_cleanups;
        jmp_buf tj;
        volatile V cur = v;
        if (setjmp(tj) != 0) {
            fwp_cur->trap_jb = saved;
            fwp_cur->trap_cleanup = saved_cleanup;
            fflush(fwp_prog_out);
            fprintf(stderr, "fwp: trap: %s (in %s)\n", fwp_trap_msg, j->what);
            *msg = g_strdupf("trap: %s", fwp_trap_msg);
            return GRPC_INTERNAL;
        }
        for (;;) {
            V x = 0, next = cur;
            fwp_cur->trap_jb = &tj;
            fwp_cur->trap_cleanup = cleanup_base;
            int more = g_iter_next(&next, &x);
            fwp_cur->trap_jb = saved;
            fwp_cur->trap_cleanup = saved_cleanup;
            if (!more) break;
            cur = next;
            if (m->output == 3) {
                /* a stream of results ends at an `Err`, with its status */
                if (fwp_tag(x) == 1) {
                    V e = OBJ(x)->f[0];
                    int64_t code = (int64_t)OBJ(e)->f[0];
                    *msg = strdup(STR(OBJ(e)->f[1])->d);
                    return code >= 1 && code <= 16 ? (int)code : GRPC_UNKNOWN;
                }
                x = OBJ(x)->f[0];
            }
            h2_buf b = {0};
            fwp_cleanup response_buffer;
            fwp_cleanup_push(&response_buffer, g_h2_buffer_release, &b);
            g_encode(&enc, x, m->error != 0, &b);
            int ok = g_send_msg(j->c, j->s, b.d, b.len, 0);
            fwp_cleanup_pop(&response_buffer);
            h2b_free(&b);
            if (!ok) { fwp_check_cancel(); break; }
        }
    }
    return -1;
}

static void g_put_bytes(h2_buf *b, uint32_t num, const void *p, size_t n) {
    pb_key(b, num, 2);
    pb_varint(b, n);
    h2b_put(b, p, n);
}

static int g_known_service(const g_server *srv, const char *name) {
    if (srv->svc)
        for (int i = 0; i < srv->svc->nservices; i++)
            if (strcmp(srv->svc->services[i], name) == 0) return 1;
    for (size_t i = 0; i < srv->nservices; i++)
        if (strcmp(srv->services[i], name) == 0) return 1;
    return 0;
}

static int g_health(g_job *j, int watch, char **msg) {
    int code;
    g_msg *req = g_recv_one(j, &code, msg);
    if (!req) return code;
    char name[512] = "";
    size_t i = 0;
    pb_field f;
    while (pb_next(req->d, req->n, &i, &f) > 0)
        if (f.num == 1 && f.wire == 2 && f.n < sizeof name) {
            memcpy(name, f.p, f.n);
            name[f.n] = 0;
        }
    free(req);
    unsigned char serving[2] = {0x08, 0x01}, unknown[2] = {0x08, 0x03};
    if (name[0] && !g_known_service(j->srv, name)) {
        if (!watch) {
            *msg = g_strdupf("unknown service %s", name);
            return GRPC_NOT_FOUND;
        }
        g_send_msg(j->c, j->s, unknown, 2, 0);
    } else {
        g_send_msg(j->c, j->s, serving, 2, 0);
    }
    if (watch)
        for (;;) {
            if (g_cancelled()) fwp_check_cancel();
            fwp_park(&j->s->waiters, 0);
        }
    return -1;
}

static void g_reflection_response(const g_server *srv, const unsigned char *req, size_t n, h2_buf *out) {
    const fwp_service *svc = srv->svc;
    size_t i = 0;
    pb_field f, host, kind;
    memset(&host, 0, sizeof host);
    memset(&kind, 0, sizeof kind);
    while (pb_next(req, n, &i, &f) > 0) {
        if (f.num == 1 && f.wire == 2) host = f;
        if (f.num >= 3 && f.num <= 7 && f.wire == 2 && !kind.num) kind = f;
    }
    if (host.num) g_put_bytes(out, 1, host.p, host.n);
    g_put_bytes(out, 2, req, n);
    char text[512];
    size_t tn = kind.n < sizeof text - 1 ? kind.n : sizeof text - 1;
    if (kind.num) memcpy(text, kind.p, tn);
    text[kind.num ? tn : 0] = 0;
    int ok = 0;
    if (kind.num == 7) {
        h2_buf l = {0};
        for (int k = 0; k <= svc->nservices; k++) {
            const char *name = k < svc->nservices ? svc->services[k] : "grpc.health.v1.Health";
            h2_buf sr = {0};
            g_put_bytes(&sr, 1, name, strlen(name));
            g_put_bytes(&l, 1, sr.d, sr.len);
            h2b_free(&sr);
        }
        g_put_bytes(out, 6, l.d, l.len);
        h2b_free(&l);
        return;
    }
    if (kind.num == 6) {
        h2_buf e = {0};
        g_put_bytes(&e, 1, kind.p, kind.n);
        g_put_bytes(out, 5, e.d, e.len);
        h2b_free(&e);
        return;
    }
    if ((kind.num == 3 && strcmp(text, "grpc/health/v1/health.proto") == 0) ||
        (kind.num == 4 && strncmp(text, "grpc.health.v1.", 15) == 0)) {
        h2_buf d = {0};
        g_put_bytes(&d, 1, svc->health, svc->health_len);
        g_put_bytes(out, 4, d.d, d.len);
        h2b_free(&d);
        return;
    }
    if (kind.num == 3) ok = strcmp(text, svc->file) == 0;
    if (kind.num == 4) {
        size_t pl = strlen(svc->package);
        ok = pl && strncmp(text, svc->package, pl) == 0 && text[pl] == '.';
        for (int k = 0; !ok && k < svc->nservices; k++) {
            size_t sl = strlen(svc->services[k]);
            ok = strncmp(text, svc->services[k], sl) == 0 && (text[sl] == 0 || text[sl] == '.');
        }
    }
    if (ok) {
        h2_buf d = {0};
        g_put_bytes(&d, 1, svc->descriptor, svc->descriptor_len);
        g_put_bytes(out, 4, d.d, d.len);
        h2b_free(&d);
        return;
    }
    char m[700];
    int code = GRPC_NOT_FOUND;
    if (kind.num == 3) snprintf(m, sizeof m, "unknown file %s", text);
    else if (kind.num == 4) snprintf(m, sizeof m, "unknown symbol %s", text);
    else if (kind.num) snprintf(m, sizeof m, "no extension %s", text);
    else { snprintf(m, sizeof m, "unsupported reflection request"); code = GRPC_INVALID_ARGUMENT; }
    h2_buf e = {0};
    pb_key(&e, 1, 0);
    pb_varint(&e, (uint64_t)code);
    g_put_bytes(&e, 2, m, strlen(m));
    g_put_bytes(out, 7, e.d, e.len);
    h2b_free(&e);
}

static int g_reflect(g_job *j, char **msg) {
    for (;;) {
        g_got g;
        g_recv(j->c, j->s, 0, &g);
        if (g.kind == G_END) { free(g.text); return -1; }
        if (g.kind == G_LOST) {
            *msg = g.text;
            return GRPC_INVALID_ARGUMENT;
        }
        h2_buf out = {0};
        g_reflection_response(j->srv, g.m->d, g.m->n, &out);
        free(g.m);
        g_send_msg(j->c, j->s, out.d, out.len, 0);
        h2b_free(&out);
    }
}

/* the task serving one call */
static void g_handle(void *arg, int cancelled) {
    g_job *j = (g_job *)arg;
    int code = -1;
    char *msg = 0;
    /* calls of the program's functions (not of reflection and health
     * checking) are logged when they are cancelled */
    int logged = j->route && j->route->kind == G_ROUTE_METHOD;
    if (!cancelled) {
        const char *path = h2_get(&j->s->headers, ":path");
        if (!j->route) {
            code = GRPC_UNIMPLEMENTED;
            msg = g_strdupf("unknown method %s", path ? path : "");
        } else {
            switch (j->route->kind) {
            case G_ROUTE_METHOD: code = g_run_method(j, &msg); break;
            case G_ROUTE_HEALTH: code = g_health(j, 0, &msg); break;
            case G_ROUTE_WATCH: code = g_health(j, 1, &msg); break;
            default: code = g_reflect(j, &msg); break;
            }
        }
    } else if (j->sv.code >= 0) {
        code = j->sv.code;
        msg = j->sv.msg;
        j->sv.msg = 0;
    } else if (j->s->reset || j->c->dead) {
        fflush(fwp_prog_out);
        if (logged) fprintf(stderr, "fwp: call cancelled by the client (in %s)\n", j->what);
    } else if (fwp_cur->deadline && fwp_now_ns() >= fwp_cur->deadline) {
        fflush(fwp_prog_out);
        if (logged) fprintf(stderr, "fwp: deadline exceeded (in %s)\n", j->what);
        code = GRPC_DEADLINE_EXCEEDED;
        msg = strdup("deadline exceeded");
    } else {
        code = GRPC_CANCELLED;
        msg = strdup("cancelled");
    }
    fflush(fwp_prog_out);
    fwp_cleanup message_cleanup;
    fwp_cleanup_push(&message_cleanup, fwp_tls_subject_free, msg);
    g_finish(j->c, j->s, code, msg);
    fwp_cleanup_pop(&message_cleanup);
    fwp_tls_subject_free(msg);
}

/* accept connections and serve them, until the task is cancelled */
static void g_accept_loop(int lfd, const g_server *srv) {
    fwp_nonblock(lfd);
    fwp_trap_recover = g_trap_recover;
    for (;;) {
        struct sockaddr_storage ss;
        socklen_t sl = sizeof ss;
        int fd = accept(lfd, (struct sockaddr *)&ss, &sl);
        if (fd >= 0) {
            fwp_nonblock(fd);
            int one = 1;
            setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof one);
            char peer[128];
            fwp_fmt_addr((struct sockaddr *)&ss, peer, sizeof peer);
            g_conn *c = g_conn_new(fd, peer, srv);
            if (srv->tls) c->ssl = (SSL *)fwp_tls_accepted(srv->tls, fd);
            /* the reader starts the writer (after a TLS handshake) */
            c->refs = 1;
            fwp_spawn_task(0, g_reader, c, 0, 0);
            continue;
        }
        if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR || errno == ECONNABORTED) {
            fwp_wait_fd(lfd, 0, 0);
            continue;
        }
        /* out of descriptors: let connections close */
        fwp_check_cancel();
        fwp_park(0, fwp_now_ns() + 50000000LL);
    }
}

static const char *const g_builtin_paths[4] = {
    "/grpc.reflection.v1.ServerReflection/ServerReflectionInfo",
    "/grpc.reflection.v1alpha.ServerReflection/ServerReflectionInfo",
    "/grpc.health.v1.Health/Check",
    "/grpc.health.v1.Health/Watch",
};

/* serve a module's exported functions (a service executable) */
/* the TLS context of a server with a certificate and key (`--tls-cert`,
 * `--tls-key`, else FWP_TLS_CERT and FWP_TLS_KEY); 0 without them, and
 * -1 (reported) on errors */
static SSL_CTX *g_server_tls(const char *cert, const char *key, const char *ca, int *failed) {
    *failed = 0;
    if (!cert || !*cert) cert = getenv("FWP_TLS_CERT");
    if (!key || !*key) key = getenv("FWP_TLS_KEY");
    if (!ca || !*ca) ca = getenv("FWP_TLS_CLIENT_CA");
    if (cert && !*cert) cert = 0;
    if (key && !*key) key = 0;
    if (!ca) ca = "";
    if (!cert && !key && *ca) {
        fprintf(stderr, "fwp serve: client certificates (--tls-client-ca or FWP_TLS_CLIENT_CA) need a server "
                        "certificate and key (--tls-cert and --tls-key)\n");
        *failed = 1;
        return 0;
    }
    if (!cert && !key) return 0;
    if (!cert || !key) {
        fprintf(stderr, "fwp serve: %s\n",
                cert ? "a TLS certificate needs a key (--tls-key or FWP_TLS_KEY)"
                     : "a TLS key needs a certificate (--tls-cert or FWP_TLS_CERT)");
        *failed = 1;
        return 0;
    }
    unsigned char *alpn = (unsigned char *)strdup("\x02h2");
    if (!alpn) {
        fprintf(stderr, "fwp serve: cannot allocate TLS protocol list\n");
        *failed = 1;
        return 0;
    }
    SSL_CTX *ctx = fwp_tls_server_ctx(cert, key, alpn, 3, ca);
    if (!ctx) {
        free(alpn);
        fprintf(stderr, "fwp serve: %s\n", fwp_tls_err);
        *failed = 1;
    }
    return ctx;
}

typedef struct { int fd; SSL_CTX *tls; } g_listener_owner;
static void g_listener_finish(void *p) {
    g_listener_owner *owner = (g_listener_owner *)p;
    if (owner->fd >= 0) {
        int fd = owner->fd;
        owner->fd = -1;
        fwp_fd_closing(fd);
        close(fd);
    }
    if (owner->tls) {
        SSL_CTX *ctx = owner->tls;
        owner->tls = 0;
        fwp_tls_server_drop(ctx);
    }
}

static int fwp_serve(const fwp_service *s, int argc, char **argv) {
    const char *listen_at = 0, *cert = 0, *key = 0, *ca = 0;
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--listen") == 0 && i + 1 < argc) listen_at = argv[++i];
        else if (strncmp(argv[i], "--listen=", 9) == 0) listen_at = argv[i] + 9;
        else if (strcmp(argv[i], "--tls-cert") == 0 && i + 1 < argc) cert = argv[++i];
        else if (strncmp(argv[i], "--tls-cert=", 11) == 0) cert = argv[i] + 11;
        else if (strcmp(argv[i], "--tls-key") == 0 && i + 1 < argc) key = argv[++i];
        else if (strncmp(argv[i], "--tls-key=", 10) == 0) key = argv[i] + 10;
        else if (strcmp(argv[i], "--tls-client-ca") == 0 && i + 1 < argc) ca = argv[++i];
        else if (strncmp(argv[i], "--tls-client-ca=", 16) == 0) ca = argv[i] + 16;
        else {
            fprintf(stderr,
                    "usage: %s [--listen host:port] [--tls-cert file --tls-key file [--tls-client-ca file]]\n",
                    argv[0]);
            return 2;
        }
    }
    int failed;
    SSL_CTX *tls = g_server_tls(cert, key, ca, &failed);
    if (failed) return 1;
    g_listener_owner listener = {-1, tls};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, g_listener_finish, &listener);
    if (!listen_at) {
        listen_at = getenv(s->env);
        if (!listen_at || !*listen_at) listen_at = s->default_addr;
    }
    /* `tls://host:port` (as clients are given it) is host:port, with TLS */
    char hostport[300];
    int secure;
    g_addr(listen_at, &secure, hostport, sizeof hostport);
    if (secure && !tls) {
        fprintf(stderr,
                "fwp serve: %s needs a certificate and key (--tls-cert and --tls-key, or FWP_TLS_CERT and "
                "FWP_TLS_KEY)\n",
                listen_at);
        fwp_cleanup_pop(&cleanup);
        g_listener_finish(&listener);
        return 1;
    }
    char bound[300];
    int fd = h2_listen(hostport, bound, sizeof bound);
    listener.fd = fd;
    if (fd < 0) {
        fprintf(stderr, "fwp serve: %s\n", h2_err);
        fwp_cleanup_pop(&cleanup);
        g_listener_finish(&listener);
        return 1;
    }
    g_server *srv = (g_server *)fwp_mem_alloc(sizeof *srv);
    srv->n = (size_t)s->n + 4;
    srv->routes = (g_route *)fwp_mem_alloc((srv->n) * sizeof(g_route));
    for (int i = 0; i < s->n; i++) {
        srv->routes[i].path = s->methods[i].path;
        srv->routes[i].kind = G_ROUTE_METHOD;
        srv->routes[i].m = &s->methods[i];
    }
    for (int i = 0; i < 4; i++) {
        srv->routes[s->n + i].path = g_builtin_paths[i];
        srv->routes[s->n + i].kind = i < 2 ? G_ROUTE_REFLECTION : i == 2 ? G_ROUTE_HEALTH : G_ROUTE_WATCH;
    }
    srv->module = s->module;
    srv->svc = s;
    srv->tls = tls;
    g_grpc_error_desc = s->grpc_error;
    fprintf(stderr, "fwp: service %s listening on %s%s\n", s->module, tls ? "tls://" : "", bound);
    fflush(stderr);
    fwp_tasks_init();
    g_accept_loop(fd, srv);
    fwp_cleanup_pop(&cleanup);
    g_listener_finish(&listener);
    return 1;
}

/* -------------------------------------------------------------- primitives */

/* one side of a call (the HTTP/2 streams of runtime/fwp_rt_http2.c) */
typedef struct {
    g_conn *c;
    g_stream *s;
    int server;
    int64_t deadline;
} g_call;

static V g_call_value(g_conn *c, g_stream *s, int server, int64_t deadline) {
    g_call *k = (g_call *)fwp_mem_alloc(sizeof *k);
    k->c = c;
    k->s = s;
    k->server = server;
    k->deadline = deadline;
    return PTR(k);
}

static int g_not_metadata(const char *k) {
    static const char *const no[] = {"content-type", "te", "grpc-timeout", "grpc-encoding", "grpc-accept-encoding",
                                     "fwp-fingerprint"};
    if (k[0] == ':') return 1;
    for (size_t i = 0; i < sizeof no / sizeof no[0]; i++)
        if (strcmp(k, no[i]) == 0) return 1;
    return 0;
}

static V fwp_p_grpc_metadata(void) {
    g_serving *sv = g_ctx_of()->serving;
    if (!sv) return 0;
    V *items = (V *)fwp_alloc((sv->headers->n + 1) * sizeof(V));
    size_t n = 0;
    for (size_t i = 0; i < sv->headers->n; i++) {
        const h2_hdr *h = &sv->headers->v[i];
        if (g_not_metadata(h->name)) continue;
        items[n++] = fwp_tuple2(fwp_cstr(h->name), fwp_cstr(h->value));
    }
    return fwp_list_from(items, n);
}

/* run `f` with a context, restoring the task's afterwards */
static V g_with_ctx(g_ctx *ctx, V f) {
    fwp_task *t = fwp_cur;
    void *saved = t->gctx;
    t->gctx = ctx;
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = fwp_state_len;
    h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (setjmp(h.jb) == 0) {
        V r = fwp_apply1(f, FWP_UNIT);
        fwp_handlers = h.prev;
        t->gctx = saved;
        return r;
    }
    fwp_handlers = h.prev;
    fwp_state_len = h.state_depth;
    t->gctx = saved;
    fwp_fail(h.value, h.desc);
    return 0;
}

static V fwp_p_grpc_with_metadata(V md, V f) {
    g_ctx *cur = g_ctx_of();
    g_ctx *ctx = (g_ctx *)fwp_alloc(sizeof *ctx);
    *ctx = *cur;
    size_t n;
    V *items = fwp_list_items(md, &n);
    ctx->kv = (const char **)fwp_alloc((cur->n + n + 1) * 2 * sizeof(char *));
    if (cur->n) memcpy(ctx->kv, cur->kv, cur->n * 2 * sizeof(char *));
    size_t k = cur->n;
    for (size_t i = 0; i < n; i++) {
        V kv = items[i];
        fwp_str *key = STR(OBJ(kv)->f[0]), *val = STR(OBJ(kv)->f[1]);
        if (key->len == 0 || key->d[0] == ':') continue;
        char *lk = (char *)fwp_alloc_leaf(key->len + 1), *lv = (char *)fwp_alloc_leaf(val->len + 1);
        for (size_t c = 0; c < key->len; c++) lk[c] = (char)tolower((unsigned char)key->d[c]);
        lk[key->len] = 0;
        for (size_t c = 0; c < val->len; c++) lv[c] = val->d[c] == '\r' || val->d[c] == '\n' ? ' ' : val->d[c];
        lv[val->len] = 0;
        ctx->kv[2 * k] = lk;
        ctx->kv[2 * k + 1] = lv;
        k++;
    }
    ctx->n = k;
    return g_with_ctx(ctx, f);
}

static V g_pairs_value(const h2_hdrs *h) {
    V *items = (V *)fwp_alloc((h->n + 1) * sizeof(V));
    for (size_t i = 0; i < h->n; i++) items[i] = fwp_tuple2(fwp_cstr(h->v[i].name), fwp_cstr(h->v[i].value));
    return fwp_list_from(items, h->n);
}

/* a response header (0) or trailer (1) of the call the task serves */
static V fwp_p_grpc_set_meta(int trailer, V name, V value) {
    g_serving *sv = g_ctx_of()->serving;
    fwp_str *k = STR(name), *v = STR(value);
    if (!sv || !sv->s || k->len == 0 || k->d[0] == ':') return FWP_UNIT;
    char *lk = (char *)malloc(k->len + 1), *lv = (char *)malloc(v->len + 1);
    for (size_t i = 0; i < k->len; i++) lk[i] = (char)tolower((unsigned char)k->d[i]);
    for (size_t i = 0; i < v->len; i++) lv[i] = v->d[i] == '\r' || v->d[i] == '\n' ? ' ' : v->d[i];
    h2_hdrs_add(trailer ? &sv->s->out_trailers : &sv->s->out_headers, lk, k->len, lv, v->len);
    free(lk);
    free(lv);
    return FWP_UNIT;
}

static V fwp_p_grpc_with_gzip(V f) {
    g_ctx *cur = g_ctx_of();
    g_ctx *ctx = (g_ctx *)fwp_alloc(sizeof *ctx);
    *ctx = *cur;
    ctx->gzip = 1;
    return g_with_ctx(ctx, f);
}

static V fwp_p_grpc_with_response_metadata(V f) {
    g_ctx *cur = g_ctx_of();
    g_ctx *ctx = (g_ctx *)fwp_alloc(sizeof *ctx);
    *ctx = *cur;
    h2_hdrs *cap = (h2_hdrs *)calloc(1, sizeof *cap);
    ctx->capture = cap;
    V r = g_with_ctx(ctx, f);
    if (cur->capture)
        for (size_t i = 0; i < cap->n; i++)
            h2_hdrs_add(cur->capture, cap->v[i].name, strlen(cap->v[i].name), cap->v[i].value,
                        strlen(cap->v[i].value));
    V md = g_pairs_value(cap);
    h2_hdrs_free(cap);
    free(cap);
    return fwp_tuple2(r, md);
}

static V fwp_p_grpc_peer_subject(void) {
    g_serving *sv = g_ctx_of()->serving;
    if (!sv || !sv->peer) return FWP_NONE;
    return fwp_some(fwp_cstr(sv->peer));
}

/* the text of an `Option[String]` field ("" for None) */
static const char *g_opt_text(V o) { return o == FWP_NONE ? "" : STR(OBJ(o)->f[0])->d; }

/* TlsOptions, with the indices of its fields ca-file, insecure,
 * server-name, cert-file and key-file */
static V fwp_p_grpc_with_tls(V o, V f, int ica, int iins, int iname, int icert, int ikey) {
    g_ctx *cur = g_ctx_of();
    g_ctx *ctx = (g_ctx *)fwp_alloc(sizeof *ctx);
    *ctx = *cur;
    V *fs = OBJ(o)->f;
    ctx->tls = g_tls_new(g_opt_text(fs[ica]), fs[iins] == FWP_TRUE, g_opt_text(fs[iname]), g_opt_text(fs[icert]),
                         g_opt_text(fs[ikey]));
    return g_with_ctx(ctx, f);
}

static V fwp_p_grpc_with_deadline(V d, V f) {
    g_ctx *cur = g_ctx_of();
    g_ctx *ctx = (g_ctx *)fwp_alloc(sizeof *ctx);
    *ctx = *cur;
    ctx->deadline = g_earliest(cur->deadline, fwp_after(d));
    return g_with_ctx(ctx, f);
}

static V fwp_p_grpc_force(V cell) {
    g_failure f = {0, 0};
    V ev = 0;
    const fwp_desc *ed = 0;
    return g_force((g_cell *)(uintptr_t)cell, 0, &f, &ev, &ed);
}

#endif /* __wasi__ */
