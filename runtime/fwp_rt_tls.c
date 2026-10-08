/* TLS with the system's OpenSSL 3 (docs/tls.md); mirrors src/tls.rs, with
 * the same results and messages. Embedded only in programs that use TLS
 * (the `tls.*` primitives, or services), which are linked with -lssl
 * -lcrypto.
 *
 * Sessions are non-blocking: an operation that cannot go on says which
 * direction the socket must become ready in, and the task waits for that
 * with fwp_wait_fd, so only the task waits. A server session does its
 * handshake on its first read or write. Session state lives in OpenSSL's
 * (malloc'ed) memory and holds no fwp values. */

#include <openssl/ssl.h>
#include <openssl/err.h>
#include <openssl/x509.h>

/* fwp_tls_err (declared in fwp_rt_task.c) holds the message of the last
 * failure, for operations that return -2 */

static const char *fwp_tls_reason(void) {
    unsigned long e, last = 0;
    while ((e = ERR_get_error()) != 0) last = e;
    const char *r = last ? ERR_reason_error_string(last) : 0;
    return r && *r ? r : "unknown error";
}

/* a readable file, or why it is not in fwp_tls_err */
static int fwp_tls_readable(const char *path) {
    FILE *f = fopen(path, "r");
    if (!f) {
        snprintf(fwp_tls_err, sizeof fwp_tls_err, "%s: %s", path, strerror(errno));
        return 0;
    }
    fclose(f);
    return 1;
}

static SSL_CTX *fwp_tls_ctx_new(int server) {
    SSL_CTX *ctx = SSL_CTX_new(server ? TLS_server_method() : TLS_client_method());
    if (!ctx) {
        snprintf(fwp_tls_err, sizeof fwp_tls_err, "cannot create a TLS context: %s", fwp_tls_reason());
        return 0;
    }
    /* a peer that closes without close_notify ends the stream */
    SSL_CTX_set_options(ctx, SSL_OP_IGNORE_UNEXPECTED_EOF);
    SSL_CTX_set_mode(ctx, SSL_MODE_ENABLE_PARTIAL_WRITE | SSL_MODE_ACCEPT_MOVING_WRITE_BUFFER);
    SSL_CTX_set_min_proto_version(ctx, TLS1_2_VERSION);
    return ctx;
}

/* protocols in ALPN's wire format; names that are empty or longer than
 * 255 bytes are left out */
static unsigned char *fwp_alpn_wire(V protos, unsigned *len) {
    size_t n;
    V *items = fwp_list_items(protos, &n);
    size_t total = 0;
    for (size_t i = 0; i < n; i++) total += 1 + STR(items[i])->len;
    unsigned char *w = (unsigned char *)malloc(total + 1);
    size_t k = 0;
    for (size_t i = 0; i < n; i++) {
        size_t l = STR(items[i])->len;
        if (l == 0 || l > 255) continue;
        w[k++] = (unsigned char)l;
        memcpy(w + k, STR(items[i])->d, l);
        k += l;
    }
    *len = (unsigned)k;
    return w;
}

typedef struct { unsigned char *w; unsigned n; } fwp_alpn;

/* SSL sessions keep this server owner alive after its listener stops. The
 * existing context app-data slot carries no process-global free callback, so
 * raw session transfer into HTTP/2/gRPC preserves the same ownership. */
typedef struct { fwp_alpn alpn; size_t refs; } fwp_tls_server_owner;

static void fwp_tls_server_drop(void *p) {
    SSL_CTX *ctx = (SSL_CTX *)p;
    fwp_tls_server_owner *owner = (fwp_tls_server_owner *)SSL_CTX_get_app_data(ctx);
    if (!owner || !owner->refs) abort();
    if (--owner->refs) return;
    SSL_CTX_free(ctx);
    free(owner->alpn.w);
    free(owner);
}

/* the server's choice among the client's protocols: the first of its own
 * that the client offers; none (the handshake goes on) otherwise */
