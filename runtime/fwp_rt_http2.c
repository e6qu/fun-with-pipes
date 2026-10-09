/* fwp runtime: HTTP/2 for the HTTP server and client of lib/http.fwp, on
 * the HTTP/2 connections of fwp_rt_grpc.c (framing, HPACK, flow control,
 * the reader and writer tasks), plus the primitives of HTTP compression
 * (zlib.*) and of WebSocket frames (ws.*). Mirrors src/h2web.rs.
 *
 * A server connection (http2.serve) runs in the task of the HTTP/1.1
 * connection that turned out to be HTTP/2: it reads frames itself (with
 * the idle timeout, and a graceful GOAWAY on shutdown or after the
 * requests per connection) and starts a task per stream, which runs an
 * fwp function of lib/http.fwp that reads the request and writes the
 * response with the http2.* primitives. Client connections (http2.send)
 * are pooled per origin. Embedded with the services runtime. */

#ifndef __wasi__

/* streams open at once on a server connection; more are refused */
#define W_MAX_STREAMS 128

struct g_web {
    V handler;                 /* the fwp function run for every stream */
    size_t max_header;
    uint64_t max_requests, served;
    int draining;              /* GOAWAY was sent: new streams are refused */
};

static void w_rst(g_conn *c, uint32_t sid, uint32_t code) {
    unsigned char p[4] = {(unsigned char)(code >> 24), (unsigned char)(code >> 16), (unsigned char)(code >> 8),
                          (unsigned char)code};
    h2_frame(&c->out, H2_RST_STREAM, 0, sid, p, 4);
}

static void w_goaway(g_conn *c) {
    unsigned char p[8] = {0};
    for (int i = 0; i < 4; i++) p[i] = (unsigned char)(c->last_stream >> (24 - 8 * i));
    h2_frame(&c->out, H2_GOAWAY, 0, 0, p, 8);
}

static size_t w_count(g_conn *c) {
    size_t n = 0;
    for (g_stream *s = c->streams; s; s = s->next) n++;
    return n;
}

static void g_web_stream(g_conn *c, uint32_t sid, h2_hdrs *hs, int end, g_slist *fresh) {
    struct g_web *w = (struct g_web *)c->web;
    if (sid % 2 == 0 || sid <= c->last_stream) { h2_hdrs_free(hs); return; }
    c->last_stream = sid;
    if (w->draining || w_count(c) >= W_MAX_STREAMS) {
        h2_hdrs_free(hs);
        w_rst(c, sid, 7); /* REFUSED_STREAM */
        return;
    }
    size_t size = 0;
    for (size_t i = 0; i < hs->n; i++) size += strlen(hs->v[i].name) + strlen(hs->v[i].value) + 4;
    if (size > w->max_header) {
        h2_hdrs_free(hs);
        h2_buf blk = {0};
        h2_hpack_lit(&blk, ":status", "431");
        h2_header_frames(&c->out, sid, &blk, 1, c->peer.max_frame);
        h2b_free(&blk);
        if (!end) w_rst(c, sid, 0);
        return;
    }
    const char *m = h2_get(hs, ":method"), *p = h2_get(hs, ":path");
    if (!m || !*m || !p || !*p) {
        h2_hdrs_free(hs);
        w_rst(c, sid, 1); /* PROTOCOL_ERROR */
        return;
    }
    w->served++;
    if (w->served >= w->max_requests) {
        w->draining = 1;
        w_goaway(c);
    }
    g_stream *s = g_stream_new(c, sid);
    s->headers = *hs;
    s->got_headers = 1;
    s->remote_end = end;
    s->raw = 1;
    g_slist_add(fresh, s);
}

/* a stream's task */
typedef struct {
    g_conn *c;
    g_stream *s;
    V handler, call;
} w_job;

static void w_end_stream(g_conn *c, g_stream *s) {
    if (!c->dead && s->listed) {
        if (!s->local_end) w_rst(c, s->id, 2);      /* INTERNAL_ERROR */
        else if (!s->remote_end) w_rst(c, s->id, 0); /* NO_ERROR */
        g_unlink(c, s);
    }
    fwp_wake_all(&c->writer_wl);
}

static void w_handle(void *arg, int cancelled) {
    w_job *j = (w_job *)arg;
    if (!cancelled) fwp_apply1(j->handler, j->call);
    fflush(fwp_prog_out);
    w_end_stream(j->c, j->s);
}

static void w_start(g_conn *c, g_stream *s) {
    w_job *j = (w_job *)fwp_mem_alloc(sizeof *j);
    j->c = c;
    j->s = s;
    j->handler = ((struct g_web *)c->web)->handler;
    j->call = g_call_value(c, s, 1, 0);
    s->task = fwp_spawn_task(0, w_handle, j, 0, 0);
}

