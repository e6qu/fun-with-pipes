/* JSON text <-> the standard library's `Json` type, and typed JSON
 * (`json.write`, `json.read`: any encodable value, driven by its type
 * descriptor). Mirrors src/json.rs and src/jsontype.rs: same results, error
 * positions and messages. `Json` constructors, in declaration order: Null,
 * Bool, Num, Str, Arr, Obj. */

/* A parsed value whose numbers keep their text. */
typedef struct fwp_jr fwp_jr;
struct fwp_jr {
    int t;              /* 0 null, 1 bool, 2 number, 3 string, 4 array, 5 object */
    int b;              /* bool */
    const char *s;      /* number text or string bytes */
    size_t len;
    size_t n;           /* array items or object members */
    fwp_jr *items;
    const char **keys;  /* object keys */
    size_t *klens;
};

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

static int fwp_jraw(fwp_jp *j, fwp_jr *out);

static size_t fwp_jdigits(fwp_jp *j) {
    size_t st = j->p;
    while (j->p < j->n && isdigit(j->s[j->p])) j->p++;
    return j->p - st;
}

static int fwp_jnumber(fwp_jp *j, fwp_jr *out) {
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
    out->t = 2;
    out->s = (const char *)j->s + st;
    out->len = j->p - st;
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

/* at the opening quote; the bytes go to the heap */
static int fwp_jstring(fwp_jp *j, const char **s, size_t *len) {
    j->p++;
    fwp_buf b = {0};
    for (;;) {
        if (j->p >= j->n) { free(b.d); return fwp_jerr(j, "unexpected end of input", j->p); }
        unsigned char c = j->s[j->p];
        if (c == '"') {
            j->p++;
            char *r = (char *)fwp_alloc(b.len + 1);
            if (b.len) memcpy(r, b.d, b.len);
            r[b.len] = 0;
            *s = r;
            *len = b.len;
            free(b.d);
            return 1;
        }
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

static int fwp_jcontainer(fwp_jp *j, fwp_jr *out, int obj) {
    j->p++;
    size_t n = 0, cap = 8;
    fwp_jr *items = (fwp_jr *)malloc(cap * sizeof(fwp_jr));
    const char **keys = obj ? (const char **)malloc(cap * sizeof(char *)) : 0;
    size_t *klens = obj ? (size_t *)malloc(cap * sizeof(size_t)) : 0;
    int ok = 1;
    fwp_jws(j);
    char close = obj ? '}' : ']';
    if (j->p < j->n && j->s[j->p] == close) {
        j->p++;
    } else {
        for (;;) {
            if (n == cap) {
                cap *= 2;
                items = (fwp_jr *)realloc(items, cap * sizeof(fwp_jr));
                if (obj) {
                    keys = (const char **)realloc(keys, cap * sizeof(char *));
                    klens = (size_t *)realloc(klens, cap * sizeof(size_t));
                }
            }
            memset(&items[n], 0, sizeof(fwp_jr));
            if (obj) {
                if (!fwp_jexpect(j, '"') || !fwp_jstring(j, &keys[n], &klens[n]) || !fwp_jexpect(j, ':')) { ok = 0; break; }
                j->p++;
            }
            if (!fwp_jraw(j, &items[n])) { ok = 0; break; }
            n++;
            int r = fwp_jnext(j, close);
            if (!r) { ok = 0; break; }
            if (r == 2) break;
        }
    }
    if (ok) {
        out->t = obj ? 5 : 4;
        out->n = n;
        out->items = (fwp_jr *)fwp_alloc((n + 1) * sizeof(fwp_jr));
        if (n) memcpy(out->items, items, n * sizeof(fwp_jr));
        if (obj) {
            out->keys = (const char **)fwp_alloc((n + 1) * sizeof(char *));
            out->klens = (size_t *)fwp_alloc((n + 1) * sizeof(size_t));
            if (n) {
                memcpy(out->keys, keys, n * sizeof(char *));
                memcpy(out->klens, klens, n * sizeof(size_t));
            }
        }
    }
    free(items);
    free(keys);
    free(klens);
    return ok;
}

static int fwp_jword(fwp_jp *j, const char *w, int t, int b, fwp_jr *out) {
    size_t len = strlen(w);
    if (j->n - j->p >= len && !memcmp(j->s + j->p, w, len)) {
        j->p += len;
        out->t = t;
        out->b = b;
        return 1;
    }
    return fwp_jerr(j, "unexpected character", j->p);
}

static int fwp_jraw(fwp_jp *j, fwp_jr *out) {
    memset(out, 0, sizeof *out);
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
    case '"':
        out->t = 3;
        return fwp_jstring(j, &out->s, &out->len);
    case 't': return fwp_jword(j, "true", 1, 1, out);
    case 'f': return fwp_jword(j, "false", 1, 0, out);
    case 'n': return fwp_jword(j, "null", 0, 0, out);
    default:
        if (c == '-' || isdigit(c)) return fwp_jnumber(j, out);
        return fwp_jerr(j, "unexpected character", j->p);
    }
}

/* parse a whole text; 0 with j->err on a syntax error */
static int fwp_jparse_raw(V text, fwp_jp *j, fwp_jr *out) {
    j->s = (const unsigned char *)STR(text)->d;
    j->n = STR(text)->len;
    j->p = 0;
    j->depth = 0;
    j->err[0] = 0;
    if (!fwp_jraw(j, out)) return 0;
    fwp_jws(j);
    if (j->p != j->n) return fwp_jerr(j, "trailing characters", j->p);
    return 1;
}

static double fwp_jnum_f64(const fwp_jr *r) {
    char *t = (char *)malloc(r->len + 1);
    memcpy(t, r->s, r->len);
    t[r->len] = 0;
    double x = strtod(t, 0);
    free(t);
    return x;
}

/* a parsed value as a `Json` value */
static V fwp_jr_to_json(const fwp_jr *r) {
    switch (r->t) {
    case 1: { V b = r->b ? FWP_TRUE : FWP_FALSE; return fwp_data(1, 1, &b); }
    case 2: { V f = fwp_from_f64(fwp_jnum_f64(r)); return fwp_data(2, 1, &f); }
    case 3: { V s = fwp_str_new(r->s, r->len); return fwp_data(3, 1, &s); }
    case 4: case 5: {
        V *items = (V *)fwp_alloc((r->n + 1) * sizeof(V));
        for (size_t i = 0; i < r->n; i++) {
            V x = fwp_jr_to_json(&r->items[i]);
            items[i] = r->t == 4 ? x : fwp_tuple2(fwp_str_new(r->keys[i], r->klens[i]), x);
        }
        V l = fwp_list_from(items, r->n);
        return fwp_data((uint32_t)r->t, 1, &l);
    }
    default: return 0;
    }
}

static V fwp_p_json_parse(V text) {
    fwp_jp j;
    fwp_jr r;
    if (fwp_jparse_raw(text, &j, &r)) {
        V v = fwp_jr_to_json(&r);
        return fwp_data(0, 1, &v);
    }
    V e = fwp_cstr(j.err);
    return fwp_data(1, 1, &e);
}

static void fwp_jescape_n(fwp_buf *b, const char *s, size_t n) {
    buf_putc(b, '"');
    for (size_t i = 0; i < n; i++) {
        unsigned char c = (unsigned char)s[i];
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

static void fwp_jescape(fwp_buf *b, V s) { fwp_jescape_n(b, STR(s)->d, STR(s)->len); }

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

/* ------------------------------------------------------------ typed JSON */

/* Descriptor flags (`width` of variant types): 1 Bool, 2 Option, 3 Json;
 * of records: 2 Duration (see src/cgen.rs). */
#define FWP_ADT_BOOL 1
#define FWP_ADT_OPTION 2
#define FWP_ADT_JSON 3
#define FWP_REC_DURATION 2

static int fwp_jt_is_option(const fwp_desc *d) { return d->kind == K_ADT && d->width == FWP_ADT_OPTION; }

static int fwp_jt_is_tuple(const fwp_desc *d) {
    if (d->kind != K_RECORD || d->name || d->n == 0) return 0;
    for (int i = 0; i < d->n; i++) {
        char t[16];
        snprintf(t, sizeof t, "%d", i);
        if (strcmp(d->names[i], t) != 0) return 0;
    }
    return 1;
}

static int fwp_jt_is_enum(const fwp_desc *d) {
    for (int i = 0; i < d->n; i++) if (d->arity[i]) return 0;
    return 1;
}

static const char fwp_b64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static void fwp_jt_float(fwp_buf *b, double x, const char *text) {
    if (isnan(x)) buf_puts(b, "\"NaN\"");
    else if (isinf(x)) buf_puts(b, x > 0 ? "\"Infinity\"" : "\"-Infinity\"");
    else buf_puts(b, text);
}

static void fwp_jt_write(fwp_buf *b, V v, const fwp_desc *d) {
    char t[512];
    switch (d->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64: case K_TINT: case K_TRIT:
        snprintf(t, sizeof t, "%lld", (long long)(int64_t)v); buf_puts(b, t); return;
    case K_U8: case K_U16: case K_U32: case K_U64:
        snprintf(t, sizeof t, "%llu", (unsigned long long)v); buf_puts(b, t); return;
    case K_I128: fwp_fmt_i128(t, fwp_i128(v)); buf_putc(b, '"'); buf_puts(b, t); buf_putc(b, '"'); return;
    case K_U128: fwp_fmt_u128(t, fwp_u128(v)); buf_putc(b, '"'); buf_puts(b, t); buf_putc(b, '"'); return;
    case K_F32: fwp_fmt_f32(t, fwp_f32(v)); fwp_jt_float(b, (double)fwp_f32(v), t); return;
    case K_F64: fwp_fmt_f64(t, fwp_f64(v)); fwp_jt_float(b, fwp_f64(v), t); return;
    case K_STR: fwp_jescape(b, v); return;
    case K_BYTES: {
        const unsigned char *s = (const unsigned char *)STR(v)->d;
        uint64_t n = STR(v)->len;
        buf_putc(b, '"');
        for (uint64_t i = 0; i < n; i += 3) {
            uint32_t x = (uint32_t)s[i] << 16 | (i + 1 < n ? (uint32_t)s[i + 1] << 8 : 0) | (i + 2 < n ? s[i + 2] : 0);
            uint64_t have = n - i < 3 ? n - i : 3;
            for (uint64_t k = 0; k < 4; k++) buf_putc(b, k <= have ? fwp_b64[(x >> (18 - 6 * k)) & 63] : '=');
        }
        buf_putc(b, '"');
        return;
    }
    case K_LIST: {
        buf_putc(b, '[');
        for (int first = 1; v != 0; v = OBJ(v)->f[1], first = 0) {
            if (!first) buf_putc(b, ',');
            fwp_jt_write(b, OBJ(v)->f[0], d->elem);
        }
        buf_putc(b, ']');
        return;
    }
    case K_ARRAY: {
        buf_putc(b, '[');
        for (uint64_t i = 0; i < ARR(v)->len; i++) {
            if (i) buf_putc(b, ',');
            fwp_jt_write(b, ARR(v)->d[i], d->elem);
        }
        buf_putc(b, ']');
        return;
    }
    case K_SET: {
        buf_putc(b, '[');
        for (uint64_t i = 0; i < MAP(v)->len; i++) {
            if (i) buf_putc(b, ',');
            fwp_jt_write(b, MAP(v)->d[2 * i], d->elem);
        }
        buf_putc(b, ']');
        return;
    }
    case K_MAP: {
        int obj = d->elem->kind == K_STR;
        buf_putc(b, obj ? '{' : '[');
        for (uint64_t i = 0; i < MAP(v)->len; i++) {
            if (i) buf_putc(b, ',');
            if (obj) {
                fwp_jescape(b, MAP(v)->d[2 * i]);
                buf_putc(b, ':');
                fwp_jt_write(b, MAP(v)->d[2 * i + 1], d->elem2);
            } else {
                buf_putc(b, '[');
                fwp_jt_write(b, MAP(v)->d[2 * i], d->elem);
                buf_putc(b, ',');
                fwp_jt_write(b, MAP(v)->d[2 * i + 1], d->elem2);
                buf_putc(b, ']');
            }
        }
        buf_putc(b, obj ? '}' : ']');
        return;
    }
    case K_RECORD: {
        if (d->name && d->width == FWP_REC_DURATION) {
            fwp_fmt_duration(t, (int64_t)OBJ(v)->f[0]);
            buf_putc(b, '"');
            buf_puts(b, t);
            buf_putc(b, '"');
            return;
        }
        if (d->n == 0) { buf_puts(b, "{}"); return; }
        if (fwp_jt_is_tuple(d)) {
            buf_putc(b, '[');
            for (int i = 0; i < d->n; i++) {
                if (i) buf_putc(b, ',');
                fwp_jt_write(b, OBJ(v)->f[i], d->fields[i]);
            }
            buf_putc(b, ']');
            return;
        }
        buf_putc(b, '{');
        int first = 1;
        for (int k = 0; k < d->n; k++) {
            int i = d->order ? d->order[k] : k;
            V x = OBJ(v)->f[i];
            if (fwp_jt_is_option(d->fields[i]) && x == FWP_NONE) continue;
            if (!first) buf_putc(b, ',');
            first = 0;
            const char *jn = d->jnames ? d->jnames[i] : d->names[i];
            fwp_jescape_n(b, jn, strlen(jn));
            buf_putc(b, ':');
            fwp_jt_write(b, x, d->fields[i]);
        }
        buf_putc(b, '}');
        return;
    }
    case K_ADT: {
        uint32_t tag = fwp_tag(v);
        if (d->width == FWP_ADT_BOOL) { buf_puts(b, v == FWP_TRUE ? "true" : "false"); return; }
        if (d->width == FWP_ADT_JSON) { fwp_jencode(b, v); return; }
        if (d->width == FWP_ADT_OPTION) {
            if (v == FWP_NONE) { buf_puts(b, "null"); return; }
            const fwp_desc *inner = d->vfields[1][0];
            int nest = fwp_jt_is_option(inner);
            if (nest) buf_putc(b, '[');
            fwp_jt_write(b, OBJ(v)->f[0], inner);
            if (nest) buf_putc(b, ']');
            return;
        }
        if (fwp_jt_is_enum(d)) { fwp_jescape_n(b, d->names[tag], strlen(d->names[tag])); return; }
        buf_puts(b, "{\"type\":");
        fwp_jescape_n(b, d->names[tag], strlen(d->names[tag]));
        int n = d->arity[tag];
        if (n == 1) {
            buf_puts(b, ",\"value\":");
            fwp_jt_write(b, OBJ(v)->f[0], d->vfields[tag][0]);
        } else if (n > 1) {
            buf_puts(b, ",\"value\":[");
            for (int i = 0; i < n; i++) {
                if (i) buf_putc(b, ',');
                fwp_jt_write(b, OBJ(v)->f[i], d->vfields[tag][i]);
            }
            buf_putc(b, ']');
        }
        buf_putc(b, '}');
        return;
    }
    default: buf_puts(b, "null");
    }
}

static V fwp_p_json_write(V v, const fwp_desc *d) {
    fwp_buf b = {0};
    fwp_jt_write(&b, v, d);
    return buf_to_str(&b);
}

/* --- reading */

typedef struct { fwp_buf path; fwp_buf err; } fwp_jt;

static int fwp_jt_isnum(const char *s, size_t n) {
    size_t i = 0;
    if (i < n && s[i] == '-') i++;
    if (i < n && s[i] == '0') i++;
    else if (i < n && s[i] >= '1' && s[i] <= '9') { while (i < n && isdigit((unsigned char)s[i])) i++; }
    else return 0;
    if (i < n && s[i] == '.') {
        i++;
        size_t st = i;
        while (i < n && isdigit((unsigned char)s[i])) i++;
        if (i == st) return 0;
    }
    if (i < n && (s[i] == 'e' || s[i] == 'E')) {
        i++;
        if (i < n && (s[i] == '+' || s[i] == '-')) i++;
        size_t st = i;
        while (i < n && isdigit((unsigned char)s[i])) i++;
        if (i == st) return 0;
    }
    return i == n;
}

/* the exact integer value of a JSON number (src/jsontype.rs, exact_int):
 * 1 = integer, 0 = not integral, 2 = too big */
static int fwp_jt_exact(const char *s, size_t n, int *neg, u128 *mag) {
    *neg = 0;
    *mag = 0;
    size_t i = 0;
    if (i < n && s[i] == '-') { *neg = 1; i++; }
    char *digits = (char *)malloc(n + 1);
    size_t nd = 0;
    int64_t fl = 0, exp = 0;
    int dot = 0;
    for (; i < n && s[i] != 'e' && s[i] != 'E'; i++) {
        if (s[i] == '.') { dot = 1; continue; }
        if (dot) fl++;
        if (nd == 0 && s[i] == '0') continue; /* leading zeros */
        digits[nd++] = s[i];
    }
    int big = 0;
    if (i < n) {
        i++;
        int eneg = 0;
        if (i < n && (s[i] == '+' || s[i] == '-')) { eneg = s[i] == '-'; i++; }
        for (; i < n; i++) {
            int dg = s[i] - '0';
            if (exp > (INT64_MAX - dg) / 10) big = 1;
            else exp = exp * 10 + dg;
        }
        if (eneg) exp = -exp;
    }
    int r = 1;
    if (nd == 0) { *neg = 0; goto done; }
    if (big) { r = 2; goto done; }
    exp -= fl;
    while (exp < 0) {
        if (nd == 0) { *neg = 0; *mag = 0; goto done; }
        if (digits[nd - 1] != '0') { r = 0; goto done; }
        nd--;
        exp++;
    }
    if (exp > 40 || (int64_t)nd + exp > 40) { r = 2; goto done; }
    u128 x = 0;
    for (int64_t k = 0; k < (int64_t)nd + exp; k++) {
        int dgt = k < (int64_t)nd ? digits[k] - '0' : 0;
        if (x > (~(u128)0 - (u128)dgt) / 10) { r = 2; goto done; }
        x = x * 10 + (u128)dgt;
    }
    if (x == 0) *neg = 0;
    *mag = x;
done:
    free(digits);
    return r;
}

static void fwp_jt_got(fwp_buf *b, const fwp_jr *r) {
    switch (r->t) {
    case 0: buf_puts(b, "null"); return;
    case 1: buf_puts(b, r->b ? "true" : "false"); return;
    case 2:
        if (r->len > 32) { buf_put(b, r->s, 32); buf_puts(b, "..."); }
        else buf_put(b, r->s, r->len);
        return;
    case 3: {
        size_t cps = 0, cut = r->len;
        for (size_t i = 0; i < r->len; i++) {
            if (((unsigned char)r->s[i] & 0xC0) != 0x80) {
                if (cps == 32) { cut = i; break; }
                cps++;
            }
        }
        if (cut < r->len) {
            fwp_buf t = {0};
            buf_put(&t, r->s, cut);
            buf_puts(&t, "...");
            fwp_jescape_n(b, t.d, t.len);
            free(t.d);
        } else {
            fwp_jescape_n(b, r->s, r->len);
        }
        return;
    }
    case 4: buf_puts(b, "an array"); return;
    default: buf_puts(b, "an object"); return;
    }
}

static int fwp_jt_expected(fwp_jt *c, const char *what, const fwp_jr *r) {
    buf_put(&c->err, c->path.d, c->path.len);
    buf_puts(&c->err, ": expected ");
    buf_puts(&c->err, what);
    buf_puts(&c->err, ", got ");
    fwp_jt_got(&c->err, r);
    return 0;
}

static int fwp_jt_range(fwp_jt *c, const fwp_jr *r, const char *ty) {
    buf_put(&c->err, c->path.d, c->path.len);
    buf_puts(&c->err, ": ");
    fwp_jt_got(&c->err, r);
    buf_puts(&c->err, " is out of range for ");
    buf_puts(&c->err, ty);
    return 0;
}

static int fwp_jt_missing(fwp_jt *c) {
    buf_put(&c->err, c->path.d, c->path.len);
    buf_puts(&c->err, ": required field is missing");
    return 0;
}

static void fwp_jt_push_key(fwp_jt *c, const char *k, size_t n) {
    int simple = n > 0 && (isalpha((unsigned char)k[0]) || k[0] == '_');
    for (size_t i = 0; simple && i < n; i++)
        if (!isalnum((unsigned char)k[i]) && k[i] != '_' && k[i] != '-') simple = 0;
    if (simple) {
        buf_putc(&c->path, '.');
        buf_put(&c->path, k, n);
    } else {
        buf_putc(&c->path, '[');
        fwp_jescape_n(&c->path, k, n);
        buf_putc(&c->path, ']');
    }
}

static void fwp_jt_push_index(fwp_jt *c, size_t i) {
    char t[32];
    snprintf(t, sizeof t, "[%zu]", i);
    buf_puts(&c->path, t);
}

static void fwp_jt_pop(fwp_jt *c, size_t len) {
    c->path.len = len;
    if (c->path.d) c->path.d[len] = 0;
}

/* the last member named k */
static const fwp_jr *fwp_jt_member(const fwp_jr *r, const char *k) {
    size_t kl = strlen(k);
    for (size_t i = r->n; i > 0; i--)
        if (r->klens[i - 1] == kl && memcmp(r->keys[i - 1], k, kl) == 0) return &r->items[i - 1];
    return 0;
}

/* a number, or a string holding one */
static int fwp_jt_numtext(const fwp_jr *r, const char **s, size_t *n) {
    if (r->t == 2 || (r->t == 3 && fwp_jt_isnum(r->s, r->len))) { *s = r->s; *n = r->len; return 1; }
    return 0;
}

/* an integer of kind k (I8..U128; I128 and U128 boxed) */
static int fwp_jt_int(fwp_jt *c, const fwp_jr *r, int k, const char *ty, V *out) {
    const char *s;
    size_t n;
    if (!fwp_jt_numtext(r, &s, &n)) return fwp_jt_expected(c, "an integer", r);
    int neg;
    u128 mag;
    int e = fwp_jt_exact(s, n, &neg, &mag);
    if (e == 0) return fwp_jt_expected(c, "an integer", r);
    if (e == 2) return fwp_jt_range(c, r, ty);
    u128 max;
    int sgn = 1;
    switch (k) {
    case K_I8: max = 127; break;
    case K_I16: max = 32767; break;
    case K_I32: max = 2147483647; break;
    case K_I64: max = (u128)INT64_MAX; break;
    case K_I128: max = ((u128)1 << 127) - 1; break;
    case K_U8: max = 255; sgn = 0; break;
    case K_U16: max = 65535; sgn = 0; break;
    case K_U32: max = 4294967295u; sgn = 0; break;
    case K_U64: max = (u128)UINT64_MAX; sgn = 0; break;
    default: max = ~(u128)0; sgn = 0; break;
    }
    if (sgn ? (neg ? mag > max + 1 : mag > max) : (neg || mag > max)) return fwp_jt_range(c, r, ty);
    if (k == K_I128) *out = fwp_box_i128(neg ? (i128)((u128)0 - mag) : (i128)mag);
    else if (k == K_U128) *out = fwp_box_u128(mag);
    else if (sgn) *out = (V)(neg ? (int64_t)((uint64_t)0 - (uint64_t)mag) : (int64_t)(uint64_t)mag);
    else *out = (V)(uint64_t)mag;
    return 1;
}

/* the text of a float to give strtod/strtof (malloc'ed) */
static char *fwp_jt_floattext(fwp_jt *c, const fwp_jr *r) {
    const char *s = 0;
    size_t n = 0;
    if (r->t == 3 && r->len == 3 && memcmp(r->s, "NaN", 3) == 0) { s = "nan"; n = 3; }
    else if (r->t == 3 && r->len == 8 && memcmp(r->s, "Infinity", 8) == 0) { s = "inf"; n = 3; }
    else if (r->t == 3 && r->len == 9 && memcmp(r->s, "-Infinity", 9) == 0) { s = "-inf"; n = 4; }
    else if (!fwp_jt_numtext(r, &s, &n)) { fwp_jt_expected(c, "a number", r); return 0; }
    char *t = (char *)malloc(n + 1);
    memcpy(t, s, n);
    t[n] = 0;
    return t;
}

static int fwp_jt_unb64(const char *s, size_t n, V *out) {
    size_t body = n;
    if (body >= 2 && s[body - 1] == '=' && s[body - 2] == '=') body -= 2;
    else if (body >= 1 && s[body - 1] == '=') body -= 1;
    if (body % 4 == 1 || (body != n && n % 4 != 0)) return 0;
    char *o = (char *)fwp_alloc(body * 3 / 4 + 1);
    size_t on = 0;
    uint32_t acc = 0;
    int bits = 0;
    for (size_t i = 0; i < body; i++) {
        char ch = s[i];
        int d;
        if (ch >= 'A' && ch <= 'Z') d = ch - 'A';
        else if (ch >= 'a' && ch <= 'z') d = ch - 'a' + 26;
        else if (ch >= '0' && ch <= '9') d = ch - '0' + 52;
        else if (ch == '+' || ch == '-') d = 62;
        else if (ch == '/' || ch == '_') d = 63;
        else return 0;
        acc = acc << 6 | (uint32_t)d;
        bits += 6;
        if (bits >= 8) {
            bits -= 8;
            o[on++] = (char)(acc >> bits);
            acc &= (1u << bits) - 1;
        }
    }
    *out = fwp_str_new(o, on);
    return 1;
}

/* `1500ms`, `1.5s`, `-2min`: nanoseconds (src/jsontype.rs, parse_duration) */
static int fwp_jt_duration(const char *s, size_t n, int64_t *ns) {
    size_t i = 0;
    int neg = 0;
    if (i < n && s[i] == '-') { neg = 1; i++; }
    size_t st = i;
    while (i < n && (isdigit((unsigned char)s[i]) || s[i] == '.')) i++;
    if (i == n) return 0;
    const char *num = s + st;
    size_t nl = i - st;
    const char *u = s + i;
    size_t ul = n - i;
    i128 scale;
    if (ul == 2 && !memcmp(u, "ns", 2)) scale = 1;
    else if (ul == 2 && !memcmp(u, "us", 2)) scale = 1000;
    else if (ul == 2 && !memcmp(u, "ms", 2)) scale = 1000000;
    else if (ul == 1 && u[0] == 's') scale = 1000000000;
    else if (ul == 3 && !memcmp(u, "min", 3)) scale = (i128)60000000000LL;
    else if (ul == 1 && u[0] == 'h') scale = (i128)3600000000000LL;
    else return 0;
    size_t dot = nl;
    for (size_t k = 0; k < nl; k++) if (num[k] == '.') { dot = k; break; }
    size_t il = dot, fl = dot < nl ? nl - dot - 1 : 0;
    if (il == 0 || il > 20 || fl > 20 || (nl > 0 && num[nl - 1] == '.')) return 0;
    for (size_t k = dot + 1; k < nl; k++) if (num[k] == '.') return 0;
    i128 ip = 0, fp = 0;
    for (size_t k = 0; k < il; k++) ip = ip * 10 + (num[k] - '0');
    for (size_t k = 0; k < fl; k++) fp = fp * 10 + (num[dot + 1 + k] - '0');
    i128 total = ip * scale;
    i128 frac = fp * scale;
    for (size_t k = 0; k < fl; k++) {
        if (frac % 10 != 0) return 0;
        frac /= 10;
    }
    total += frac;
    if (neg) total = -total;
    if (total > INT64_MAX || total < INT64_MIN) return 0;
    *ns = (int64_t)total;
    return 1;
}

static int fwp_jt_read(fwp_jt *c, const fwp_jr *r, const fwp_desc *d, V *out);

static int fwp_jt_expected_one_of(fwp_jt *c, const fwp_desc *d, const fwp_jr *r) {
    fwp_buf w = {0};
    buf_puts(&w, "one of ");
    for (int i = 0; i < d->n; i++) {
        if (i) buf_puts(&w, ", ");
        buf_putc(&w, '"');
        buf_puts(&w, d->names[i]);
        buf_putc(&w, '"');
    }
    fwp_jt_expected(c, w.d, r);
    free(w.d);
    return 0;
}

static int fwp_jt_ctor(const fwp_desc *d, const fwp_jr *s) {
    for (int i = 0; i < d->n; i++)
        if (strlen(d->names[i]) == s->len && memcmp(d->names[i], s->s, s->len) == 0) return i;
    return -1;
}

/* the fields of a tuple (or of a constructor with several) from an array */
static int fwp_jt_tuple(fwp_jt *c, const fwp_jr *r, int n, const fwp_desc *const *ds, V *fs) {
    char what[64];
    snprintf(what, sizeof what, "an array of %d elements", n);
    if (r->t != 4) return fwp_jt_expected(c, what, r);
    if (r->n != (size_t)n) {
        char t[128];
        buf_put(&c->err, c->path.d, c->path.len);
        snprintf(t, sizeof t, ": expected %s, got %zu", what, r->n);
        buf_puts(&c->err, t);
        return 0;
    }
    for (int i = 0; i < n; i++) {
        size_t len = c->path.len;
        fwp_jt_push_index(c, (size_t)i);
        if (!fwp_jt_read(c, &r->items[i], ds[i], &fs[i])) return 0;
        fwp_jt_pop(c, len);
    }
    return 1;
}

static int fwp_jt_read(fwp_jt *c, const fwp_jr *r, const fwp_desc *d, V *out) {
    switch (d->kind) {
    case K_I8: return fwp_jt_int(c, r, K_I8, "I8", out);
    case K_I16: return fwp_jt_int(c, r, K_I16, "I16", out);
    case K_I32: return fwp_jt_int(c, r, K_I32, "I32", out);
    case K_I64: return fwp_jt_int(c, r, K_I64, d->name, out);
    case K_I128: return fwp_jt_int(c, r, K_I128, "I128", out);
    case K_U8: return fwp_jt_int(c, r, K_U8, "U8", out);
    case K_U16: return fwp_jt_int(c, r, K_U16, "U16", out);
    case K_U32: return fwp_jt_int(c, r, K_U32, "U32", out);
    case K_U64: return fwp_jt_int(c, r, K_U64, d->name, out);
    case K_U128: return fwp_jt_int(c, r, K_U128, "U128", out);
    case K_TINT: case K_TRIT: {
        V x;
        fwp_buf saved = c->err;
        c->err = (fwp_buf){0};
        int ok = fwp_jt_int(c, r, K_I128, "I128", &x);
        free(c->err.d);
        c->err = saved;
        if (!ok) return fwp_jt_expected(c, "an integer", r);
        i128 v = fwp_i128(x);
        int w = d->kind == K_TRIT ? 1 : (d->width > 40 ? 40 : d->width);
        i128 max = 1;
        for (int i = 0; i < w; i++) max *= 3;
        max = (max - 1) / 2;
        if (v > max || v < -max) {
            char ty[32];
            if (d->kind == K_TRIT) snprintf(ty, sizeof ty, "Trit");
            else snprintf(ty, sizeof ty, "TInt[%d]", d->width);
            return fwp_jt_range(c, r, ty);
        }
        *out = (V)(int64_t)v;
        return 1;
    }
    case K_F32: case K_F64: {
        char *t = fwp_jt_floattext(c, r);
        if (!t) return 0;
        *out = d->kind == K_F32 ? fwp_from_f32(strtof(t, 0)) : fwp_from_f64(strtod(t, 0));
        free(t);
        return 1;
    }
    case K_STR:
        if (r->t != 3) return fwp_jt_expected(c, "a string", r);
        *out = fwp_str_new(r->s, r->len);
        return 1;
    case K_BYTES:
        if (r->t != 3 || !fwp_jt_unb64(r->s, r->len, out)) return fwp_jt_expected(c, "a base64 string", r);
        return 1;
    case K_LIST: case K_ARRAY: case K_SET: {
        if (r->t != 4) return fwp_jt_expected(c, "an array", r);
        V *items = (V *)fwp_alloc((r->n + 1) * sizeof(V));
        for (size_t i = 0; i < r->n; i++) {
            size_t len = c->path.len;
            fwp_jt_push_index(c, i);
            if (!fwp_jt_read(c, &r->items[i], d->elem, &items[i])) return 0;
            fwp_jt_pop(c, len);
        }
        if (d->kind == K_SET) {
            V m = FWP_EMPTY_MAP;
            for (size_t i = 0; i < r->n; i++) m = fwp_p_map_insert(items[i], 0, m, d->elem);
            *out = m;
            return 1;
        }
        V l = fwp_list_from(items, r->n);
        *out = d->kind == K_ARRAY ? fwp_p_array_from_list(l) : l;
        return 1;
    }
    case K_MAP: {
        V m = FWP_EMPTY_MAP;
        if (d->elem->kind == K_STR) {
            if (r->t != 5) return fwp_jt_expected(c, "an object", r);
            for (size_t i = 0; i < r->n; i++) {
                size_t len = c->path.len;
                fwp_jt_push_key(c, r->keys[i], r->klens[i]);
                V v;
                if (!fwp_jt_read(c, &r->items[i], d->elem2, &v)) return 0;
                fwp_jt_pop(c, len);
                m = fwp_p_map_insert(fwp_str_new(r->keys[i], r->klens[i]), v, m, d->elem);
            }
        } else {
            if (r->t != 4) return fwp_jt_expected(c, "an array of [key, value] pairs", r);
            for (size_t i = 0; i < r->n; i++) {
                size_t len = c->path.len;
                fwp_jt_push_index(c, i);
                const fwp_jr *kv = &r->items[i];
                if (kv->t != 4 || kv->n != 2) return fwp_jt_expected(c, "a [key, value] pair", kv);
                const fwp_desc *ds[2] = {d->elem, d->elem2};
                V p[2];
                if (!fwp_jt_tuple(c, kv, 2, ds, p)) return 0;
                fwp_jt_pop(c, len);
                m = fwp_p_map_insert(p[0], p[1], m, d->elem);
            }
        }
        *out = m;
        return 1;
    }
    case K_RECORD: {
        if (d->name && d->width == FWP_REC_DURATION) {
            int64_t ns = 0;
            int ok = 0;
            if (r->t == 3) ok = fwp_jt_duration(r->s, r->len, &ns);
            else if (r->t == 2) {
                int neg;
                u128 mag;
                if (fwp_jt_exact(r->s, r->len, &neg, &mag) == 1 && (neg ? mag <= (u128)INT64_MAX + 1 : mag <= (u128)INT64_MAX)) {
                    ns = neg ? (int64_t)((uint64_t)0 - (uint64_t)mag) : (int64_t)(uint64_t)mag;
                    ok = 1;
                }
            }
            if (!ok) return fwp_jt_expected(c, "a duration", r);
            V f = (V)ns;
            *out = fwp_record(1, &f);
            return 1;
        }
        if (d->n == 0) {
            if (r->t == 5 || r->t == 0 || (r->t == 4 && r->n == 0)) { *out = 0; return 1; }
            return fwp_jt_expected(c, "{}", r);
        }
        V *fs = (V *)fwp_alloc((size_t)d->n * sizeof(V));
        if (fwp_jt_is_tuple(d)) {
            if (!fwp_jt_tuple(c, r, d->n, d->fields, fs)) return 0;
        } else {
            if (r->t != 5) return fwp_jt_expected(c, "an object", r);
            /* in declaration order, so that errors come in that order */
            for (int k = 0; k < d->n; k++) {
                int i = d->order ? d->order[k] : k;
                size_t len = c->path.len;
                const char *jn = d->jnames ? d->jnames[i] : d->names[i];
                fwp_jt_push_key(c, jn, strlen(jn));
                const fwp_jr *x = fwp_jt_member(r, jn);
                if (!x) {
                    if (!fwp_jt_is_option(d->fields[i])) return fwp_jt_missing(c);
                    fs[i] = FWP_NONE;
                } else if (!fwp_jt_read(c, x, d->fields[i], &fs[i])) {
                    return 0;
                }
                fwp_jt_pop(c, len);
            }
        }
        *out = fwp_record((uint32_t)d->n, fs);
        return 1;
    }
    case K_ADT: {
        if (d->width == FWP_ADT_BOOL) {
            if (r->t == 1) { *out = r->b ? FWP_TRUE : FWP_FALSE; return 1; }
            if (r->t == 3 && r->len == 4 && !memcmp(r->s, "true", 4)) { *out = FWP_TRUE; return 1; }
            if (r->t == 3 && r->len == 5 && !memcmp(r->s, "false", 5)) { *out = FWP_FALSE; return 1; }
            return fwp_jt_expected(c, "true or false", r);
        }
        if (d->width == FWP_ADT_JSON) { *out = fwp_jr_to_json(r); return 1; }
        if (d->width == FWP_ADT_OPTION) {
            if (r->t == 0) { *out = FWP_NONE; return 1; }
            const fwp_desc *inner = d->vfields[1][0];
            V x;
            if (fwp_jt_is_option(inner)) {
                if (r->t != 4 || r->n != 1) return fwp_jt_expected(c, "null or a one-element array", r);
                size_t len = c->path.len;
                fwp_jt_push_index(c, 0);
                if (!fwp_jt_read(c, &r->items[0], inner, &x)) return 0;
                fwp_jt_pop(c, len);
            } else if (!fwp_jt_read(c, r, inner, &x)) {
                return 0;
            }
            *out = fwp_some(x);
            return 1;
        }
        if (fwp_jt_is_enum(d)) {
            int t = r->t == 3 ? fwp_jt_ctor(d, r) : -1;
            if (t < 0) return fwp_jt_expected_one_of(c, d, r);
            *out = (V)t;
            return 1;
        }
        if (r->t == 3) {
            int t = fwp_jt_ctor(d, r);
            if (t >= 0 && d->arity[t] == 0) { *out = (V)t; return 1; }
        }
        if (r->t != 5) return fwp_jt_expected(c, "an object with a \"type\"", r);
        size_t len = c->path.len;
        fwp_jt_push_key(c, "type", 4);
        const fwp_jr *ty = fwp_jt_member(r, "type");
        if (!ty) return fwp_jt_missing(c);
        int tag = ty->t == 3 ? fwp_jt_ctor(d, ty) : -1;
        if (tag < 0) return fwp_jt_expected_one_of(c, d, ty);
        fwp_jt_pop(c, len);
        int n = d->arity[tag];
        if (n == 0) { *out = (V)tag; return 1; }
        fwp_jt_push_key(c, "value", 5);
        const fwp_jr *val = fwp_jt_member(r, "value");
        if (!val) return fwp_jt_missing(c);
        V *fs = (V *)fwp_alloc((size_t)n * sizeof(V));
        if (n == 1) {
            if (!fwp_jt_read(c, val, d->vfields[tag][0], &fs[0])) return 0;
        } else if (!fwp_jt_tuple(c, val, n, d->vfields[tag], fs)) {
            return 0;
        }
        fwp_jt_pop(c, len);
        *out = fwp_data((uint32_t)tag, (uint32_t)n, fs);
        return 1;
    }
    default:
        buf_put(&c->err, c->path.d, c->path.len);
        buf_puts(&c->err, ": values of this type cannot be decoded");
        return 0;
    }
}

static V fwp_p_json_read(V text, const fwp_desc *d) {
    fwp_jp j;
    fwp_jr r;
    if (!fwp_jparse_raw(text, &j, &r)) {
        V e = fwp_cstr(j.err);
        return fwp_data(1, 1, &e);
    }
    fwp_jt c = {{0}, {0}};
    buf_puts(&c.path, "$");
    V v;
    int ok = fwp_jt_read(&c, &r, d, &v);
    free(c.path.d);
    if (ok) return fwp_data(0, 1, &v);
    V e = buf_to_str(&c.err);
    return fwp_data(1, 1, &e);
}