static int fwp_alpn_select(SSL *ssl, const unsigned char **out, unsigned char *outlen, const unsigned char *in,
                           unsigned inlen, void *arg) {
    (void)ssl;
    const fwp_alpn *a = (const fwp_alpn *)arg;
    for (unsigned i = 0; i < a->n; i += 1 + a->w[i]) {
        unsigned n = a->w[i];
        for (unsigned j = 0; j < inlen; j += 1 + in[j]) {
            unsigned m = in[j];
            if (j + 1 + m > inlen) break;
            if (m == n && memcmp(in + j + 1, a->w + i + 1, n) == 0) {
                *out = in + j + 1;
                *outlen = (unsigned char)m;
                return SSL_TLSEXT_ERR_OK;
            }
        }
    }
    return SSL_TLSEXT_ERR_NOACK;
}

/* A server context owns ALPN storage only on success; on failure the caller
 * still owns the wire buffer. Listener and accepted-session owners release it.
 * With a CA file
 * (`client_ca`, "" for none), clients must present a certificate that the
 * CA signed (mutual TLS). */
static SSL_CTX *fwp_tls_server_ctx(const char *cert, const char *key, unsigned char *alpn, unsigned alpn_n,
                                   const char *client_ca) {
    if (!fwp_tls_readable(cert) || !fwp_tls_readable(key)) return 0;
    if (*client_ca && !fwp_tls_readable(client_ca)) return 0;
    ERR_clear_error();
    SSL_CTX *ctx = fwp_tls_ctx_new(1);
    if (!ctx) return 0;
    if (SSL_CTX_use_certificate_chain_file(ctx, cert) != 1) {
        snprintf(fwp_tls_err, sizeof fwp_tls_err, "%s: cannot load the certificate: %s", cert, fwp_tls_reason());
        SSL_CTX_free(ctx);
        return 0;
    }
    if (SSL_CTX_use_PrivateKey_file(ctx, key, SSL_FILETYPE_PEM) != 1) {
        snprintf(fwp_tls_err, sizeof fwp_tls_err, "%s: cannot load the private key: %s", key, fwp_tls_reason());
        SSL_CTX_free(ctx);
        return 0;
    }
    if (SSL_CTX_check_private_key(ctx) != 1) {
        ERR_clear_error();
        snprintf(fwp_tls_err, sizeof fwp_tls_err, "%s: the private key does not match the certificate", key);
        SSL_CTX_free(ctx);
        return 0;
    }
    if (*client_ca) {
        if (SSL_CTX_load_verify_locations(ctx, client_ca, 0) != 1) {
            snprintf(fwp_tls_err, sizeof fwp_tls_err, "%s: cannot load CA certificates: %s", client_ca,
                     fwp_tls_reason());
            SSL_CTX_free(ctx);
            return 0;
        }
        /* the CAs the client is asked for */
        STACK_OF(X509_NAME) *names = SSL_load_client_CA_file(client_ca);
        if (names) SSL_CTX_set_client_CA_list(ctx, names);
        ERR_clear_error();
        SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT, 0);
    }
    fwp_tls_server_owner *owner = (fwp_tls_server_owner *)malloc(sizeof *owner);
    if (!owner) {
        snprintf(fwp_tls_err, sizeof fwp_tls_err, "cannot allocate TLS protocol state");
        SSL_CTX_free(ctx);
        return 0;
    }
    owner->alpn.w = alpn;
    owner->alpn.n = alpn_n;
    owner->refs = 1;
    if (!SSL_CTX_set_app_data(ctx, owner)) {
        snprintf(fwp_tls_err, sizeof fwp_tls_err, "cannot store TLS protocol state");
        free(owner);
        SSL_CTX_free(ctx);
        return 0;
    }
    if (alpn_n) SSL_CTX_set_alpn_select_cb(ctx, fwp_alpn_select, &owner->alpn);
    return ctx;
}

/* the subject of the peer's certificate (RFC 2253: `CN=alice,O=Example`),
 * malloc'ed, or 0 if it presented none */