/* the conn's socket and TLS session, which the HTTP/2 connection takes */
static int w_take(V conn, SSL **ssl) {
    int fd = SOCK(conn)->fd;
    *ssl = (SSL *)SOCK(conn)->tls;
    SOCK(conn)->fd = -1;
    SOCK(conn)->tls = 0;
    return fd;
}

static void w_upgraded(g_conn *c, V r, g_slist *fresh);

/* serve an HTTP/2 connection; one upgraded from HTTP/1.1 (Upgrade: h2c)
 * brings its request, (method, target, headers, body), as stream 1 */
static V fwp_p_http2_serve(V conn, V initial, V limits, V handler, V upgraded) {
    SSL *ssl;
    int fd = w_take(conn, &ssl);
    if (fd < 0) return FWP_UNIT;
    char peer[128] = "";
    struct sockaddr_storage ss;
    socklen_t sl = sizeof ss;
    if (getpeername(fd, (struct sockaddr *)&ss, &sl) == 0) fwp_fmt_addr((struct sockaddr *)&ss, peer, sizeof peer);
    g_conn *c = g_conn_new(fd, peer, 0);
    c->out.len = 0;
    h2_our_settings(&c->out);
    unsigned char st[6] = {0, 3, 0, 0, 0, W_MAX_STREAMS};
    h2_frame(&c->out, H2_SETTINGS, 0, 0, st, 6);
    c->preface = 0;
    c->ssl = ssl;
    struct g_web *w = (struct g_web *)fwp_mem_alloc(sizeof *w);
    w->handler = handler;
    int64_t mh = (int64_t)OBJ(limits)->f[0], mr = (int64_t)OBJ(limits)->f[1];
    w->max_header = mh < 0 ? 0 : (size_t)mh;
    w->max_requests = mr < 1 ? 1 : (uint64_t)mr;
    int64_t idle = fwp_dur_ns(OBJ(limits)->f[2]);
    c->web = w;
    g_slist up = {0, 0, 0};
    if (upgraded != FWP_NONE) w_upgraded(c, OBJ(upgraded)->f[0], &up);
    c->refs = 2;
    fwp_spawn_task(0, g_writer, c, 0, 0);
    for (size_t i = 0; i < up.n; i++) w_start(c, up.v[i]);
    fwp_mem_free(up.v);
    fwp_task *me = fwp_cur;
    int was = me->unwinding;
    me->unwinding = 1; /* cancellation is checked below */
    int64_t last = fwp_now_ns();
    unsigned char *buf = (unsigned char *)malloc(65536);
    const char *why = "connection closed";
    char whybuf[600];
    int first = 1;
    for (;;) {
        ssize_t k;
        const unsigned char *in;
        if (first) {
            first = 0;
            in = (const unsigned char *)STR(initial)->d;
            k = (ssize_t)STR(initial)->len;
        } else {
            if (c->dead) break;
            if (me->cancelled || (me->deadline && fwp_now_ns() >= me->deadline)) { why = "cancelled"; break; }
            if (!w->draining && fwp_p_shutdown_requested() == FWP_TRUE) {
                w->draining = 1;
                w_goaway(c);
                fwp_wake_all(&c->writer_wl);
            }
            int idle_now = c->streams == 0;
            if (idle_now && w->draining) break;
            if (idle_now && fwp_now_ns() - last >= idle) {
                w->draining = 1;
                w_goaway(c);
                break;
            }
            if (!idle_now) last = fwp_now_ns();
            int ww;
            k = g_io_recv(c, buf, 65536, &ww);
            if (k == 0) break;
            if (k < 0) {
                if (k == -1 && (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)) {
                    fwp_wait_fd(c->fd, ww, fwp_now_ns() + 100000000LL);
                    continue;
                }
                snprintf(whybuf, sizeof whybuf, "cannot read from %s: %s", c->authority,
                         k == -2 ? fwp_tls_err : strerror(errno));
                why = whybuf;
                break;
            }
            in = buf;
        }
        last = fwp_now_ns();
        g_slist fresh = {0, 0, 0};
        char *dead = 0;
        g_process(c, in, (size_t)k, &fresh, &dead);
        for (size_t i = 0; i < fresh.n; i++) w_start(c, fresh.v[i]);
        fwp_mem_free(fresh.v);
        g_wake_conn(c);
        if (dead) {
            snprintf(whybuf, sizeof whybuf, "%s", dead);
            free(dead);
            why = whybuf;
            break;
        }
    }
    free(buf);
    /* send what is left (final responses, a GOAWAY) */
    for (int i = 0; i < 100 && c->out.len && !c->dead; i++) {
        int ww;
        ssize_t n = g_io_send(c, c->out.d, c->out.len, &ww);
        if (n > 0) { h2b_drop(&c->out, (size_t)n); continue; }
        if (n == -1 && (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)) {
            fwp_wait_fd(c->fd, ww, fwp_now_ns() + 10000000LL);
            continue;
        }
        break;
    }
    g_conn_dead(c, why);
    g_conn_release(c);
    fwp_join_children();
    me->unwinding = was;
    fwp_check_cancel();
    return FWP_UNIT;
}

