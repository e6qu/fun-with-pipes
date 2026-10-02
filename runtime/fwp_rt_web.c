/* URLs, HTTP/1.1 message heads, and small string/byte helpers; mirrors
 * src/web.rs. */

static long fwp_memfind(const char *h, size_t hn, const char *nd, size_t nn) {
    if (nn == 0) return 0;
    if (nn > hn) return -1;
    for (size_t i = 0; i + nn <= hn; i++)
        if (h[i] == nd[0] && !memcmp(h + i, nd, nn)) return (long)i;
    return -1;
}

static V fwp_p_split_once(V sep, V s) {
    long i = fwp_memfind(STR(s)->d, STR(s)->len, STR(sep)->d, STR(sep)->len);
    if (i < 0 || STR(sep)->len == 0) return FWP_NONE;
    size_t k = (size_t)i + STR(sep)->len;
    return fwp_some(fwp_tuple2(fwp_str_new(STR(s)->d, (size_t)i), fwp_str_new(STR(s)->d + k, STR(s)->len - k)));
}

static V fwp_p_bytes_find(V nd, V h) {
    long i = fwp_memfind(STR(h)->d, STR(h)->len, STR(nd)->d, STR(nd)->len);
    return i < 0 ? FWP_NONE : fwp_some((V)(int64_t)i);
}

static int fwp_unreserved(unsigned char c) {
    return isalnum(c) || c == '-' || c == '.' || c == '_' || c == '~';
}

static V fwp_p_url_encode(V s) {
    fwp_buf b = {0};
    for (uint64_t i = 0; i < STR(s)->len; i++) {
        unsigned char c = (unsigned char)STR(s)->d[i];
        if (fwp_unreserved(c)) buf_putc(&b, (char)c);
        else {
            char t[4];
            snprintf(t, sizeof t, "%%%02X", c);
            buf_puts(&b, t);
        }
    }
    return buf_to_str(&b);
}

static int fwp_hexval(int c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    return -1;
}

static V fwp_p_url_decode(V s, int plus) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len;
    char *out = (char *)malloc(n + 1);
    size_t k = 0;
    for (size_t i = 0; i < n;) {
        if (d[i] == '%') {
            int h = i + 1 < n ? fwp_hexval((unsigned char)d[i + 1]) : -1;
            int l = i + 2 < n ? fwp_hexval((unsigned char)d[i + 2]) : -1;
            if (h < 0 || l < 0) { free(out); return FWP_NONE; }
            out[k++] = (char)(h * 16 + l);
            i += 3;
        } else if (d[i] == '+' && plus) {
            out[k++] = ' ';
            i++;
        } else {
            out[k++] = d[i++];
        }
    }
    if (!fwp_valid_utf8((const unsigned char *)out, k)) { free(out); return FWP_NONE; }
    V r = fwp_str_new(out, k);
    free(out);
    return fwp_some(r);
}

static long fwp_rfind_char(const char *d, size_t n, char c) {
    for (size_t i = n; i > 0; i--) if (d[i - 1] == c) return (long)(i - 1);
    return -1;
}

static long fwp_find_char(const char *d, size_t n, char c) {
    for (size_t i = 0; i < n; i++) if (d[i] == c) return (long)i;
    return -1;
}

