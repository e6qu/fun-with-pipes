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

static V fwp_p_url_decode(V s, int plus, const fwp_desc *result_type) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len;
    fwp_decode_fields result;
    fwp_decode_fields_begin(&result, 1, result_type->vfields[1], 1, NULL);
    if (n == SIZE_MAX) fwp_trap("decoded value too large");
    char *out = result.scratch = fwp_mem_alloc(n + 1);
    size_t k = 0;
    for (size_t i = 0; i < n;) {
        if (d[i] == '%') {
            int h = i + 1 < n ? fwp_hexval((unsigned char)d[i + 1]) : -1;
            int l = i + 2 < n ? fwp_hexval((unsigned char)d[i + 2]) : -1;
            if (h < 0 || l < 0) { fwp_decode_fields_end(&result, 0); return FWP_NONE; }
            out[k++] = (char)(h * 16 + l);
            i += 3;
        } else if (d[i] == '+' && plus) {
            out[k++] = ' ';
            i++;
        } else {
            out[k++] = d[i++];
        }
    }
    if (!fwp_valid_utf8((const unsigned char *)out, k)) { fwp_decode_fields_end(&result, 0); return FWP_NONE; }
    result.values[0] = fwp_rc_fresh(fwp_str_new(out, k));
    V value = fwp_decode_variant(&result, 1);
    return value;
}

static long fwp_rfind_char(const char *d, size_t n, char c) {
    for (size_t i = n; i > 0; i--) if (d[i - 1] == c) return (long)(i - 1);
    return -1;
}

static long fwp_find_char(const char *d, size_t n, char c) {
    for (size_t i = 0; i < n; i++) if (d[i] == c) return (long)i;
    return -1;
}

static V fwp_p_url_split(V sv, const fwp_desc *result_type) {
    const char *s = STR(sv)->d;
    size_t n = STR(sv)->len;
    for (size_t j = 0; j < n; j++)
        if ((unsigned char)s[j] <= 0x20 || s[j] == 0x7f) return FWP_NONE;
    long i = fwp_memfind(s, n, "://", 3);
    if (i <= 0) return FWP_NONE;
    fwp_decode_fields result, fields;
    fwp_decode_fields_begin(&result, 1, result_type->vfields[1], 1, NULL);
    const fwp_desc *tuple = result_type->vfields[1][0];
    fwp_decode_fields_begin(&fields, 5, tuple->fields, 5, NULL);
    char *scheme = fields.scratch = fwp_mem_alloc((size_t)i + 1);
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
        if (e < 0) goto invalid;
        host = auth + 1;
        hn = (size_t)e;
        const char *after = auth + 1 + e + 1;
        size_t aftern = an - 1 - (size_t)e - 1;
        if (aftern > 0 && after[0] != ':') goto invalid;
        if (aftern > 0) { port = after + 1; portn = aftern - 1; }
    } else {
        long c = fwp_rfind_char(auth, an, ':');
        if (c >= 0) { hn = (size_t)c; port = auth + c + 1; portn = an - (size_t)c - 1; }
    }
    if (hn == 0) goto invalid;
    int64_t pv;
    if (port) {
        if (portn == 0 || portn > 5) goto invalid;
        pv = 0;
        for (size_t j = 0; j < portn; j++) {
            if (!isdigit((unsigned char)port[j])) goto invalid;
            pv = pv * 10 + (port[j] - '0');
        }
        if (pv > 65535) goto invalid;
    } else if (!strcmp(scheme, "http") || !strcmp(scheme, "ws")) pv = 80;
    else if (!strcmp(scheme, "https") || !strcmp(scheme, "wss")) pv = 443;
    else pv = 0;
    fields.values[0] = fwp_rc_fresh(fwp_cstr(scheme));
    fields.values[1] = fwp_rc_fresh(fwp_str_new(host, hn));
    fields.values[2] = (V)pv;
    fields.values[3] = fwp_rc_fresh(fwp_str_new(path, pn));
    fields.values[4] = fwp_rc_fresh(fwp_str_new(query, qn));
    result.values[0] = fwp_decode_record(&fields);
    V value = fwp_decode_variant(&result, 1);
    return value;