#define WCALL(v) ((g_call *)(uintptr_t)(v))

static int w_connection_specific(const char *k) {
    return !strcmp(k, "connection") || !strcmp(k, "keep-alive") || !strcmp(k, "proxy-connection") ||
           !strcmp(k, "transfer-encoding") || !strcmp(k, "upgrade");
}

static V w_pair(const char *k, const char *v) { return fwp_tuple2(fwp_cstr(k), fwp_cstr(v)); }

static V fwp_p_http2_request(V call) {
    g_call *k = WCALL(call);
    h2_hdrs *h = &k->s->headers;
    V *a = (V *)fwp_alloc((h->n + 2) * sizeof(V));
    size_t n = 0;
    const char *auth = h2_get(h, ":authority");
    if (!h2_get(h, "host") && auth) a[n++] = w_pair("host", auth);
    for (size_t i = 0; i < h->n; i++)
        if (h->v[i].name[0] != ':') a[n++] = w_pair(h->v[i].name, h->v[i].value);
    V hs = fwp_list_from(a, n);
    char *peer = k->c->ssl ? fwp_tls_peer_subject(k->c->ssl) : 0;
    V pv = FWP_NONE;
    if (peer) {
        pv = fwp_some(fwp_cstr(peer));
        free(peer);
    }
    const char *m = h2_get(h, ":method"), *p = h2_get(h, ":path");
    V f[5] = {fwp_cstr(m ? m : ""), fwp_cstr(p ? p : ""), hs, fwp_cstr(k->c->authority), pv};
    return fwp_record(5, f);
}

static V w_err_code(int64_t code) {
    V x = (V)code;
    return fwp_data(1, 1, &x);
}

static V fwp_p_http2_body(V max, V timeout, V call) {
    g_call *k = WCALL(call);
    int64_t mx = (int64_t)max;
    int64_t until = fwp_after(timeout);
    g_stream *s = k->s;
    for (;;) {
        if ((int64_t)s->data.len > mx) return w_err_code(413);
        if (s->remote_end) {
            V b = fwp_str_new((const char *)s->data.d, s->data.len);
            /* Body bytes belong to the stream's malloc buffer, not the GC heap. */
            FWP_KEEP_ALIVE(call);
            return fwp_data(0, 1, &b);
        }
        if (s->reset || k->c->dead) return w_err_code(0);
        fwp_check_cancel();
        if (fwp_now_ns() >= until) return w_err_code(408);
        fwp_park(&s->waiters, until);
    }
}

/* the headers of a list value, lower-cased, without those an HTTP/2
 * message may not carry (and `host` for a client) */
static void w_headers(h2_buf *blk, V hs, int client) {
    for (; hs != 0; hs = OBJ(hs)->f[1]) {
        V h = OBJ(hs)->f[0];
        V name = OBJ(h)->f[0], value = OBJ(h)->f[1];
        size_t n = STR(name)->len;
        char *k = (char *)malloc(n + 1);
        for (size_t i = 0; i < n; i++) k[i] = (char)tolower((unsigned char)STR(name)->d[i]);
        k[n] = 0;
        if (!w_connection_specific(k) && k[0] != ':' && !(client && !strcmp(k, "host")))
            h2_hpack_lit(blk, k, STR(value)->d);
        free(k);
    }
}

/* stream 1 of a connection upgraded from HTTP/1.1, whose request was
 * read already */
