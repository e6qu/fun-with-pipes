/* JSON text <-> the standard library's `Json` type; mirrors src/json.rs
 * (same results and error positions). Constructors, in declaration order:
 * Null, Bool, Num, Str, Arr, Obj. */

typedef struct {
    const unsigned char *s;
    size_t n, p;
    int depth;
    char err[96];
} fwp_jp;

static int fwp_jerr(fwp_jp *j, const char *what, size_t at) {
    snprintf(j->err, sizeof j->err, "%s at byte %zu", what, at);
    return 0;
}

static void fwp_jws(fwp_jp *j) {
    while (j->p < j->n && (j->s[j->p] == ' ' || j->s[j->p] == '\t' || j->s[j->p] == '\n' || j->s[j->p] == '\r'))
        j->p++;
}

static int fwp_jvalue(fwp_jp *j, V *out);

static size_t fwp_jdigits(fwp_jp *j) {
    size_t st = j->p;
    while (j->p < j->n && isdigit(j->s[j->p])) j->p++;
    return j->p - st;
}

static int fwp_jnumber(fwp_jp *j, V *out) {
    size_t st = j->p;
    if (j->s[j->p] == '-') j->p++;
    if (j->p < j->n && j->s[j->p] == '0') j->p++;
    else if (j->p < j->n && j->s[j->p] >= '1' && j->s[j->p] <= '9') fwp_jdigits(j);
    else return fwp_jerr(j, "invalid number", j->p);
    if (j->p < j->n && j->s[j->p] == '.') {
        j->p++;
        if (!fwp_jdigits(j)) return fwp_jerr(j, "invalid number", j->p);
    }
    if (j->p < j->n && (j->s[j->p] == 'e' || j->s[j->p] == 'E')) {
        j->p++;
        if (j->p < j->n && (j->s[j->p] == '+' || j->s[j->p] == '-')) j->p++;
        if (!fwp_jdigits(j)) return fwp_jerr(j, "invalid number", j->p);
    }
    char tmp[512];
    size_t len = j->p - st;
    double x;
    if (len < sizeof tmp) {
        memcpy(tmp, j->s + st, len);
        tmp[len] = 0;
        x = strtod(tmp, 0);
    } else {
        char *big = (char *)malloc(len + 1);
        memcpy(big, j->s + st, len);
        big[len] = 0;
        x = strtod(big, 0);
        free(big);
    }
    V f = fwp_from_f64(x);
    *out = fwp_data(2, 1, &f);
    return 1;
}

static int fwp_jhex4(fwp_jp *j, uint32_t *v) {
    *v = 0;
    for (int i = 0; i < 4; i++) {
        if (j->p >= j->n || !isxdigit(j->s[j->p])) return fwp_jerr(j, "invalid escape", j->p);
        int c = j->s[j->p];
        *v = *v * 16 + (uint32_t)(isdigit(c) ? c - '0' : (tolower(c) - 'a' + 10));
        j->p++;
    }
    return 1;
}

/* at the opening quote */
static int fwp_jstring(fwp_jp *j, V *out) {
    j->p++;
    fwp_buf b = {0};
    for (;;) {
        if (j->p >= j->n) { free(b.d); return fwp_jerr(j, "unexpected end of input", j->p); }
        unsigned char c = j->s[j->p];
        if (c == '"') { j->p++; *out = buf_to_str(&b); return 1; }
        if (c == '\\') {
            j->p++;
            if (j->p >= j->n) { free(b.d); return fwp_jerr(j, "unexpected end of input", j->p); }
            unsigned char e = j->s[j->p];
            char simple = 0;
            switch (e) {
            case '"': simple = '"'; break;
            case '\\': simple = '\\'; break;
            case '/': simple = '/'; break;
            case 'b': simple = 8; break;
            case 'f': simple = 12; break;
            case 'n': simple = '\n'; break;
            case 'r': simple = '\r'; break;
            case 't': simple = '\t'; break;
            case 'u': break;
            default: free(b.d); return fwp_jerr(j, "invalid escape", j->p);
            }
            j->p++;
            if (simple) { buf_putc(&b, simple); continue; }
            uint32_t code;
            if (!fwp_jhex4(j, &code)) { free(b.d); return 0; }
            if (code >= 0xD800 && code < 0xDC00 && j->p + 1 < j->n && j->s[j->p] == '\\' && j->s[j->p + 1] == 'u') {
                size_t save = j->p;
                j->p += 2;
                uint32_t low;
                if (!fwp_jhex4(j, &low)) { free(b.d); return 0; }
                if (low >= 0xDC00 && low < 0xE000) code = 0x10000 + ((code - 0xD800) << 10) + (low - 0xDC00);
                else j->p = save;
            }
            if ((code >= 0xD800 && code < 0xE000) || code > 0x10FFFF) code = 0xFFFD;
            fwp_utf8_put(&b, code);
            continue;
        }
        if (c < 0x20) { free(b.d); return fwp_jerr(j, "unexpected character", j->p); }
        buf_putc(&b, (char)c);
        j->p++;
    }
}

/* after a value in a container: 1 = more, 2 = closed, 0 = error */
static int fwp_jnext(fwp_jp *j, char close) {
    fwp_jws(j);
    if (j->p >= j->n) return fwp_jerr(j, "unexpected end of input", j->p);
    if (j->s[j->p] == ',') { j->p++; return 1; }
    if (j->s[j->p] == close) { j->p++; return 2; }
    return fwp_jerr(j, "unexpected character", j->p);
}

static int fwp_jexpect(fwp_jp *j, char c) {
    fwp_jws(j);
    if (j->p >= j->n) return fwp_jerr(j, "unexpected end of input", j->p);
    if (j->s[j->p] != c) return fwp_jerr(j, "unexpected character", j->p);
    return 1;
}