static char *fwp_tls_peer_subject(SSL *ssl) {
    if (!ssl || !SSL_is_init_finished(ssl)) return 0;
    X509 *cert = SSL_get1_peer_certificate(ssl);
    if (!cert) return 0;
    char *out = 0;
    BIO *bio = BIO_new(BIO_s_mem());
    X509_NAME *name = X509_get_subject_name(cert);
    if (bio && name) {
        X509_NAME_print_ex(bio, name, 0, XN_FLAG_RFC2253);
        char *p = 0;
        long n = BIO_get_mem_data(bio, &p);
        if (n >= 0 && p) {
            out = (char *)malloc((size_t)n + 1);
            memcpy(out, p, (size_t)n);
            out[n] = 0;
        }
    }
    if (bio) BIO_free(bio);
    X509_free(cert);
    ERR_clear_error();
    return out;
}

/* client contexts by CA file ("" for the system's) and verification, made
 * once: loading the system's certificates takes a while */
typedef struct { char *ca; int verify; SSL_CTX *ctx; } fwp_tls_client;
static fwp_tls_client *fwp_tls_clients = 0;
static size_t fwp_tls_nclients = 0;

#ifdef FWP_LIBRARY
/* Sessions are finalized first; then give up the cache's context owners. */
static void fwp_tls_clients_finish(void) {
    for (size_t i = 0; i < fwp_tls_nclients; i++) {
        SSL_CTX_free(fwp_tls_clients[i].ctx);
        free(fwp_tls_clients[i].ca);
    }
    free(fwp_tls_clients);
    fwp_tls_clients = 0;
    fwp_tls_nclients = 0;
}
#endif

static SSL_CTX *fwp_tls_client_ctx(const char *ca, int verify) {
    for (size_t i = 0; i < fwp_tls_nclients; i++)
        if (fwp_tls_clients[i].verify == verify && strcmp(fwp_tls_clients[i].ca, ca) == 0)
            return fwp_tls_clients[i].ctx;
    if (*ca && !fwp_tls_readable(ca)) return 0;
    SSL_CTX *ctx = fwp_tls_ctx_new(0);
    if (!ctx) return 0;
    if (verify) {
        SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, 0);
        int ok = *ca ? SSL_CTX_load_verify_locations(ctx, ca, 0) : SSL_CTX_set_default_verify_paths(ctx);
        if (ok != 1) {
            if (*ca)
                snprintf(fwp_tls_err, sizeof fwp_tls_err, "%s: cannot load CA certificates: %s", ca, fwp_tls_reason());
            else
                snprintf(fwp_tls_err, sizeof fwp_tls_err, "cannot load the system's CA certificates: %s",
                         fwp_tls_reason());
            SSL_CTX_free(ctx);
            return 0;
        }
    } else {
        SSL_CTX_set_verify(ctx, SSL_VERIFY_NONE, 0);
    }
    fwp_tls_clients = (fwp_tls_client *)realloc(fwp_tls_clients, (fwp_tls_nclients + 1) * sizeof *fwp_tls_clients);
    fwp_tls_clients[fwp_tls_nclients].ca = strdup(ca);
    fwp_tls_clients[fwp_tls_nclients].verify = verify;
    fwp_tls_clients[fwp_tls_nclients++].ctx = ctx;
    return ctx;
}

static int fwp_is_ip(const char *s) {
    unsigned char b[16];
    return inet_pton(AF_INET, s, b) == 1 || inet_pton(AF_INET6, s, b) == 1;
}

/* a client session on a connected socket (the handshake is still to be
 * done): the CA file ("" for the system's), verification, the server name
 * (SNI and verification; "" for none), the protocols to offer, and a
 * client certificate chain and key ("" for none; the key may be in the
 * certificate's file) */