static void w_upgraded(g_conn *c, V r, g_slist *fresh) {
    V *f = OBJ(r)->f;
    h2_hdrs hs = {0};
    h2_hdrs_add(&hs, ":method", 7, STR(f[0])->d, STR(f[0])->len);
    h2_hdrs_add(&hs, ":scheme", 7, "http", 4);
    h2_hdrs_add(&hs, ":path", 5, STR(f[1])->d, STR(f[1])->len);
    for (V l = f[2]; l != 0; l = OBJ(l)->f[1]) {
        V h = OBJ(l)->f[0];
        V name = OBJ(h)->f[0], value = OBJ(h)->f[1];
        size_t n = STR(name)->len;
        char *k = (char *)malloc(n + 1);
        for (size_t i = 0; i < n; i++) k[i] = (char)tolower((unsigned char)STR(name)->d[i]);
        k[n] = 0;
        if (!w_connection_specific(k) && strcmp(k, "http2-settings") && k[0] != ':')
            h2_hdrs_add(&hs, k, n, STR(value)->d, STR(value)->len);
        free(k);
    }
    size_t before = fresh->n;
    g_web_stream(c, 1, &hs, 1, fresh);
    if (fresh->n > before)
        h2b_put(&fresh->v[before]->data, (const unsigned char *)STR(f[3])->d, STR(f[3])->len);
}

static V fwp_p_http2_respond(V status, V hs, V body, V end, V call) {
    g_call *k = WCALL(call);
    g_conn *c = k->c;
    g_stream *s = k->s;
    if (c->dead || s->reset || s->sent_headers) return FWP_FALSE;
    s->sent_headers = 1;
    h2_buf blk = {0};
    char st[32];
    snprintf(st, sizeof st, "%lld", (long long)(int64_t)status);
    h2_hpack_lit(&blk, ":status", st);
    w_headers(&blk, hs, 0);
    size_t n = STR(body)->len;
    int only = n == 0 && end == FWP_TRUE;
    h2_header_frames(&c->out, s->id, &blk, only, c->peer.max_frame);
    h2b_free(&blk);
    if (only) s->local_end = 1;
    fwp_wake_all(&c->writer_wl);
    if (n == 0) return FWP_TRUE;
    return g_send_data(c, s, (const unsigned char *)STR(body)->d, n, end == FWP_TRUE) ? FWP_TRUE : FWP_FALSE;
}

static V fwp_p_http2_data(V d, V end, V call) {
    g_call *k = WCALL(call);
    if (STR(d)->len == 0 && end != FWP_TRUE) return !k->s->reset && !k->c->dead ? FWP_TRUE : FWP_FALSE;
    return g_send_data(k->c, k->s, (const unsigned char *)STR(d)->d, STR(d)->len, end == FWP_TRUE) ? FWP_TRUE
                                                                                                  : FWP_FALSE;
}

static g_conn *w_pooled(const char *key) {
    char k[1200];
    snprintf(k, sizeof k, "http2 %s", key);
    for (g_conn *p = g_pool; p; p = p->next_pool)
        if (strcmp(p->authority, k) == 0 && !p->tlskey && !p->dead && !p->goaway && p->next_stream < 0x7fff0000u)
            return p;
    return 0;
}

static V fwp_p_http2_pooled(V key) { return w_pooled(STR(key)->d) ? FWP_TRUE : FWP_FALSE; }

static V fwp_p_http2_send(V key, V conn, V req, const fwp_desc *err) {
    fwp_tasks_init();
    fwp_check_cancel();
    g_conn *c;
    if (conn != FWP_NONE) {
        SSL *ssl;
        int fd = w_take(OBJ(conn)->f[0], &ssl);
        if (fd < 0) return fwp_io_error("closed", "connection is closed", err);
        char k[1200];
        snprintf(k, sizeof k, "http2 %s", STR(key)->d);
        c = g_conn_new(fd, k, 0);
        c->ssl = ssl;
        c->refs = 2;
        fwp_spawn_task(0, g_reader, c, 0, 1);
        fwp_spawn_task(0, g_writer, c, 0, 1);
        c->next_pool = g_pool;
        g_pool = c;
    } else {
        c = w_pooled(STR(key)->d);
        if (!c) return fwp_io_error("http2", "no connection", err);
    }
    if (c->dead) return fwp_io_error("http2", c->dead, err);
    V *r = OBJ(req)->f;
    size_t bn = STR(r[5])->len;
    uint32_t id = c->next_stream;
    c->next_stream += 2;
    h2_buf blk = {0};
    h2_hpack_lit(&blk, ":method", STR(r[0])->d);
    h2_hpack_lit(&blk, ":scheme", STR(r[1])->d);
    h2_hpack_lit(&blk, ":authority", STR(r[2])->d);
    h2_hpack_lit(&blk, ":path", STR(r[3])->d);
    w_headers(&blk, r[4], 1);
    h2_header_frames(&c->out, id, &blk, bn == 0, c->peer.max_frame);
    h2b_free(&blk);
    g_stream *s = g_stream_new(c, id);
    s->raw = 1;
    s->local_end = bn == 0;
    fwp_wake_all(&c->writer_wl);
    fwp_task *me = fwp_cur;
    if (bn) {
        if (me->cancelled) { g_reset(c, s, 8); fwp_check_cancel(); }
        g_send_data(c, s, (const unsigned char *)STR(r[5])->d, bn, 1);
    }
    for (;;) {
        if (s->remote_end) {
            const char *st = h2_get(&s->headers, ":status");
            int64_t status = 0;
            if (st) {
                char *e = 0;
                long long v = strtoll(st, &e, 10);
                if (e != st && *e == 0) status = v;
            }
            size_t nh = s->headers.n + s->trailers.n;
            V *a = (V *)fwp_alloc((nh + 1) * sizeof(V));
            size_t n = 0;
            for (int t = 0; t < 2; t++) {
                h2_hdrs *h = t ? &s->trailers : &s->headers;
                for (size_t i = 0; i < h->n; i++)
                    if (h->v[i].name[0] != ':') a[n++] = w_pair(h->v[i].name, h->v[i].value);
            }
            V f[3] = {(V)status, fwp_list_from(a, n), fwp_str_new((const char *)s->data.d, s->data.len)};
            g_unlink(c, s);
            return fwp_record(3, f);
        }
        if (s->reset) return fwp_io_error("http2", s->reset, err);
        if (g_cancelled()) {
            g_reset(c, s, 8); /* CANCEL */
            fwp_check_cancel();
        }
        fwp_park(&s->waiters, 0);
    }
}