static V fwp_p_url_split(V sv) {
    const char *s = STR(sv)->d;
    size_t n = STR(sv)->len;
    for (size_t j = 0; j < n; j++)
        if ((unsigned char)s[j] <= 0x20 || s[j] == 0x7f) return FWP_NONE;
    long i = fwp_memfind(s, n, "://", 3);
    if (i <= 0) return FWP_NONE;
    char *scheme = (char *)malloc((size_t)i + 1);
    for (long j = 0; j < i; j++) scheme[j] = (char)tolower((unsigned char)s[j]);
    scheme[i] = 0;
    const char *rest = s + i + 3;
    size_t rn = n - (size_t)i - 3;
    size_t end = rn;
    for (size_t j = 0; j < rn; j++) if (rest[j] == '/' || rest[j] == '?' || rest[j] == '#') { end = j; break; }
    const char *auth = rest;
    size_t an = end;
    const char *tail = rest + end;
    size_t tn = rn - end;
    long h = fwp_find_char(tail, tn, '#');
    if (h >= 0) tn = (size_t)h;
    const char *path = tail, *query = "";
    size_t pn = tn, qn = 0;
    long q = fwp_find_char(tail, tn, '?');
    if (q >= 0) { pn = (size_t)q; query = tail + q + 1; qn = tn - (size_t)q - 1; }
    if (pn == 0) { path = "/"; pn = 1; }
    long at = fwp_rfind_char(auth, an, '@');
    if (at >= 0) { auth += at + 1; an -= (size_t)at + 1; }
    const char *host = auth, *port = 0;
    size_t hn = an, portn = 0;
    if (an > 0 && auth[0] == '[') {
        long e = fwp_find_char(auth + 1, an - 1, ']');
        if (e < 0) { free(scheme); return FWP_NONE; }
        host = auth + 1;
        hn = (size_t)e;
        const char *after = auth + 1 + e + 1;
        size_t aftern = an - 1 - (size_t)e - 1;
        if (aftern > 0 && after[0] != ':') { free(scheme); return FWP_NONE; }
        if (aftern > 0) { port = after + 1; portn = aftern - 1; }
    } else {
        long c = fwp_rfind_char(auth, an, ':');
        if (c >= 0) { hn = (size_t)c; port = auth + c + 1; portn = an - (size_t)c - 1; }
    }
    if (hn == 0) { free(scheme); return FWP_NONE; }
    int64_t pv;
    if (port) {
        if (portn == 0 || portn > 5) { free(scheme); return FWP_NONE; }
        pv = 0;
        for (size_t j = 0; j < portn; j++) {
            if (!isdigit((unsigned char)port[j])) { free(scheme); return FWP_NONE; }
            pv = pv * 10 + (port[j] - '0');
        }
        if (pv > 65535) { free(scheme); return FWP_NONE; }
    } else if (!strcmp(scheme, "http") || !strcmp(scheme, "ws")) pv = 80;
    else if (!strcmp(scheme, "https") || !strcmp(scheme, "wss")) pv = 443;
    else pv = 0;
    V f[5] = {fwp_cstr(scheme), fwp_str_new(host, hn), (V)pv, fwp_str_new(path, pn), fwp_str_new(query, qn)};
    free(scheme);
    return fwp_some(fwp_record(5, f));
}

static int fwp_tchar(unsigned char c) {
    return isalnum(c) || (c && strchr("!#$%&'*+-.^_`|~", c));
}

/* a header that can be written without changing the message's framing */
static V fwp_p_field_ok(V name, V value) {
    size_t nn = STR(name)->len, vn = STR(value)->len;
    if (nn == 0) return FWP_FALSE;
    for (size_t i = 0; i < nn; i++)
        if (!fwp_tchar((unsigned char)STR(name)->d[i])) return FWP_FALSE;
    for (size_t i = 0; i < vn; i++) {
        unsigned char c = (unsigned char)STR(value)->d[i];
        if ((c < 0x20 && c != '\t') || c == 0x7f) return FWP_FALSE;
    }
    return FWP_TRUE;
}

/* the body length a request declares: 0 without content-length, -1 when
 * it is not a plain decimal number or the header is repeated */