static SSL *fwp_tls_client_new(int fd, const char *ca, int verify, const char *name, const unsigned char *alpn,
                               unsigned alpn_n, const char *cert, const char *key) {
    ERR_clear_error();
    SSL_CTX *ctx = fwp_tls_client_ctx(ca, verify);
    if (!ctx) return 0;
    if (*cert) {
        if (!*key) key = cert;
        if (!fwp_tls_readable(cert) || !fwp_tls_readable(key)) return 0;
    }
    SSL *ssl = SSL_new(ctx);
    if (!ssl) {
        snprintf(fwp_tls_err, sizeof fwp_tls_err, "cannot create a TLS session: %s", fwp_tls_reason());
        return 0;
    }
    SSL_set_fd(ssl, fd);
    SSL_set_connect_state(ssl);
    /* SNI only for host names (RFC 6066) */
    if (*name && !fwp_is_ip(name)) SSL_set_tlsext_host_name(ssl, name);
    if (verify && *name && SSL_set1_host(ssl, name) != 1) {
        snprintf(fwp_tls_err, sizeof fwp_tls_err, "invalid server name `%s`", name);
        SSL_free(ssl);
        return 0;
    }
    if (!verify) SSL_set_verify(ssl, SSL_VERIFY_NONE, 0);
    if (alpn_n) SSL_set_alpn_protos(ssl, alpn, alpn_n);
    if (*cert) {
        const char *why = 0;
        if (SSL_use_certificate_chain_file(ssl, cert) != 1)
            snprintf(fwp_tls_err, sizeof fwp_tls_err, "%s: cannot load the certificate: %s", cert,
                     why = fwp_tls_reason());
        else if (SSL_use_PrivateKey_file(ssl, key, SSL_FILETYPE_PEM) != 1)
            snprintf(fwp_tls_err, sizeof fwp_tls_err, "%s: cannot load the private key: %s", key,
                     why = fwp_tls_reason());
        else if (SSL_check_private_key(ssl) != 1) {
            ERR_clear_error();
            snprintf(fwp_tls_err, sizeof fwp_tls_err, "%s: the private key does not match the certificate",
                     why = key);
        }
        if (why) {
            SSL_free(ssl);
            return 0;
        }
    }
    return ssl;
}

/* what a failed call means: -1 with errno EAGAIN (*ww: wait to write),
 * -1 with another errno, 0 for the end of the stream, or -2 with the
 * message in fwp_tls_err */
static ssize_t fwp_tls_outcome(SSL *ssl, int r, int during, int e, int *ww) {
    switch (SSL_get_error(ssl, r)) {
    case SSL_ERROR_WANT_READ:
        *ww = 0;
        errno = EAGAIN;
        return -1;
    case SSL_ERROR_WANT_WRITE:
        *ww = 1;
        errno = EAGAIN;
        return -1;
    case SSL_ERROR_ZERO_RETURN:
    case SSL_ERROR_SYSCALL:
        ERR_clear_error();
        if (!during) {
            if (e == 0) return 0;
            errno = e;
            return -1;
        }
        if (e)
            snprintf(fwp_tls_err, sizeof fwp_tls_err, "TLS handshake failed: %s", strerror(e));
        else
            snprintf(fwp_tls_err, sizeof fwp_tls_err, "TLS handshake failed: connection closed");
        return -2;
    default: {
        long v = SSL_get_verify_result(ssl);
        if (during && v != X509_V_OK) {
            ERR_clear_error();
            snprintf(fwp_tls_err, sizeof fwp_tls_err, "certificate verify failed: %s",
                     X509_verify_cert_error_string(v));
            return -2;
        }
        const char *why = SSL_get_error(ssl, r) == SSL_ERROR_SSL ? fwp_tls_reason() : "unknown error";
        snprintf(fwp_tls_err, sizeof fwp_tls_err, during ? "TLS handshake failed: %s" : "TLS error: %s", why);
        return -2;
    }
    }
}

/* go on with the handshake: 0 once it is complete */
static ssize_t fwp_tls_step(SSL *ssl, int *ww) {
    ERR_clear_error();
    errno = 0;
    int r = SSL_do_handshake(ssl);
    int e = errno;
    return r == 1 ? 0 : fwp_tls_outcome(ssl, r, 1, e, ww);
}