/* -------------------------------------------------------------- compression */

static uint32_t w_adler32(const unsigned char *d, size_t n) {
    uint32_t a = 1, b = 0;
    while (n > 0) {
        size_t k = n < 5552 ? n : 5552;
        n -= k;
        while (k--) {
            a += *d++;
            b += a;
        }
        a %= 65521;
        b %= 65521;
    }
    return b << 16 | a;
}

static V w_ok_bytes(h2_buf *b) {
    V x = fwp_str_new(b->d ? (const char *)b->d : "", b->len);
    h2b_free(b);
    return fwp_data(0, 1, &x);
}

static V w_err_text(const char *m) {
    V x = fwp_cstr(m);
    return fwp_data(1, 1, &x);
}

static V fwp_p_zlib_gzip(V d) {
    h2_buf out = {0};
    h2_gzip((const unsigned char *)STR(d)->d, STR(d)->len, &out);
    V r = fwp_str_new((const char *)out.d, out.len);
    h2b_free(&out);
    return r;
}

static V fwp_p_zlib_gunzip(V max, V d) {
    h2_buf out = {0};
    int64_t m = (int64_t)max;
    if (!h2_gunzip((const unsigned char *)STR(d)->d, STR(d)->len, &out, m < 0 ? 0 : (size_t)m)) {
        h2b_free(&out);
        return w_err_text(h2_err);
    }
    return w_ok_bytes(&out);
}

static V fwp_p_zlib_gzip_chunk(V d) {
    h2_buf out = {0};
    h2_gzip_chunk((const unsigned char *)STR(d)->d, STR(d)->len, &out);
    V r = fwp_str_new((const char *)out.d, out.len);
    h2b_free(&out);
    return r;
}

static V fwp_p_zlib_crc32(V crc, V d) {
    return (V)(int64_t)h2_crc32_update((uint32_t)(int64_t)crc, (const unsigned char *)STR(d)->d,
                                       STR(d)->len);
}

/* the end of a gzip stream of chunks: an empty last block, then the CRC
 * and length of all the data */
static V fwp_p_zlib_gzip_end(V crc, V len) {
    uint32_t c = (uint32_t)(int64_t)crc, n = (uint32_t)(int64_t)len;
    unsigned char t[10] = {0x03, 0x00, (unsigned char)c, (unsigned char)(c >> 8),
                           (unsigned char)(c >> 16), (unsigned char)(c >> 24), (unsigned char)n,
                           (unsigned char)(n >> 8), (unsigned char)(n >> 16), (unsigned char)(n >> 24)};
    return fwp_str_new((const char *)t, 10);
}

/* the zlib format of `deflate`: the DEFLATE data of h2_gzip's output */
static V fwp_p_zlib_deflate(V d) {
    h2_buf g = {0};
    size_t n = STR(d)->len;
    h2_gzip((const unsigned char *)STR(d)->d, n, &g);
    h2_buf out = {0};
    h2b_byte(&out, 0x78);
    h2b_byte(&out, 0x01);
    h2b_put(&out, g.d + 10, g.len - 18);
    h2b_be32(&out, w_adler32((const unsigned char *)STR(d)->d, n));
    h2b_free(&g);
    V r = fwp_str_new((const char *)out.d, out.len);
    h2b_free(&out);
    return r;
}