static V fwp_p_content_length(V hs) {
    int64_t len = 0;
    int seen = 0;
    for (; hs != 0; hs = OBJ(hs)->f[1]) {
        V h = OBJ(hs)->f[0];
        V name = OBJ(h)->f[0], value = OBJ(h)->f[1];
        if (STR(name)->len != 14) continue;
        int match = 1;
        for (size_t i = 0; i < 14; i++)
            if (tolower((unsigned char)STR(name)->d[i]) != "content-length"[i]) match = 0;
        if (!match) continue;
        size_t n = STR(value)->len;
        if (seen || n == 0 || n > 18) return (V)(int64_t)-1;
        int64_t v = 0;
        for (size_t i = 0; i < n; i++) {
            char c = STR(value)->d[i];
            if (c < '0' || c > '9') return (V)(int64_t)-1;
            v = v * 10 + (c - '0');
        }
        len = v;
        seen = 1;
    }
    return (V)len;
}

static V fwp_http_err(const char *m) {
    V e = fwp_cstr(m);
    return fwp_data(1, 1, &e);
}

/* header lines: lines[i] = (start, len); returns 0 and sets *err on error */
static V fwp_http_headers(const char *d, size_t *starts, size_t *lens, size_t nl, const char **err) {
    V *hs = (V *)fwp_alloc((nl + 1) * sizeof(V));
    for (size_t i = 0; i < nl; i++) {
        const char *line = d + starts[i];
        size_t ln = lens[i];
        long colon = fwp_find_char(line, ln, ':');
        if (colon <= 0) { *err = "invalid header"; return 0; }
        for (long j = 0; j < colon; j++)
            if (!fwp_tchar((unsigned char)line[j])) { *err = "invalid header"; return 0; }
        const char *v = line + colon + 1;
        size_t vn = ln - (size_t)colon - 1;
        while (vn && (v[0] == ' ' || v[0] == '\t')) { v++; vn--; }
        while (vn && (v[vn - 1] == ' ' || v[vn - 1] == '\t')) vn--;
        for (size_t j = 0; j < vn; j++) {
            unsigned char c = (unsigned char)v[j];
            if ((c < 0x20 && c != '\t') || c == 0x7f) { *err = "invalid header"; return 0; }
        }
        if (!fwp_valid_utf8((const unsigned char *)v, vn)) { *err = "invalid header"; return 0; }
        char *name = (char *)malloc((size_t)colon + 1);
        for (long j = 0; j < colon; j++) name[j] = (char)tolower((unsigned char)line[j]);
        hs[i] = fwp_tuple2(fwp_str_new(name, (size_t)colon), fwp_str_new(v, vn));
        free(name);
    }
    return fwp_list_from(hs, nl);
}

static size_t fwp_split_crlf(const char *d, size_t n, size_t **starts, size_t **lens) {
    size_t cap = 16, k = 0, st = 0;
    *starts = (size_t *)malloc(cap * sizeof(size_t));
    *lens = (size_t *)malloc(cap * sizeof(size_t));
    for (;;) {
        long i = fwp_memfind(d + st, n - st, "\r\n", 2);
        if (k == cap) {
            cap *= 2;
            *starts = (size_t *)realloc(*starts, cap * sizeof(size_t));
            *lens = (size_t *)realloc(*lens, cap * sizeof(size_t));
        }
        (*starts)[k] = st;
        if (i < 0) { (*lens)[k++] = n - st; break; }
        (*lens)[k++] = (size_t)i;
        st += (size_t)i + 2;
    }
    return k;
}