static int fwp_jcontainer(fwp_jp *j, V *out, int obj) {
    j->p++;
    size_t n = 0, cap = 8;
    V *items = (V *)malloc(cap * sizeof(V));
    fwp_jws(j);
    char close = obj ? '}' : ']';
    if (j->p < j->n && j->s[j->p] == close) {
        j->p++;
    } else {
        for (;;) {
            V item;
            if (obj) {
                V k, v;
                if (!fwp_jexpect(j, '"') || !fwp_jstring(j, &k) || !fwp_jexpect(j, ':')) { free(items); return 0; }
                j->p++;
                if (!fwp_jvalue(j, &v)) { free(items); return 0; }
                item = fwp_tuple2(k, v);
            } else if (!fwp_jvalue(j, &item)) {
                free(items);
                return 0;
            }
            if (n == cap) { cap *= 2; items = (V *)realloc(items, cap * sizeof(V)); }
            items[n++] = item;
            int r = fwp_jnext(j, close);
            if (!r) { free(items); return 0; }
            if (r == 2) break;
        }
    }
    V l = fwp_list_from(items, n);
    free(items);
    *out = fwp_data(obj ? 5 : 4, 1, &l);
    return 1;
}

static int fwp_jword(fwp_jp *j, const char *w, V v, V *out) {
    size_t len = strlen(w);
    if (j->n - j->p >= len && !memcmp(j->s + j->p, w, len)) {
        j->p += len;
        *out = v;
        return 1;
    }
    return fwp_jerr(j, "unexpected character", j->p);
}

static int fwp_jvalue(fwp_jp *j, V *out) {
    fwp_jws(j);
    if (j->p >= j->n) return fwp_jerr(j, "unexpected end of input", j->p);
    unsigned char c = j->s[j->p];
    switch (c) {
    case '{': case '[': {
        if (j->depth >= 512) return fwp_jerr(j, "nesting too deep", j->p);
        j->depth++;
        int r = fwp_jcontainer(j, out, c == '{');
        j->depth--;
        return r;
    }
    case '"': {
        V s;
        if (!fwp_jstring(j, &s)) return 0;
        *out = fwp_data(3, 1, &s);
        return 1;
    }
    case 't': { V t = FWP_TRUE; return fwp_jword(j, "true", fwp_data(1, 1, &t), out); }
    case 'f': { V f = FWP_FALSE; return fwp_jword(j, "false", fwp_data(1, 1, &f), out); }
    case 'n': return fwp_jword(j, "null", 0, out);
    default:
        if (c == '-' || isdigit(c)) return fwp_jnumber(j, out);
        return fwp_jerr(j, "unexpected character", j->p);
    }
}

static V fwp_p_json_parse(V text) {
    fwp_jp j = {(const unsigned char *)STR(text)->d, STR(text)->len, 0, 0, {0}};
    V v;
    int ok = fwp_jvalue(&j, &v);
    if (ok) {
        fwp_jws(&j);
        if (j.p != j.n) ok = fwp_jerr(&j, "trailing characters", j.p);
    }
    if (ok) return fwp_data(0, 1, &v);
    V e = fwp_cstr(j.err);
    return fwp_data(1, 1, &e);
}

static void fwp_jescape(fwp_buf *b, V s) {
    buf_putc(b, '"');
    for (uint64_t i = 0; i < STR(s)->len; i++) {
        unsigned char c = (unsigned char)STR(s)->d[i];
        switch (c) {
        case '"': buf_puts(b, "\\\""); break;
        case '\\': buf_puts(b, "\\\\"); break;
        case '\n': buf_puts(b, "\\n"); break;
        case '\r': buf_puts(b, "\\r"); break;
        case '\t': buf_puts(b, "\\t"); break;
        case 8: buf_puts(b, "\\b"); break;
        case 12: buf_puts(b, "\\f"); break;
        default:
            if (c < 0x20) {
                char t[8];
                snprintf(t, sizeof t, "\\u%04x", c);
                buf_puts(b, t);
            } else {
                buf_putc(b, (char)c);
            }
        }
    }
    buf_putc(b, '"');
}

static void fwp_jnum(fwp_buf *b, double x) {
    char t[64];
    if (!isfinite(x)) { buf_puts(b, "null"); return; }
    if (x == trunc(x) && fabs(x) < 1e15) {
        snprintf(t, sizeof t, "%lld", (long long)x);
    } else {
        fwp_fmt_f64(t, x);
    }
    buf_puts(b, t);
}

static void fwp_jencode(fwp_buf *b, V v) {
    uint32_t tag = fwp_tag(v);
    switch (tag) {
    case 1: buf_puts(b, OBJ(v)->f[0] == FWP_TRUE ? "true" : "false"); return;
    case 2: fwp_jnum(b, fwp_f64(OBJ(v)->f[0])); return;
    case 3: fwp_jescape(b, OBJ(v)->f[0]); return;
    case 4: case 5: {
        buf_putc(b, tag == 4 ? '[' : '{');
        int first = 1;
        for (V l = OBJ(v)->f[0]; l; l = OBJ(l)->f[1]) {
            if (!first) buf_putc(b, ',');
            first = 0;
            V x = OBJ(l)->f[0];
            if (tag == 4) {
                fwp_jencode(b, x);
            } else {
                fwp_jescape(b, OBJ(x)->f[0]);
                buf_putc(b, ':');
                fwp_jencode(b, OBJ(x)->f[1]);
            }
        }
        buf_putc(b, tag == 4 ? ']' : '}');
        return;
    }
    default: buf_puts(b, "null");
    }
}

static V fwp_p_json_encode(V v) {
    fwp_buf b = {0};
    fwp_jencode(&b, v);
    return buf_to_str(&b);
}