static V fwp_p_zlib_inflate(V max, V dv) {
    const unsigned char *d = (const unsigned char *)STR(dv)->d;
    size_t n = STR(dv)->len;
    int64_t m = (int64_t)max;
    size_t mx = m < 0 ? 0 : (size_t)m, used = 0;
    h2_buf out = {0};
    int wrapped = n >= 2 && (d[0] & 0x0f) == 8 && (((unsigned)d[0] << 8 | d[1]) % 31) == 0;
    if (!wrapped) {
        if (!h2_inflate(d, n, &out, mx, &used)) { h2b_free(&out); return w_err_text(h2_err); }
        return w_ok_bytes(&out);
    }
    if (d[1] & 0x20) return w_err_text("a preset dictionary is not supported");
    if (!h2_inflate(d + 2, n - 2, &out, mx, &used)) { h2b_free(&out); return w_err_text(h2_err); }
    size_t t = 2 + used;
    if (t + 4 > n) { h2b_free(&out); return w_err_text("truncated zlib data"); }
    if (h2_rd32(d + t) != w_adler32(out.d, out.len)) { h2b_free(&out); return w_err_text("zlib checksum mismatch"); }
    return w_ok_bytes(&out);
}

/* ---------------------------------------------------------------- WebSocket */

/* SHA-1 (FIPS 180-4), for Sec-WebSocket-Accept */
static void w_sha1(const unsigned char *data, size_t len, unsigned char out[20]) {
    uint32_t h[5] = {0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0};
    size_t total = ((len + 8) / 64 + 1) * 64;
    unsigned char *m = (unsigned char *)calloc(1, total);
    memcpy(m, data, len);
    m[len] = 0x80;
    uint64_t bits = (uint64_t)len * 8;
    for (int i = 0; i < 8; i++) m[total - 1 - i] = (unsigned char)(bits >> (8 * i));
#define W_ROL(x, n) (((x) << (n)) | ((x) >> (32 - (n))))
    for (size_t off = 0; off < total; off += 64) {
        uint32_t w[80];
        for (int i = 0; i < 16; i++) w[i] = h2_rd32(m + off + 4 * i);
        for (int i = 16; i < 80; i++) w[i] = W_ROL(w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16], 1);
        uint32_t a = h[0], b = h[1], c = h[2], d = h[3], e = h[4];
        for (int i = 0; i < 80; i++) {
            uint32_t f, k;
            if (i < 20) { f = (b & c) | (~b & d); k = 0x5A827999; }
            else if (i < 40) { f = b ^ c ^ d; k = 0x6ED9EBA1; }
            else if (i < 60) { f = (b & c) | (b & d) | (c & d); k = 0x8F1BBCDC; }
            else { f = b ^ c ^ d; k = 0xCA62C1D6; }
            uint32_t t = W_ROL(a, 5) + f + e + k + w[i];
            e = d;
            d = c;
            c = W_ROL(b, 30);
            b = a;
            a = t;
        }
        h[0] += a; h[1] += b; h[2] += c; h[3] += d; h[4] += e;
    }
#undef W_ROL
    free(m);
    for (int i = 0; i < 5; i++)
        for (int j = 0; j < 4; j++) out[4 * i + j] = (unsigned char)(h[i] >> (24 - 8 * j));
}