static V fwp_p_parse_request_head(V head) {
    const char *d = STR(head)->d;
    size_t *starts, *lens;
    size_t nl = fwp_split_crlf(d, STR(head)->len, &starts, &lens);
    const char *line = d + starts[0];
    size_t ln = lens[0];
    long s1 = fwp_find_char(line, ln, ' ');
    long s2 = s1 < 0 ? -1 : fwp_find_char(line + s1 + 1, ln - (size_t)s1 - 1, ' ');
    V r;
    if (s1 <= 0 || s2 <= 0 || fwp_find_char(line + s1 + 1 + s2 + 1, ln - (size_t)(s1 + 1 + s2 + 1), ' ') >= 0) {
        r = fwp_http_err("invalid request line");
        goto done;
    }
    const char *method = line, *target = line + s1 + 1, *version = line + s1 + 1 + s2 + 1;
    size_t mn = (size_t)s1, tn = (size_t)s2, vn = ln - (size_t)(s1 + 1 + s2 + 1);
    int bad = 0;
    for (size_t j = 0; j < mn; j++) if (!fwp_tchar((unsigned char)method[j])) bad = 1;
    for (size_t j = 0; j < tn; j++) if ((unsigned char)target[j] <= 0x20 || target[j] == 0x7f) bad = 1;
    if (bad || !fwp_valid_utf8((const unsigned char *)target, tn)) { r = fwp_http_err("invalid request line"); goto done; }
    if (!(vn == 8 && (!memcmp(version, "HTTP/1.1", 8) || !memcmp(version, "HTTP/1.0", 8)))) {
        r = fwp_http_err("unsupported HTTP version");
        goto done;
    }
    const char *err = 0;
    V hs = fwp_http_headers(d, starts + 1, lens + 1, nl - 1, &err);
    if (err) { r = fwp_http_err(err); goto done; }
    {
        V f[4] = {fwp_str_new(method, mn), fwp_str_new(target, tn), fwp_str_new(version, vn), hs};
        V t = fwp_record(4, f);
        r = fwp_data(0, 1, &t);
    }
done:
    free(starts);
    free(lens);
    return r;
}

static V fwp_p_parse_response_head(V head) {
    const char *d = STR(head)->d;
    size_t *starts, *lens;
    size_t nl = fwp_split_crlf(d, STR(head)->len, &starts, &lens);
    const char *line = d + starts[0];
    size_t ln = lens[0];
    V r;
    long sp = fwp_find_char(line, ln, ' ');
    const char *rest = line + sp + 1;
    size_t rn = sp < 0 ? 0 : ln - (size_t)sp - 1;
    if (sp != 8 || memcmp(line, "HTTP/1.", 7) || rn < 3 || !isdigit((unsigned char)rest[0]) ||
        !isdigit((unsigned char)rest[1]) || !isdigit((unsigned char)rest[2]) || (rn > 3 && rest[3] != ' ')) {
        r = fwp_http_err("invalid status line");
        goto done;
    }
    int64_t status = (rest[0] - '0') * 100 + (rest[1] - '0') * 10 + (rest[2] - '0');
    const char *reason = rn > 4 ? rest + 4 : "";
    size_t reasonn = rn > 4 ? rn - 4 : 0;
    if (!fwp_valid_utf8((const unsigned char *)reason, reasonn)) { r = fwp_http_err("invalid status line"); goto done; }
    const char *err = 0;
    V hs = fwp_http_headers(d, starts + 1, lens + 1, nl - 1, &err);
    if (err) { r = fwp_http_err(err); goto done; }
    {
        V f[4] = {fwp_str_new(line, 8), (V)status, fwp_str_new(reason, reasonn), hs};
        V t = fwp_record(4, f);
        r = fwp_data(0, 1, &t);
    }
done:
    free(starts);
    free(lens);
    return r;
}

static V fwp_p_to_hex(V nv) {
    int64_t n = (int64_t)nv;
    char t[32];
    if (n < 0) snprintf(t, sizeof t, "-%llx", (unsigned long long)(-(i128)n));
    else snprintf(t, sizeof t, "%llx", (unsigned long long)n);
    return fwp_cstr(t);
}

static V fwp_p_parse_hex(V s) {
    size_t n = STR(s)->len;
    if (n == 0 || n > 15) return FWP_NONE;
    int64_t v = 0;
    for (size_t i = 0; i < n; i++) {
        int h = fwp_hexval((unsigned char)STR(s)->d[i]);
        if (h < 0) return FWP_NONE;
        v = v * 16 + h;
    }
    return fwp_some((V)v);
}