invalid:
    fwp_decode_fields_end(&fields, 0);
    fwp_decode_fields_end(&result, 0);
    return FWP_NONE;
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

static V fwp_http_err(const char *message, const fwp_desc *result_type) {
    fwp_decode_fields error;
    fwp_decode_fields_begin(&error, 1, result_type->vfields[1], 1, NULL);
    error.values[0] = fwp_rc_fresh(fwp_cstr(message));
    return fwp_decode_variant(&error, 1);
}

/* Build from the last header toward the first so the result preserves source
 * order without a scratch vector or mutable list tail. Every invalid header has
 * the same error, and parsing has no callbacks or externally visible effects. */
static V fwp_http_headers(const char *d, size_t n, size_t start,
        const fwp_desc *list_type, const char **err) {
    fwp_value_owner headers = {0, list_type->drop};
    fwp_cleanup cleanup; fwp_value_protect(&headers, &cleanup);
    size_t end = n;
    for (;;) {
        size_t begin = end;
        while (begin > start && !(begin >= 2 && d[begin - 2] == '\r' && d[begin - 1] == '\n')) begin--;
        const char *line = d + begin;
        size_t ln = end - begin;
        long colon = fwp_find_char(line, ln, ':');
        if (colon <= 0) goto invalid;
        for (long j = 0; j < colon; j++) if (!fwp_tchar((unsigned char)line[j])) goto invalid;
        const char *value = line + colon + 1;
        size_t vn = ln - (size_t)colon - 1;
        while (vn && (value[0] == ' ' || value[0] == '\t')) { value++; vn--; }
        while (vn && (value[vn - 1] == ' ' || value[vn - 1] == '\t')) vn--;
        for (size_t j = 0; j < vn; j++) {
            unsigned char c = (unsigned char)value[j];
            if ((c < 0x20 && c != '\t') || c == 0x7f) goto invalid;
        }
        if (!fwp_valid_utf8((const unsigned char *)value, vn)) goto invalid;
        fwp_decode_fields fields;
        fwp_decode_fields_begin(&fields, 2, list_type->elem->fields, 2, NULL);
        fields.values[0] = fwp_rc_fresh(fwp_str_new(line, (size_t)colon));
        for (long j = 0; j < colon; j++) STR(fields.values[0])->d[j] = (char)tolower((unsigned char)line[j]);
        fields.values[1] = fwp_rc_fresh(fwp_str_new(value, vn));
        fwp_value_owner pair = {fwp_decode_record(&fields), list_type->elem->drop};
        fwp_cleanup pair_cleanup; fwp_value_protect(&pair, &pair_cleanup);
        headers.value = fwp_rc_fresh(fwp_cons(pair.value, headers.value));
        fwp_value_finish(&pair, &pair_cleanup);
        if (begin == start) break;
        end = begin - 2;
    }
    return fwp_value_finish(&headers, &cleanup);
invalid:
    *err = "invalid header";
    fwp_value_release(&headers);
    return fwp_value_finish(&headers, &cleanup);
}