static ssize_t fwp_tls_recv(void *p, char *buf, size_t n, int *ww) {
    SSL *ssl = (SSL *)p;
    int during = !SSL_is_init_finished(ssl);
    ERR_clear_error();
    errno = 0;
    int r = SSL_read(ssl, buf, n > INT_MAX ? INT_MAX : (int)n);
    int e = errno;
    return r > 0 ? r : fwp_tls_outcome(ssl, r, during, e, ww);
}

/* writes some of buf; a write retried after a wait offers at least the
 * bytes the first try did, as OpenSSL requires (the pending count is the
 * session's app data) */
static ssize_t fwp_tls_send(void *p, const char *buf, size_t n, int *ww) {
    SSL *ssl = (SSL *)p;
    if (n == 0) return 0;
    int during = !SSL_is_init_finished(ssl);
    size_t pending = (size_t)(uintptr_t)SSL_get_app_data(ssl);
    size_t cap = pending > ((size_t)1 << 20) ? pending : ((size_t)1 << 20);
    if (n > cap) n = cap;
    if (n > INT_MAX) n = INT_MAX;
    ERR_clear_error();
    errno = 0;
    int r = SSL_write(ssl, buf, (int)n);
    int e = errno;
    if (r > 0) {
        SSL_set_app_data(ssl, 0);
        return r;
    }
    ssize_t k = fwp_tls_outcome(ssl, r, during, e, ww);
    if (k == -1 && errno == EAGAIN) SSL_set_app_data(ssl, (void *)(uintptr_t)n);
    if (k == 0) {
        snprintf(fwp_tls_err, sizeof fwp_tls_err, during ? "TLS handshake failed: connection closed" : "connection closed by peer");
        return -2;
    }
    return k;
}

/* Dispose without network traffic, including during library unload. */
static void fwp_tls_dispose(void *p) {
    SSL *ssl = (SSL *)p;
    SSL_CTX *ctx = SSL_get_SSL_CTX(ssl);
    int server = SSL_CTX_get_app_data(ctx) != 0;
    SSL_free(ssl);
    if (server) fwp_tls_server_drop(ctx);
}

/* Explicit close sends close_notify without waiting for the peer. */
static void fwp_tls_free(void *p) {
    SSL *ssl = (SSL *)p;
    if (SSL_is_init_finished(ssl)) SSL_shutdown(ssl);
    ERR_clear_error();
    fwp_tls_dispose(p);
}

static void *fwp_tls_accepted(void *ctx, int fd) {
    fwp_tls_server_owner *owner = (fwp_tls_server_owner *)SSL_CTX_get_app_data((SSL_CTX *)ctx);
    if (!owner || !owner->refs) abort();
    if (owner->refs == SIZE_MAX) fwp_trap("too many TLS context references");
    SSL *ssl = SSL_new((SSL_CTX *)ctx);
    if (!ssl) return 0;
    owner->refs++;
    SSL_set_fd(ssl, fd);
    SSL_set_accept_state(ssl);
    return ssl;
}

/* finish the handshake, waiting in the task: 1, or 0 with the reason in
 * fwp_tls_err (or `at` passed: "timeout") */
static int fwp_tls_finish(SSL *ssl, int fd, int64_t at) {
    for (;;) {
        int ww = 0;
        ssize_t k = fwp_tls_step(ssl, &ww);
        if (k == 0) return 1;
        if (k == -1 && errno == EAGAIN) {
            if (!fwp_wait_fd(fd, ww, at)) {
                snprintf(fwp_tls_err, sizeof fwp_tls_err, "TLS handshake timed out");
                return 0;
            }
            continue;
        }
        if (k == -1) {
            snprintf(fwp_tls_err, sizeof fwp_tls_err, "TLS handshake failed: %s", strerror(errno));
        }
        return 0;
    }
}