static void w_base64(const unsigned char *d, size_t n, h2_buf *out) {
    static const char A[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    for (size_t i = 0; i < n; i += 3) {
        size_t r = n - i < 3 ? n - i : 3;
        uint32_t v = (uint32_t)d[i] << 16 | (r > 1 ? (uint32_t)d[i + 1] << 8 : 0) | (r > 2 ? d[i + 2] : 0);
        for (size_t k = 0; k < 4; k++) h2b_byte(out, k <= r ? (unsigned char)A[(v >> (18 - 6 * k)) & 63] : '=');
    }
}

static V fwp_p_ws_accept(V key) {
    const char *k = STR(key)->d;
    size_t n = STR(key)->len;
    while (n && (*k == ' ' || *k == '\t')) { k++; n--; }
    while (n && (k[n - 1] == ' ' || k[n - 1] == '\t')) n--;
    static const char guid[] = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";
    h2_buf in = {0};
    h2b_put(&in, k, n);
    h2b_put(&in, guid, sizeof guid - 1);
    unsigned char dg[20];
    w_sha1(in.d, in.len, dg);
    h2b_free(&in);
    h2_buf out = {0};
    w_base64(dg, 20, &out);
    V r = fwp_str_new((const char *)out.d, out.len);
    h2b_free(&out);
    return r;
}

static uint64_t w_mask_state = 0;

static uint32_t w_mask_key(void) {
    uint64_t x = w_mask_state;
    if (!x) {
        struct timespec t;
        clock_gettime(CLOCK_REALTIME, &t);
        x = ((uint64_t)t.tv_sec * 1000000000ull + (uint64_t)t.tv_nsec) ^ ((uint64_t)getpid() << 32) | 1;
    }
    x ^= x << 13;
    x ^= x >> 7;
    x ^= x << 17;
    w_mask_state = x;
    return (uint32_t)x;
}

/* a fresh Sec-WebSocket-Key: 16 random bytes in base64 */
static V fwp_p_ws_key(void) {
    unsigned char k[16];
    for (int i = 0; i < 4; i++) {
        uint32_t x = w_mask_key();
        for (int j = 0; j < 4; j++) k[4 * i + j] = (unsigned char)(x >> (24 - 8 * j));
    }
    h2_buf out = {0};
    w_base64(k, 16, &out);
    V r = fwp_str_new((const char *)out.d, out.len);
    h2b_free(&out);
    return r;
}

/* a complete (FIN) frame, masked with a fresh key for clients */
static V fwp_p_ws_frame(V mask, V opcode, V payload) {
    size_t n = STR(payload)->len;
    const unsigned char *p = (const unsigned char *)STR(payload)->d;
    int mk = mask == FWP_TRUE;
    size_t hl = 2 + (n < 126 ? 0 : n < 65536 ? 2 : 8) + (mk ? 4 : 0);
    fwp_str *r = (fwp_str *)fwp_alloc_leaf(sizeof(fwp_str) + hl + n + 1);
    unsigned char *o = (unsigned char *)r->d;
    r->len = hl + n;
    o[hl + n] = 0;
    o[0] = (unsigned char)(0x80 | ((int64_t)opcode & 0x4f)); /* + 64: RSV1, compressed */
    unsigned char mb = mk ? 0x80 : 0;
    size_t at = 2;
    if (n < 126) {
        o[1] = (unsigned char)(mb | n);
    } else if (n < 65536) {
        o[1] = mb | 126;
        o[2] = (unsigned char)(n >> 8);
        o[3] = (unsigned char)n;
        at = 4;
    } else {
        o[1] = mb | 127;
        for (int i = 0; i < 8; i++) o[2 + i] = (unsigned char)((uint64_t)n >> (56 - 8 * i));
        at = 10;
    }
    if (mk) {
        uint32_t k = w_mask_key();
        unsigned char key[4] = {(unsigned char)(k >> 24), (unsigned char)(k >> 16), (unsigned char)(k >> 8),
                                (unsigned char)k};
        memcpy(o + at, key, 4);
        at += 4;
        for (size_t i = 0; i < n; i++) o[at + i] = p[i] ^ key[i & 3];
    } else if (n) {
        memcpy(o + at, p, n);
    }
    return PTR(r);
}

static V w_parsed(int64_t k, int fin, int64_t op, int masked, V payload) {
    V f[5] = {(V)k, fin ? FWP_TRUE : FWP_FALSE, (V)op, masked ? FWP_TRUE : FWP_FALSE, payload};
    return fwp_record(5, f);
}

/* the first frame of a buffer: (bytes it took, FIN, opcode, masked,
 * payload unmasked); 0 bytes when more are needed, -1002 for a malformed
 * frame and -1009 for one larger than max */
static V fwp_p_ws_parse(V maxv, V atv, V bufv) {
    size_t off = (int64_t)atv < 0 ? 0 : (size_t)(int64_t)atv;
    if (off > STR(bufv)->len) off = STR(bufv)->len;
    const unsigned char *b = (const unsigned char *)STR(bufv)->d + off;
    size_t n = STR(bufv)->len - off;
    int64_t mx = (int64_t)maxv;
    if (mx < 0) mx = 0;
    V empty = fwp_str_new("", 0);
    if (n < 2) return w_parsed(0, 0, 0, 0, empty);
    unsigned b0 = b[0], b1 = b[1], op = b0 & 0x0f;
    if ((b0 & 0x30) || !(op == 0 || op == 1 || op == 2 || op == 8 || op == 9 || op == 10))
        return w_parsed(-1002, 0, 0, 0, empty);
    if (op >= 8 && (!(b0 & 0x80) || (b1 & 0x7f) > 125)) return w_parsed(-1002, 0, 0, 0, empty);
    int masked = (b1 & 0x80) != 0;
    size_t at = 2;
    uint64_t len = b1 & 0x7f;
    if (len == 126) {
        if (n < 4) return w_parsed(0, 0, 0, 0, empty);
        len = (uint64_t)b[2] << 8 | b[3];
        at = 4;
    } else if (len == 127) {
        if (n < 10) return w_parsed(0, 0, 0, 0, empty);
        len = 0;
        for (int i = 0; i < 8; i++) len = len << 8 | b[2 + i];
        if (len >> 63) return w_parsed(-1002, 0, 0, 0, empty);
        at = 10;
    }
    if (len > (uint64_t)mx) return w_parsed(-1009, 0, 0, 0, empty);
    unsigned char key[4] = {0, 0, 0, 0};
    if (masked) {
        if (n < at + 4) return w_parsed(0, 0, 0, 0, empty);
        memcpy(key, b + at, 4);
        at += 4;
    }
    if (n < at + len) return w_parsed(0, 0, 0, 0, empty);
    fwp_str *r = (fwp_str *)fwp_alloc_leaf(sizeof(fwp_str) + len + 1);
    r->len = len;
    r->d[len] = 0;
    b = (const unsigned char *)STR(bufv)->d + off; /* the collector does not move objects */
    if (masked)
        for (size_t i = 0; i < len; i++) r->d[i] = (char)(b[at + i] ^ key[i & 3]);
    else if (len)
        memcpy(r->d, b + at, len);
    return w_parsed((int64_t)(at + len), (b0 & 0x80) != 0, op | (b0 & 0x40), masked, PTR(r));
}

/* permessage-deflate (RFC 7692) without context takeover, as
 * src/h2web.rs: a message is a block flushed to a byte, without the
 * flush's final 00 00 ff ff */
static V fwp_p_ws_deflate(V d) {
    h2_buf out = {0};
    h2_gzip_chunk((const unsigned char *)STR(d)->d, STR(d)->len, &out);
    V r = fwp_str_new((const char *)out.d, out.len - 4);
    h2b_free(&out);
    return r;
}

/* (0, data), or (the close code of the failure, "") */
static V fwp_p_ws_inflate(V maxv, V dv) {
    size_t n = STR(dv)->len;
    unsigned char *d = (unsigned char *)malloc(n + 6);
    memcpy(d, STR(dv)->d, n);
    static const unsigned char tail[6] = {0, 0, 0xff, 0xff, 0x03, 0x00};
    memcpy(d + n, tail, 6);
    int64_t m = (int64_t)maxv;
    size_t used = 0;
    h2_buf out = {0};
    int ok = h2_inflate(d, n + 6, &out, m < 0 ? 0 : (size_t)m, &used);
    free(d);
    if (!ok) {
        h2b_free(&out);
        return fwp_tuple2((V)(int64_t)(strstr(h2_err, "too large") ? 1009 : 1007), fwp_str_new("", 0));
    }
    V r = fwp_str_new(out.d ? (const char *)out.d : "", out.len);
    h2b_free(&out);
    return fwp_tuple2((V)(int64_t)0, r);
}

static V fwp_p_ws_close_payload(V codev, V reason) {
    int64_t code = (int64_t)codev;
    if (code < 1000 || code > 4999 || code == 1005 || code == 1006 || code == 1015) return fwp_str_new("", 0);
    const unsigned char *r = (const unsigned char *)STR(reason)->d;
    size_t n = STR(reason)->len;
    if (n > 123) {
        n = 123;
        while (n > 0 && (r[n] & 0xc0) == 0x80) n--;
    }
    h2_buf out = {0};
    h2b_byte(&out, (unsigned)(code >> 8) & 0xff);
    h2b_byte(&out, (unsigned)code & 0xff);
    h2b_put(&out, r, n);
    V v = fwp_str_new((const char *)out.d, out.len);
    h2b_free(&out);
    return v;
}

static V fwp_p_ws_close_parse(V p) {
    const unsigned char *d = (const unsigned char *)STR(p)->d;
    size_t n = STR(p)->len;
    if (n == 0) return fwp_tuple2((V)(int64_t)1005, fwp_str_new("", 0));
    if (n < 2) return fwp_tuple2((V)(int64_t)-1, fwp_str_new("", 0));
    int64_t code = (int64_t)d[0] << 8 | d[1];
    int valid = (code >= 1000 && code <= 1003) || (code >= 1007 && code <= 1014) || (code >= 3000 && code <= 4999);
    if (!valid || !fwp_valid_utf8(d + 2, n - 2)) return fwp_tuple2((V)(int64_t)-1, fwp_str_new("", 0));
    return fwp_tuple2((V)code, fwp_str_new((const char *)d + 2, n - 2));
}

#endif /* __wasi__ */