static V fwp_p_parse_request_head(V head, const fwp_desc *result_type) {
    const char *d = STR(head)->d;
    size_t n = STR(head)->len;
    long first = fwp_memfind(d, n, "\r\n", 2);
    const char *line = d;
    size_t ln = first < 0 ? n : (size_t)first;
    long s1 = fwp_find_char(line, ln, ' ');
    long s2 = s1 < 0 ? -1 : fwp_find_char(line + s1 + 1, ln - (size_t)s1 - 1, ' ');
    if (s1 <= 0 || s2 <= 0 || fwp_find_char(line + s1 + 1 + s2 + 1, ln - (size_t)(s1 + 1 + s2 + 1), ' ') >= 0) {
        return fwp_http_err("invalid request line", result_type);
    }
    const char *method = line, *target = line + s1 + 1, *version = line + s1 + 1 + s2 + 1;
    size_t mn = (size_t)s1, tn = (size_t)s2, vn = ln - (size_t)(s1 + 1 + s2 + 1);
    int bad = 0;
    for (size_t j = 0; j < mn; j++) if (!fwp_tchar((unsigned char)method[j])) bad = 1;
    for (size_t j = 0; j < tn; j++) if ((unsigned char)target[j] <= 0x20 || target[j] == 0x7f) bad = 1;
    if (bad || !fwp_valid_utf8((const unsigned char *)target, tn)) { return fwp_http_err("invalid request line", result_type); }
    if (!(vn == 8 && (!memcmp(version, "HTTP/1.1", 8) || !memcmp(version, "HTTP/1.0", 8)))) {
        return fwp_http_err("unsupported HTTP version", result_type);
    }
    fwp_decode_fields result, fields;
    fwp_decode_fields_begin(&result, 1, result_type->vfields[0], 1, NULL);
    const fwp_desc *tuple = result_type->vfields[0][0];
    fwp_decode_fields_begin(&fields, 4, tuple->fields, 4, NULL);
    const char *err = 0;
    if (first >= 0) fields.values[3] = fwp_http_headers(d, n, (size_t)first + 2, tuple->fields[3], &err);
    if (err) {
        fwp_decode_fields_end(&fields, 0);
        fwp_decode_fields_end(&result, 0);
        return fwp_http_err(err, result_type);
    }
    fields.values[0] = fwp_rc_fresh(fwp_str_new(method, mn));
    fields.values[1] = fwp_rc_fresh(fwp_str_new(target, tn));
    fields.values[2] = fwp_rc_fresh(fwp_str_new(version, vn));
    result.values[0] = fwp_decode_record(&fields);
    V value = fwp_decode_variant(&result, 0);
    return value;
}

static V fwp_p_parse_response_head(V head, const fwp_desc *result_type) {
    const char *d = STR(head)->d;
    size_t n = STR(head)->len;
    long first = fwp_memfind(d, n, "\r\n", 2);
    const char *line = d;
    size_t ln = first < 0 ? n : (size_t)first;
    long sp = fwp_find_char(line, ln, ' ');
    const char *rest = line + sp + 1;
    size_t rn = sp < 0 ? 0 : ln - (size_t)sp - 1;
    if (sp != 8 || memcmp(line, "HTTP/1.", 7) || rn < 3 || !isdigit((unsigned char)rest[0]) ||
        !isdigit((unsigned char)rest[1]) || !isdigit((unsigned char)rest[2]) || (rn > 3 && rest[3] != ' ')) {
        return fwp_http_err("invalid status line", result_type);
    }
    int64_t status = (rest[0] - '0') * 100 + (rest[1] - '0') * 10 + (rest[2] - '0');
    const char *reason = rn > 4 ? rest + 4 : "";
    size_t reasonn = rn > 4 ? rn - 4 : 0;
    if (!fwp_valid_utf8((const unsigned char *)reason, reasonn)) { return fwp_http_err("invalid status line", result_type); }
    fwp_decode_fields result, fields;
    fwp_decode_fields_begin(&result, 1, result_type->vfields[0], 1, NULL);
    const fwp_desc *tuple = result_type->vfields[0][0];
    fwp_decode_fields_begin(&fields, 4, tuple->fields, 4, NULL);
    const char *err = 0;
    if (first >= 0) fields.values[3] = fwp_http_headers(d, n, (size_t)first + 2, tuple->fields[3], &err);
    if (err) {
        fwp_decode_fields_end(&fields, 0);
        fwp_decode_fields_end(&result, 0);
        return fwp_http_err(err, result_type);
    }
    fields.values[0] = fwp_rc_fresh(fwp_str_new(line, 8));
    fields.values[1] = (V)status;
    fields.values[2] = fwp_rc_fresh(fwp_str_new(reason, reasonn));
    result.values[0] = fwp_decode_record(&fields);
    V value = fwp_decode_variant(&result, 0);
    return value;
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