/* the host of "host:port", without the brackets of an IPv6 address */
static void fwp_host_of(const char *addr, char *out, size_t n) {
    const char *colon = strrchr(addr, ':');
    size_t l = colon ? (size_t)(colon - addr) : strlen(addr);
    if (l >= 2 && addr[0] == '[' && addr[l - 1] == ']') { addr++; l -= 2; }
    if (l >= n) l = n - 1;
    memcpy(out, addr, l);
    out[l] = 0;
}

/* ------------------------------------------------------------ primitives */

/* CA file, insecure, server name ("" for the host), protocols, client
 * certificate and key ("" for none), address */
static V fwp_p_tls_connect(V ca, V insecure, V name, V protos, V cert, V key, V addr, const fwp_desc *err) {
    V c = fwp_p_tcp_connect(addr, err);
    char host[256];
    if (STR(name)->len) snprintf(host, sizeof host, "%s", STR(name)->d);
    else fwp_host_of(STR(addr)->d, host, sizeof host);
    unsigned alpn_n;
    unsigned char *alpn = fwp_alpn_wire(protos, &alpn_n);
    SSL *ssl = fwp_tls_client_new(SOCK(c)->fd, STR(ca)->d, insecure == FWP_FALSE, host, alpn, alpn_n, STR(cert)->d,
                                  STR(key)->d);
    free(alpn);
    if (ssl) {
        SOCK(c)->tls = ssl;
        if (fwp_tls_finish(ssl, SOCK(c)->fd, 0)) return c;
    }
    char msg[1024];
    snprintf(msg, sizeof msg, "%s: %s", STR(addr)->d, fwp_tls_err);
    fwp_p_sock_close(c);
    return fwp_io_error("tls", msg, err);
}

/* certificate, key, protocols, client CA ("" for none), address */
static V fwp_p_tls_listen(V cert, V key, V protos, V client_ca, V addr, const fwp_desc *err) {
    unsigned alpn_n;
    unsigned char *alpn = fwp_alpn_wire(protos, &alpn_n);
    SSL_CTX *ctx = fwp_tls_server_ctx(STR(cert)->d, STR(key)->d, alpn, alpn_n, STR(client_ca)->d);
    if (!ctx) {
        free(alpn);
        return fwp_io_error("tls", fwp_tls_err, err);
    }
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_tls_server_drop, ctx);
    V l = fwp_p_tcp_listen(addr, err);
    SOCK(l)->tls = ctx;
    fwp_cleanup_pop(&cleanup);
    return l;
}

static V fwp_p_tls_handshake(V c, const fwp_desc *err) {
    if (SOCK(c)->fd < 0) return fwp_closed_error("connection", err);
    if (!SOCK(c)->tls || SOCK(c)->kind != 1 || SSL_is_init_finished((SSL *)SOCK(c)->tls)) return FWP_UNIT;
    if (!fwp_tls_finish((SSL *)SOCK(c)->tls, SOCK(c)->fd, 0)) return fwp_io_error("tls", fwp_tls_err, err);
    return FWP_UNIT;
}

static V fwp_p_tls_alpn(V c) {
    const unsigned char *p = 0;
    unsigned n = 0;
    if (SOCK(c)->tls && SOCK(c)->kind == 1) SSL_get0_alpn_selected((SSL *)SOCK(c)->tls, &p, &n);
    return fwp_str_new(p ? (const char *)p : "", p ? n : 0);
}

static V fwp_p_tls_secure(V c) { return SOCK(c)->tls && SOCK(c)->kind == 1 ? FWP_TRUE : FWP_FALSE; }

static V fwp_p_tls_peer_subject(V c) {
    if (!SOCK(c)->tls || SOCK(c)->kind != 1) return FWP_NONE;
    char *s = fwp_tls_peer_subject((SSL *)SOCK(c)->tls);
    if (!s) return FWP_NONE;
    V v = fwp_cstr(s);
    free(s);
    return fwp_some(v);
}
