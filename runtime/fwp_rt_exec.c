/* Standalone function executables (mirrors src/exec.rs, src/textio.rs and
 * the decoding half of src/proto.rs). */

/* ------------------------------------------------------------- text parse */

typedef struct { const char *s; size_t n, i; } fwp_tp;

static void tp_ws(fwp_tp *p) {
    while (p->i < p->n && (p->s[p->i] == ' ' || p->s[p->i] == '\t' || p->s[p->i] == '\n' || p->s[p->i] == '\r')) p->i++;
}

static int tp_eat(fwp_tp *p, const char *lit) {
    tp_ws(p);
    size_t l = strlen(lit);
    if (p->n - p->i >= l && memcmp(p->s + p->i, lit, l) == 0) { p->i += l; return 1; }
    return 0;
}

static int tp_is_delim(char c) {
    return c == ' ' || c == '\t' || c == '\n' || c == '\r' || c == ',' || c == ')' || c == ']' ||
           c == '}' || c == '(' || c == ':';
}

/* token into buf (NUL-terminated); returns length */
static size_t tp_token(fwp_tp *p, char *buf, size_t cap) {
    tp_ws(p);
    size_t st = p->i;
    while (p->i < p->n && !tp_is_delim(p->s[p->i])) p->i++;
    size_t l = p->i - st;
    if (l >= cap) l = cap - 1;
    memcpy(buf, p->s + st, l);
    buf[l] = 0;
    return p->i - st;
}

static size_t tp_ident(fwp_tp *p, char *buf, size_t cap) {
    tp_ws(p);
    size_t st = p->i;
    while (p->i < p->n) {
        char c = p->s[p->i];
        if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '_' || c == '-' || c == '.')
            p->i++;
        else
            break;
    }
    size_t l = p->i - st;
    if (l >= cap) l = cap - 1;
    memcpy(buf, p->s + st, l);
    buf[l] = 0;
    return l;
}

static int tp_quoted(fwp_tp *p, V *out) {
    tp_ws(p);
    if (p->i >= p->n || p->s[p->i] != '"') return 0;
    p->i++;
    fwp_buf b = {0};
    for (;;) {
        if (p->i >= p->n) { free(b.d); return 0; }
        char c = p->s[p->i++];
        if (c == '"') break;
        if (c != '\\') { buf_putc(&b, c); continue; }
        if (p->i >= p->n) { free(b.d); return 0; }
        char e = p->s[p->i++];
        switch (e) {
        case 'n': buf_putc(&b, '\n'); break;
        case 't': buf_putc(&b, '\t'); break;
        case 'r': buf_putc(&b, '\r'); break;
        case '0': buf_putc(&b, 0); break;
        case '"': buf_putc(&b, '"'); break;
        case '\\': buf_putc(&b, '\\'); break;
        case 'u': {
            if (p->i >= p->n || p->s[p->i] != '{') { free(b.d); return 0; }
            p->i++;
            uint32_t cp = 0;
            int digits = 0;
            while (p->i < p->n && isxdigit((unsigned char)p->s[p->i])) {
                char h = p->s[p->i++];
                cp = cp * 16 + (uint32_t)(h <= '9' ? h - '0' : (h | 32) - 'a' + 10);
                digits++;
            }
            if (!digits || p->i >= p->n || p->s[p->i] != '}' || cp > 0x10FFFF || (cp >= 0xD800 && cp <= 0xDFFF)) {
                free(b.d);
                return 0;
            }
            p->i++;
            fwp_utf8_put(&b, cp);
            break;
        }
        default: free(b.d); return 0;
        }
    }
    if (!fwp_valid_utf8((const unsigned char *)(b.d ? b.d : ""), b.len)) { free(b.d); return 0; }
    *out = buf_to_str(&b);
    return 1;
}

static int tp_value(fwp_tp *p, const fwp_desc *d, int top, V *out);

static int tp_atom(fwp_tp *p, const fwp_desc *d, V *out) {
    tp_ws(p);
    int tuple_like = d->kind == K_RECORD && !d->name && (d->n == 0 || d->width);
    if (p->i < p->n && p->s[p->i] == '(' && !tuple_like) {
        p->i++;
        if (!tp_value(p, d, 0, out)) return 0;
        return tp_eat(p, ")");
    }
    return tp_value(p, d, 0, out);
}

static int tp_record_body(fwp_tp *p, const fwp_desc *d, V *out) {
    V *vals = (V *)fwp_alloc((size_t)(d->n + 1) * sizeof(V));
    char *have = (char *)fwp_alloc_leaf((size_t)d->n + 1);
    memset(have, 0, (size_t)d->n + 1);
    if (!tp_eat(p, "{")) return 0;
    if (!tp_eat(p, "}")) {
        for (;;) {
            char name[256];
            tp_ident(p, name, sizeof name);
            int idx = -1;
            for (int i = 0; i < d->n; i++) if (strcmp(d->names[i], name) == 0) idx = i;
            if (idx < 0 || !tp_eat(p, "=")) return 0;
            if (!tp_value(p, d->fields[idx], 0, &vals[idx])) return 0;
            have[idx] = 1;
            if (tp_eat(p, "}")) break;
            if (!tp_eat(p, ",")) return 0;
        }
    }
    for (int i = 0; i < d->n; i++) if (!have[i]) return 0;
    *out = fwp_record((uint32_t)d->n, vals);
    return 1;
}

static int tp_int(fwp_tp *p, const fwp_desc *d, V *out) {
    char t[128];
    size_t l = tp_token(p, t, sizeof t);
    if (l >= sizeof t) return 0;
    V s = fwp_cstr(t);
    V r = fwp_p_parse_int(s, d->kind, d->width);
    if (r == FWP_NONE) return 0;
    *out = OBJ(r)->f[0];
    return 1;
}

static int tp_float(fwp_tp *p, const fwp_desc *d, V *out) {
    char t[128];
    size_t l = tp_token(p, t, sizeof t);
    if (l >= sizeof t) return 0;
    double x;
    if (strcmp(t, "inf") == 0) x = INFINITY;
    else if (strcmp(t, "-inf") == 0) x = -INFINITY;
    else if (strcmp(t, "NaN") == 0) x = NAN;
    else if (fwp_valid_float(t, l)) {
        if (d->kind == K_F32) { *out = fwp_from_f32(strtof(t, 0)); return 1; }
        x = strtod(t, 0);
    } else return 0;
    *out = fwp_float_of(d->kind, x);
    return 1;
}

typedef int (*tp_item_fn)(fwp_tp *p, void *ctx);

static int tp_list_of(fwp_tp *p, const char *open, const char *close, tp_item_fn item, void *ctx) {
    if (!tp_eat(p, open)) return 0;
    if (tp_eat(p, close)) return 1;
    for (;;) {
        if (!item(p, ctx)) return 0;
        if (tp_eat(p, close)) return 1;
        if (!tp_eat(p, ",")) return 0;
    }
}

typedef struct { const fwp_desc *d, *d2; V *items; size_t n, cap; int is_set; } tp_coll;

static void tp_push(tp_coll *c, V v) {
    if (c->n == c->cap) {
        size_t old = c->cap;
        c->cap = c->cap ? c->cap * 2 : 8;
        c->items = (V *)fwp_mem_realloc(c->items, old * sizeof(V), c->cap * sizeof(V));
    }
    c->items[c->n++] = v;
}

static int tp_elem_item(fwp_tp *p, void *ctx) {
    tp_coll *c = (tp_coll *)ctx;
    V v;
    if (!tp_value(p, c->d, 0, &v)) return 0;
    tp_push(c, v);
    return 1;
}

static int tp_byte_item(fwp_tp *p, void *ctx) {
    static const fwp_desc u8d = {K_U8, "U8"};
    tp_coll *c = (tp_coll *)ctx;
    V v;
    if (!tp_int(p, &u8d, &v)) return 0;
    tp_push(c, v);
    return 1;
}

static int tp_kv_item(fwp_tp *p, void *ctx) {
    tp_coll *c = (tp_coll *)ctx;
    V k, v = 0;
    if (!tp_value(p, c->d, 0, &k)) return 0;
    if (!c->is_set) {
        if (!tp_eat(p, ":")) return 0;
        if (!tp_value(p, c->d2, 0, &v)) return 0;
    }
    tp_push(c, k);
    tp_push(c, v);
    return 1;
}

static int tp_value(fwp_tp *p, const fwp_desc *d, int top, V *out) {
    /* a top-level string is the text as it is, spaces included */
    if (!(top && d->kind == K_STR)) tp_ws(p);
    switch (d->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64: case K_I128:
    case K_U8: case K_U16: case K_U32: case K_U64: case K_U128:
        return tp_int(p, d, out);
    case K_F32: case K_F64: return tp_float(p, d, out);
    case K_STR:
        if (top) {
            if (!fwp_valid_utf8((const unsigned char *)p->s + p->i, p->n - p->i)) return 0;
            *out = fwp_str_new(p->s + p->i, p->n - p->i);
            p->i = p->n;
            return 1;
        }
        return tp_quoted(p, out);
    case K_BYTES: {
        tp_coll c = {0};
        if (!tp_eat(p, "bytes") || !tp_list_of(p, "[", "]", tp_byte_item, &c)) { fwp_mem_free(c.items); return 0; }
        fwp_buf b = {0};
        for (size_t i = 0; i < c.n; i++) buf_putc(&b, (char)(uint8_t)c.items[i]);
        fwp_mem_free(c.items);
        *out = buf_to_str(&b);
        return 1;
    }
    case K_TINT: {
        char t[256];
        size_t l = tp_token(p, t, sizeof t);
        if (l < 2 || t[0] != '0' || t[1] != 't' || l - 2 > (size_t)d->width) return 0;
        int64_t v = 0;
        for (size_t i = 2; i < l; i++) {
            if (t[i] == '+') v = v * 3 + 1;
            else if (t[i] == '-') v = v * 3 - 1;
            else if (t[i] == '0') v = v * 3;
            else return 0;
        }
        *out = (V)v;
        return 1;
    }
    case K_TRIT: {
        char t[16];
        tp_token(p, t, sizeof t);
        if (strcmp(t, "+1") == 0 || strcmp(t, "1") == 0) { *out = 1; return 1; }
        if (strcmp(t, "0") == 0) { *out = 0; return 1; }
        if (strcmp(t, "-1") == 0) { *out = (V)(int64_t)-1; return 1; }
        return 0;
    }
    case K_LIST: case K_ARRAY: {
        tp_coll c = {d->elem};
        if (d->kind == K_ARRAY && !tp_eat(p, "array")) return 0;
        if (!tp_list_of(p, "[", "]", tp_elem_item, &c)) { fwp_mem_free(c.items); return 0; }
        V l = fwp_list_from(c.items, c.n);
        fwp_mem_free(c.items);
        *out = d->kind == K_ARRAY ? fwp_p_array_from_list(l) : l;
        return 1;
    }
    case K_MAP: case K_SET: {
        tp_coll c = {d->elem, d->elem2};
        c.is_set = d->kind == K_SET;
        if (!tp_eat(p, c.is_set ? "set" : "map")) return 0;
        if (!tp_list_of(p, "{", "}", tp_kv_item, &c)) { fwp_mem_free(c.items); return 0; }
        V m = FWP_EMPTY_MAP;
        for (size_t i = 0; i < c.n; i += 2) m = fwp_p_map_insert(c.items[i], c.items[i + 1], m, d->elem);
        fwp_mem_free(c.items);
        *out = m;
        return 1;
    }
    case K_RECORD:
        if (d->name && strcmp(d->name, "Duration") == 0) {
            char t[128];
            size_t l = tp_token(p, t, sizeof t);
            static const struct { const char *u; int64_t k; } units[] = {
                {"ns", 1}, {"us", 1000}, {"ms", 1000000}, {"min", 60000000000LL},
                {"s", 1000000000LL}, {"h", 3600000000000LL}};
            for (int u = 0; u < 6; u++) {
                size_t ul = strlen(units[u].u);
                if (l > ul && strcmp(t + l - ul, units[u].u) == 0) {
                    char num[128];
                    memcpy(num, t, l - ul);
                    num[l - ul] = 0;
                    if (fwp_valid_int(num, l - ul)) {
                        /* the count and the nanoseconds must fit in I64 */
                        size_t i = num[0] == '+' || num[0] == '-' ? 1 : 0;
                        i128 x = 0;
                        for (; num[i]; i++) {
                            x = x * 10 + (num[i] - '0');
                            if (x > (i128)INT64_MAX + 1) return 0;
                        }
                        if (num[0] == '-') x = -x;
                        if (x > INT64_MAX) return 0;
                        x *= units[u].k;
                        if (x > INT64_MAX || x < INT64_MIN) return 0;
                        V f[1] = {(V)(int64_t)x};
                        *out = fwp_record(1, f);
                        return 1;
                    }
                }
            }
            return 0;
        }
        if (d->n == 0 && !d->name) {
            if (!tp_eat(p, "(") || !tp_eat(p, ")")) return 0;
            *out = 0;
            return 1;
        }
        if (d->width && !d->name) {
            V *vals = (V *)fwp_alloc((size_t)d->n * sizeof(V));
            if (!tp_eat(p, "(")) return 0;
            for (int i = 0; i < d->n; i++) {
                if (i > 0 && !tp_eat(p, ",")) return 0;
                if (!tp_value(p, d->fields[i], 0, &vals[i])) return 0;
            }
            if (!tp_eat(p, ")")) return 0;
            *out = fwp_record((uint32_t)d->n, vals);
            return 1;
        }
        if (d->name) {
            tp_ws(p);
            size_t l = strlen(d->name);
            if (p->n - p->i >= l && memcmp(p->s + p->i, d->name, l) == 0) p->i += l;
        }
        return tp_record_body(p, d, out);
    case K_ADT: {
        char name[256];
        tp_ident(p, name, sizeof name);
        int tag = -1;
        for (int i = 0; i < d->n; i++) if (strcmp(d->names[i], name) == 0) tag = i;
        if (tag < 0 && top && d->name && strcmp(d->name, "Bool") == 0) {
            if (strcmp(name, "true") == 0) tag = 1;
            if (strcmp(name, "false") == 0) tag = 0;
        }
        if (tag < 0) return 0;
        int n = d->arity[tag];
        V *fs = (V *)fwp_alloc((size_t)(n + 1) * sizeof(V));
        for (int i = 0; i < n; i++)
            if (!tp_atom(p, d->vfields[tag][i], &fs[i])) return 0;
        *out = fwp_data((uint32_t)tag, (uint32_t)n, fs);
        return 1;
    }
    default: return 0;
    }
}

static int fwp_parse_text(const char *s, size_t n, const fwp_desc *d, V *out) {
    fwp_tp p = {s, n, 0};
    if (!tp_value(&p, d, 1, out)) return 0;
    tp_ws(&p);
    return p.i == p.n;
}

/* ---------------------------------------------------------------- decode */

typedef struct { const unsigned char *d; size_t n, i; } fwp_rd;

static int rd_take(fwp_rd *r, size_t k, const unsigned char **out) {
    if (k > r->n - r->i) return 0;
    *out = r->d + r->i;
    r->i += k;
    return 1;
}

static int rd_leb(fwp_rd *r, uint64_t *x) {
    *x = 0;
    for (int shift = 0; shift < 64; shift += 7) {
        const unsigned char *b;
        if (!rd_take(r, 1, &b)) return 0;
        if (shift == 63 && (b[0] & 0x7f) > 1) return 0; /* beyond 64 bits */
        *x |= (uint64_t)(b[0] & 0x7f) << shift;
        if (!(b[0] & 0x80)) return 1;
    }
    return 0;
}

static int rd_le(fwp_rd *r, int k, uint64_t *x) {
    const unsigned char *b;
    if (!rd_take(r, (size_t)k, &b)) return 0;
    *x = 0;
    for (int i = 0; i < k; i++) *x |= (uint64_t)b[i] << (8 * i);
    return 1;
}

static int fwp_decode(fwp_rd *r, const fwp_desc *d, V *out) {
    uint64_t x;
    switch (d->kind) {
    case K_I8: if (!rd_le(r, 1, &x)) return 0; *out = (V)(int64_t)(int8_t)x; return 1;
    case K_I16: if (!rd_le(r, 2, &x)) return 0; *out = (V)(int64_t)(int16_t)x; return 1;
    case K_I32: if (!rd_le(r, 4, &x)) return 0; *out = (V)(int64_t)(int32_t)x; return 1;
    case K_U8: case K_U16: case K_U32: case K_U64: case K_I64: case K_F32: case K_F64: case K_TINT: {
        int k = d->kind == K_U8 ? 1 : d->kind == K_U16 ? 2 : (d->kind == K_U32 || d->kind == K_F32) ? 4 : 8;
        if (!rd_le(r, k, &x)) return 0;
        *out = x;
        return 1;
    }
    case K_TRIT: if (!rd_le(r, 1, &x)) return 0; *out = (V)(int64_t)(int8_t)x; return 1;
    case K_I128: case K_U128: {
        uint64_t lo, hi;
        if (!rd_le(r, 8, &lo) || !rd_le(r, 8, &hi)) return 0;
        u128 v = ((u128)hi << 64) | lo;
        *out = d->kind == K_I128 ? fwp_box_i128((i128)v) : fwp_box_u128(v);
        return 1;
    }
    case K_STR: case K_BYTES: {
        const unsigned char *b;
        if (!rd_leb(r, &x) || x > r->n || !rd_take(r, (size_t)x, &b)) return 0;
        if (d->kind == K_STR && !fwp_valid_utf8(b, (size_t)x)) return 0;
        *out = fwp_str_new((const char *)b, (size_t)x);
        return 1;
    }
    case K_LIST: case K_ARRAY: {
        if (!rd_leb(r, &x) || x > r->n) return 0;
        V *items = (V *)fwp_alloc((size_t)(x + 1) * sizeof(V));
        for (uint64_t i = 0; i < x; i++) if (!fwp_decode(r, d->elem, &items[i])) return 0;
        V l = fwp_list_from(items, (size_t)x);
        *out = d->kind == K_ARRAY ? fwp_p_array_from_list(l) : l;
        return 1;
    }
    case K_MAP: case K_SET: {
        if (!rd_leb(r, &x) || x > r->n) return 0;
        V m = FWP_EMPTY_MAP;
        for (uint64_t i = 0; i < x; i++) {
            V k, v = 0;
            if (!fwp_decode(r, d->elem, &k)) return 0;
            if (d->kind == K_MAP && !fwp_decode(r, d->elem2, &v)) return 0;
            m = fwp_p_map_insert(k, v, m, d->elem);
        }
        *out = m;
        return 1;
    }
    case K_RECORD: {
        if (d->n == 0) { *out = 0; return 1; }
        V *fs = (V *)fwp_alloc((size_t)d->n * sizeof(V));
        for (int i = 0; i < d->n; i++) if (!fwp_decode(r, d->fields[i], &fs[i])) return 0;
        *out = fwp_record((uint32_t)d->n, fs);
        return 1;
    }
    case K_ADT: {
        if (!rd_leb(r, &x) || x >= (uint64_t)d->n) return 0;
        int n = d->arity[x];
        V *fs = (V *)fwp_alloc((size_t)(n + 1) * sizeof(V));
        for (int i = 0; i < n; i++) if (!fwp_decode(r, d->vfields[x][i], &fs[i])) return 0;
        *out = fwp_data((uint32_t)x, (uint32_t)n, fs);
        return 1;
    }
    default: return 0;
    }
}

/* ------------------------------------------------------------------ flags */
/* Command lines as src/cli.rs parses them: flags from the fields of an
 * options record, positional arguments, `--help` and `--version`. */

enum { FL_SWITCH, FL_SINGLE, FL_OPTIONAL, FL_REPEATED };

typedef struct {
    const char *name;      /* the field, which is the long flag */
    int shrt;              /* the short flag, or 0 */
    int kind;
    int index;             /* the field's position in the record */
    const fwp_desc *value; /* one value on the command line */
    const char *value_name;
    const fwp_desc *field; /* the field */
    const char *def;       /* canonical text of the default, or 0 */
    const char *left;      /* help: "  -v, --verbose" */
    const char *pad;       /* help: spaces up to the description */
    const char *doc;
    const char *env;       /* the environment variable of the value, or 0 */
    const char *post;      /* help notes after the default ("requires --x"), or 0 */
    const int *conflicts;  /* flags that cannot be given with it (-1 ends), or 0 */
    const int *requires;   /* flags that must be given with it (-1 ends), or 0 */
} fwp_flag;

static V fwp_strf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
static V fwp_strf(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int n = vsnprintf(0, 0, fmt, ap);
    va_end(ap);
    char *buf = (char *)fwp_alloc_leaf((size_t)n + 1);
    va_start(ap, fmt);
    vsnprintf(buf, (size_t)n + 1, fmt, ap);
    va_end(ap);
    return fwp_str_new(buf, (size_t)n);
}

/* An enumeration: constructors without fields (not Bool). Its values are
 * written as constructor names in any case, in kebab-case or not. */
static int fwp_is_enum(const fwp_desc *d) {
    if (d->kind != K_ADT || d->n == 0 || (d->name && strcmp(d->name, "Bool") == 0)) return 0;
    for (int i = 0; i < d->n; i++)
        if (d->arity[i]) return 0;
    return 1;
}

/* `JsonLines` as `json-lines` (src/cli.rs kebab) */
static void fwp_kebab(fwp_buf *b, const char *s) {
    int prev_lower = 0;
    for (; *s; s++) {
        char c = *s;
        if (c >= 'A' && c <= 'Z') {
            if (prev_lower) buf_putc(b, '-');
            buf_putc(b, (char)(c - 'A' + 'a'));
            prev_lower = 0;
        } else {
            buf_putc(b, c);
            prev_lower = (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9');
        }
    }
}

/* a name without case, `-` and `_` */
static void fwp_loose(fwp_buf *b, const char *s, size_t n) {
    b->len = 0;
    for (size_t i = 0; i < n; i++) {
        char c = s[i];
        if (c == '-' || c == '_') continue;
        buf_putc(b, c >= 'A' && c <= 'Z' ? (char)(c - 'A' + 'a') : c);
    }
}

/* the values of an enumeration: "json, text, csv" */
static V fwp_choices(const fwp_desc *d) {
    fwp_buf b = {0};
    for (int i = 0; i < d->n; i++) {
        if (i) buf_puts(&b, ", ");
        fwp_kebab(&b, d->names[i]);
    }
    return buf_to_str(&b);
}

/* A value on the command line (src/cli.rs parse_value): 1, or 0 with
 * *err the message after "option `--x`: " */
static int fwp_cli_value(const char *t, size_t n, const fwp_desc *d, const char *dname, V *out, V *err) {
    if (fwp_is_enum(d)) {
        fwp_buf a = {0}, c = {0};
        fwp_loose(&a, t, n);
        int tag = -1;
        for (int i = 0; i < d->n && tag < 0 && a.len; i++) {
            fwp_loose(&c, d->names[i], strlen(d->names[i]));
            if (c.len == a.len && memcmp(c.d, a.d, a.len) == 0) tag = i;
        }
        free(a.d);
        free(c.d);
        if (tag >= 0) { *out = (V)tag; return 1; }
        V cs = fwp_choices(d);
        *err = fwp_strf("`%.*s` is not one of %s", (int)n, t, STR(cs)->d);
        return 0;
    }
    if (fwp_parse_text(t, n, d, out)) return 1;
    *err = fwp_strf("cannot parse `%.*s` as %s", (int)n, t, dname);
    return 0;
}

/* a value shown in the help: enumerations in kebab-case */
static void fwp_show_value(fwp_buf *b, V v, const fwp_desc *d) {
    if (fwp_is_enum(d)) fwp_kebab(b, d->names[fwp_tag(v)]);
    else fwp_write(b, v, d, 0);
}

static int fwp_flag_by_name(const fwp_flag *fl, int nf, const char *n, size_t len) {
    for (int k = 0; k < nf; k++)
        if (strlen(fl[k].name) == len && memcmp(fl[k].name, n, len) == 0) return k;
    return -1;
}

static int fwp_flag_by_short(const fwp_flag *fl, int nf, int c) {
    for (int k = 0; k < nf; k++)
        if (fl[k].shrt == c) return k;
    return -1;
}

/* a flag's value: parsed into vals[k] (a reversed list for repeatable
 * flags); 0 with *err set when it does not parse */
static int fwp_flag_set(const fwp_flag *f, int k, const char *t, size_t n, V *vals, char *state, V *err) {
    V v, m;
    if (!fwp_cli_value(t, n, f->value, f->value_name, &v, &m)) {
        *err = fwp_strf("option `--%s`: %s", f->name, STR(m)->d);
        return 0;
    }
    if (f->kind == FL_REPEATED) {
        vals[k] = fwp_cons(v, state[k] ? vals[k] : 0);
    } else {
        vals[k] = v;
    }
    state[k] = 1;
    return 1;
}

static int fwp_is_number_arg(const char *a) {
    return a[0] == '-' && ((a[1] >= '0' && a[1] <= '9') || a[1] == '.');
}

/* Parse arguments (strings) with the flags `fl` (0: none). Returns 0 with
 * the values and the positional arguments, 1 for `--help`, 2 for
 * `--version`, or -1 with *err. */
static int fwp_cli_parse(const fwp_flag *fl, int nf, int special, int version, int argc, const V *argv,
                         V *vals, char *state, V *pos, int *npos, V *err) {
    int done = 0;
    *npos = 0;
    for (int k = 0; k < nf; k++) { vals[k] = 0; state[k] = 0; }
    for (int i = 0; i < argc;) {
        V av = argv[i++];
        const char *a = STR(av)->d;
        size_t alen = STR(av)->len;
        if (done || alen < 2 || a[0] != '-' || fwp_is_number_arg(a)) { pos[(*npos)++] = av; continue; }
        if (alen == 2 && a[1] == '-') { done = 1; continue; }
        if (a[1] == '-') {
            const char *body = a + 2;
            size_t blen = alen - 2;
            const char *eq = memchr(body, '=', blen);
            size_t nlen = eq ? (size_t)(eq - body) : blen;
            int k = fl ? fwp_flag_by_name(fl, nf, body, nlen) : -1;
            if (special && !eq && k < 0) {
                if (nlen == 4 && memcmp(body, "help", 4) == 0) return 1;
                if (version && nlen == 7 && memcmp(body, "version", 7) == 0) return 2;
            }
            if (!fl) { pos[(*npos)++] = av; continue; }
            if (k < 0) {
                int neg = nlen > 3 && memcmp(body, "no-", 3) == 0 ? fwp_flag_by_name(fl, nf, body + 3, nlen - 3) : -1;
                if (neg >= 0 && fl[neg].kind == FL_SWITCH && !eq) {
                    vals[neg] = FWP_FALSE;
                    state[neg] = 1;
                    continue;
                }
                *err = fwp_strf("unknown option `--%.*s`", (int)nlen, body);
                return -1;
            }
            if (fl[k].kind == FL_SWITCH) {
                const char *t = eq ? eq + 1 : "true";
                size_t tn = eq ? blen - nlen - 1 : 4;
                if (!fwp_flag_set(&fl[k], k, t, tn, vals, state, err)) return -1;
                continue;
            }
            if (eq) {
                if (!fwp_flag_set(&fl[k], k, eq + 1, blen - nlen - 1, vals, state, err)) return -1;
            } else if (i < argc) {
                V t = argv[i++];
                if (!fwp_flag_set(&fl[k], k, STR(t)->d, STR(t)->len, vals, state, err)) return -1;
            } else {
                *err = fwp_strf("option `--%.*s` needs a value", (int)nlen, body);
                return -1;
            }
            continue;
        }
        /* short flags: -v, -iv, -n 5, -n5 */
        if (special && alen == 2 && a[1] == 'h' && (!fl || fwp_flag_by_short(fl, nf, 'h') < 0)) return 1;
        if (!fl) { pos[(*npos)++] = av; continue; }
        for (size_t j = 1; j < alen;) {
            unsigned char c = (unsigned char)a[j++];
            int k = fwp_flag_by_short(fl, nf, c);
            if (k < 0) {
                /* the whole character, as Rust reports it */
                size_t st = j - 1, e = j;
                while (e < alen && ((unsigned char)a[e] & 0xC0) == 0x80) e++;
                *err = fwp_strf("unknown option `-%.*s`", (int)(e - st), a + st);
                return -1;
            }
            if (fl[k].kind == FL_SWITCH) {
                if (!fwp_flag_set(&fl[k], k, "true", 4, vals, state, err)) return -1;
                continue;
            }
            if (j < alen) {
                if (!fwp_flag_set(&fl[k], k, a + j, alen - j, vals, state, err)) return -1;
                j = alen;
            } else if (i < argc) {
                V t = argv[i++];
                if (!fwp_flag_set(&fl[k], k, STR(t)->d, STR(t)->len, vals, state, err)) return -1;
            } else {
                *err = fwp_strf("option `--%s` needs a value", fl[k].name);
                return -1;
            }
        }
    }
    return 0;
}

/* The value of a flag from its environment variable (src/cli.rs
 * env_value): 1 with *out, 0 when unset or empty, -1 with *err. */
static int fwp_flag_env(const fwp_flag *f, V *out, V *err) {
    if (!f->env) return 0;
    const char *e = getenv(f->env);
    if (!e || !*e) return 0;
    V t = fwp_str_lossy(e, strlen(e));
    const char *s = STR(t)->d;
    size_t n = STR(t)->len;
    if (f->kind == FL_SWITCH && n == 1 && (s[0] == '1' || s[0] == '0')) {
        s = s[0] == '1' ? "true" : "false";
        n = strlen(s);
    }
    V v, m;
    if (!fwp_cli_value(s, n, f->value, f->value_name, &v, &m)) {
        *err = fwp_strf("environment variable `%s`: %s", f->env, STR(m)->d);
        return -1;
    }
    if (f->kind == FL_OPTIONAL) { V x[1] = {v}; v = fwp_data(1, 1, x); }
    else if (f->kind == FL_REPEATED) v = fwp_cons(v, 0);
    *out = v;
    return 1;
}

/* The options record from parsed values, environment variables (with
 * `env`) and defaults (have_def[k]: defs[k] is the default). 0 with *err
 * for a missing required flag or a bad environment variable. */
static int fwp_cli_record(const fwp_flag *fl, int nf, int nfields, const V *vals, const char *state,
                          const V *defs, const char *have_def, int env, V *out, V *err) {
    V *fs = (V *)fwp_alloc((size_t)(nfields + 1) * sizeof(V));
    char *present = (char *)fwp_alloc_leaf((size_t)nf + 1);
    for (int k = 0; k < nf; k++) {
        const fwp_flag *f = &fl[k];
        V v;
        int e = 0;
        if (!state[k] && env && (e = fwp_flag_env(f, &v, err)) < 0) return 0;
        present[k] = state[k] || e;
        if (state[k]) {
            if (f->kind == FL_OPTIONAL) { V x[1] = {vals[k]}; v = fwp_data(1, 1, x); }
            else if (f->kind == FL_REPEATED) v = fwp_p_reverse(vals[k]);
            else v = vals[k];
        } else if (e) {
            /* from the environment */
        } else if (have_def[k]) {
            v = defs[k];
        } else if (f->kind == FL_SINGLE) {
            *err = fwp_strf("missing option `--%s`", f->name);
            return 0;
        } else {
            v = 0; /* False, None, [] */
        }
        fs[f->index] = v;
    }
    /* [conflicts: ...] and [requires: ...] (src/cli.rs check_constraints) */
    for (int k = 0; k < nf; k++) {
        if (!present[k]) continue;
        for (const int *c = fl[k].conflicts; c && *c >= 0; c++)
            if (present[*c]) {
                *err = fwp_strf("option `--%s` cannot be used with `--%s`", fl[k].name, fl[*c].name);
                return 0;
            }
        for (const int *r = fl[k].requires; r && *r >= 0; r++)
            if (!present[*r]) {
                *err = fwp_strf("option `--%s` needs `--%s`", fl[k].name, fl[*r].name);
                return 0;
            }
    }
    *out = fwp_record((uint32_t)nfields, fs);
    return 1;
}

/* help text of a default value (as src/cli.rs default_note), or 0 */
static V fwp_flag_default_note(const fwp_flag *f, V v) {
    fwp_buf b = {0};
    switch (f->kind) {
    case FL_SWITCH: if (v == FWP_FALSE) return 0; fwp_write(&b, v, f->field, 0); break;
    case FL_OPTIONAL: if (v == FWP_NONE) return 0; fwp_show_value(&b, OBJ(v)->f[0], f->value); break;
    case FL_REPEATED: if (v == 0) return 0; fwp_write(&b, v, f->field, 0); break;
    default: fwp_show_value(&b, v, f->field);
    }
    return buf_to_str(&b);
}

/* the help line of a flag, with its default note (src/cli.rs rows,
 * without the environment variable) */
static void fwp_flag_help(fwp_buf *b, const fwp_flag *f, V note) {
    fwp_buf t = {0};
    buf_puts(&t, f->doc);
    int enm = fwp_is_enum(f->value);
    if (note || f->kind == FL_REPEATED || enm || f->post) {
        if (t.len) buf_putc(&t, ' ');
        buf_putc(&t, '(');
        if (enm) {
            V cs = fwp_choices(f->value);
            buf_puts(&t, "one of: ");
            buf_put(&t, STR(cs)->d, STR(cs)->len);
            if (note || f->kind == FL_REPEATED || f->post) buf_puts(&t, "; ");
        }
        if (f->kind == FL_REPEATED) buf_puts(&t, note ? "repeatable; default: " : "repeatable");
        else if (note) buf_puts(&t, "default: ");
        if (note) buf_put(&t, STR(note)->d, STR(note)->len);
        if (f->post) {
            if (note || f->kind == FL_REPEATED) buf_puts(&t, "; ");
            buf_puts(&t, f->post);
        }
        buf_putc(&t, ')');
    }
    buf_puts(b, f->left);
    if (t.len) {
        buf_puts(b, f->pad);
        buf_put(b, t.d, t.len);
    }
    buf_putc(b, '\n');
    free(t.d);
}

/* cli.parse: the options record (every field with the default of `defs`)
 * and the positional arguments, or an error message. */
static V fwp_p_cli_parse(V defs, V args, const fwp_flag *fl, int nf, int nfields) {
    size_t n = 0;
    for (V l = args; l; l = OBJ(l)->f[1]) n++;
    V *argv = (V *)fwp_alloc((n + 1) * sizeof(V));
    n = 0;
    for (V l = args; l; l = OBJ(l)->f[1]) argv[n++] = OBJ(l)->f[0];
    V *vals = (V *)fwp_alloc((size_t)(nf + 1) * sizeof(V));
    V *dv = (V *)fwp_alloc((size_t)(nf + 1) * sizeof(V));
    char *state = (char *)fwp_alloc_leaf((size_t)nf + 1);
    char *have = (char *)fwp_alloc_leaf((size_t)nf + 1);
    V *pos = (V *)fwp_alloc((n + 1) * sizeof(V));
    int npos;
    V err = 0, rec;
    for (int k = 0; k < nf; k++) { dv[k] = OBJ(defs)->f[fl[k].index]; have[k] = 1; }
    if (fwp_cli_parse(fl, nf, 0, 0, (int)n, argv, vals, state, pos, &npos, &err) != 0 ||
        !fwp_cli_record(fl, nf, nfields, vals, state, dv, have, 0, &rec, &err)) {
        V e[1] = {err};
        return fwp_data(1, 1, e);
    }
    V t[2] = {rec, fwp_list_from(pos, (size_t)npos)};
    V ok[1] = {fwp_record(2, t)};
    return fwp_data(0, 1, ok);
}

/* cli.help: the help lines of the flags with the defaults of `defs` */
static V fwp_p_cli_help(V defs, const fwp_flag *fl, int nf) {
    fwp_buf b = {0};
    for (int k = 0; k < nf; k++) fwp_flag_help(&b, &fl[k], fwp_flag_default_note(&fl[k], OBJ(defs)->f[fl[k].index]));
    return buf_to_str(&b);
}

/* ------------------------------------------------------------------ exec */

enum { POS_REQUIRED, POS_OPTIONAL, POS_DEFAULTED, POS_VARIADIC };

/* a positional parameter (src/cli.rs Positional) */
typedef struct {
    const fwp_desc *value; /* one argument */
    const char *value_name;
    const fwp_desc *param; /* the parameter, for its default */
    int kind;
    const char *def;       /* canonical text of the default, or 0 */
} fwp_pos;

typedef struct {
    const char *name;   /* in messages: "grep", or "tools grep" */
    const char *export_name;
    const char *usage;
    const char *help;
    uint32_t fn;
    int arity;
    const fwp_desc *const *params;
    const char *const *param_names;   /* displayed parameter types */
    /* the options record */
    int has_options, record_fallback, nflags, nfields;
    const fwp_flag *flags;
    /* the positional parameters: required ones first */
    const fwp_pos *pos;
    int npos, nreq, variadic;
    int unit_last; /* the last parameter is (), given implicitly */
    /* the result: Outcome[_] (its fields), Result[_, E] (its error),
     * Option, List */
    int res_outcome, res_output, res_status;
    const fwp_desc *res_err;
    int res_option, res_list;
    const fwp_desc *out_elem;
    const unsigned char *out_header;
    size_t out_header_len;
    int last_is_list;
    const fwp_desc *in_elem;
    const char *in_type;
    const unsigned char *in_fp;
    V (*caf)(void);
} fwp_exec_spec;

static int fwp_exec_binary_out = 0;
static const char *fwp_cli_version = 0;
/* completion scripts (bash, zsh, fish) and the man page */
static const char *fwp_cli_scripts[3] = {0, 0, 0};
static const char *fwp_cli_man = 0;
static int fwp_cli_single = 0; /* a single command: it has these too */

static void fwp_emit(const fwp_exec_spec *s, V v) {
    if (fwp_exec_binary_out) {
        fwp_buf b = {0};
        fwp_encode(&b, v, s->out_elem);
        unsigned char hdr[5] = {1, (unsigned char)(b.len & 0xff), (unsigned char)((b.len >> 8) & 0xff),
                                (unsigned char)((b.len >> 16) & 0xff), (unsigned char)((b.len >> 24) & 0xff)};
        fwp_pipe_write(hdr, 5);
        if (b.len) fwp_pipe_write(b.d, b.len);
        free(b.d);
        fwp_pipe_frame_done();
    } else if (!(s->out_elem->kind == K_RECORD && s->out_elem->n == 0 && !s->out_elem->name)) {
        fwp_display_top(v, s->out_elem, stdout);
        fputc('\n', stdout);
    }
}

/* an error as a command reports it: an IoError by its message */
static void fwp_exec_error(const fwp_exec_spec *s, V v, const fwp_desc *d) {
    fwp_pipe_flush();
    fprintf(stderr, "%s: ", s->name);
    if (d->kind == K_RECORD && d->name && strcmp(d->name, "IoError") == 0 && d->n == 2) {
        V m = OBJ(v)->f[1];
        fwrite(STR(m)->d, 1, STR(m)->len, stderr);
    } else {
        fwp_display_top(v, d, stderr);
    }
    fprintf(stderr, "\n");
}

/* write a result; -1 when it is an Err (reported), else the exit status
 * of an Outcome (or 0) */
static int fwp_emit_result(const fwp_exec_spec *s, V v) {
    int status = 0;
    if (s->res_outcome) {
        int64_t st = (int64_t)(int32_t)OBJ(v)->f[s->res_status];
        status = (int)(((st % 256) + 256) % 256);
        v = OBJ(v)->f[s->res_output];
    }
    if (s->res_err) {
        if (fwp_tag(v) != 0) { fwp_exec_error(s, OBJ(v)->f[0], s->res_err); return -1; }
        v = OBJ(v)->f[0];
    }
    if (s->res_option) {
        if (v == FWP_NONE) return status;
        v = OBJ(v)->f[0];
    }
    if (s->res_list) {
        for (; v != 0; v = OBJ(v)->f[1]) fwp_emit(s, OBJ(v)->f[0]);
    } else {
        fwp_emit(s, v);
    }
    return status;
}

/* Call the function; an uncaught Error is reported and returns 0 with
 * *failed set. */
static V fwp_exec_call(const fwp_exec_spec *s, V *args, int n, int *failed) {
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = fwp_state_len;
    h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (setjmp(h.jb) == 0) {
        V r = n == 0 ? s->caf() : fwp_apply(fwp_pap(s->fn, 0, 0), (uint32_t)n, args);
        fwp_handlers = h.prev;
        fwp_tasks_finish();
        *failed = 0;
        return r;
    }
    fwp_handlers = h.prev;
    fwp_tasks_abort();
    fwp_flush();
    fwp_exec_error(s, h.value, h.desc);
    *failed = 1;
    return 0;
}

/* stdin with a small pushback buffer (for peeking at the magic bytes) */
static unsigned char fwp_in_pend[4];
static int fwp_in_npend = 0, fwp_in_ppos = 0;

static int fwp_getc(void) {
    if (fwp_in_ppos < fwp_in_npend) return fwp_in_pend[fwp_in_ppos++];
    return fgetc(stdin);
}

static int fwp_read_exact(unsigned char *buf, size_t n) {
    size_t i = 0;
    while (i < n && fwp_in_ppos < fwp_in_npend) buf[i++] = fwp_in_pend[fwp_in_ppos++];
    while (i < n) {
        size_t k = fwp_pipe_read(buf + i, n - i);
        if (!k) return 0;
        i += k;
    }
    return 1;
}

/* the longest capability or type name a header may carry (as
 * MAX_HEADER_NAME in src/proto.rs) */
#define FWP_MAX_HEADER_NAME ((uint64_t)1 << 20)

/* 1: read; 0: truncated; -1: malformed (over 64 bits) */
static int fwp_stdin_leb(uint64_t *x) {
    *x = 0;
    for (int shift = 0; shift < 64; shift += 7) {
        unsigned char b;
        if (!fwp_read_exact(&b, 1)) return 0;
        if (shift == 63 && (b & 0x7f) > 1) return -1;
        *x |= (uint64_t)(b & 0x7f) << shift;
        if (!(b & 0x80)) return 1;
    }
    return -1;
}

/* a header name length: 1, 0 (truncated) or -1 (malformed or too long) */
static int fwp_stdin_name_len(uint64_t *x) {
    int ok = fwp_stdin_leb(x);
    if (ok == 1 && *x > FWP_MAX_HEADER_NAME) return -1;
    return ok;
}

/* read a text line from stdin into a fresh string (without the newline);
 * returns 0 at end of input */
static int fwp_read_text_line(fwp_buf *b) {
    int c, any = 0;
    b->len = 0;
    while ((c = fwp_getc()) != EOF) {
        any = 1;
        if (c == '\n') break;
        buf_putc(b, (char)c);
    }
    if (!any) return 0;
    if (c == '\n' && b->len > 0 && b->d[b->len - 1] == '\r') b->len--;
    if (b->d) b->d[b->len] = 0;
    return 1;
}

static int fwp_usage_error(const fwp_exec_spec *s, V msg) {
    if (msg) fprintf(stderr, "%s: %.*s\n", s->name, (int)STR(msg)->len, STR(msg)->d);
    fprintf(stderr, "%s\n", s->usage);
    return 2;
}

static int fwp_parse_arg(const fwp_exec_spec *s, int i, V a, const fwp_desc *d, const char *dname, V *out) {
    V err;
    if (fwp_cli_value(STR(a)->d, STR(a)->len, d, dname, out, &err)) return 1;
    fprintf(stderr, "%s: argument %d: %s\n", s->name, i + 1, STR(err)->d);
    return 0;
}

/* `--completions SHELL` and `--man` as the first argument (unless the
 * flags `fl` have these names): print the script or the page. The exit
 * status, or -1 for other arguments. */
static int fwp_generated(const char *name, const fwp_flag *fl, int nf, int argc, char **argv) {
    if (argc < 1) return -1;
    const char *a = argv[0];
    if (strcmp(a, "--man") == 0 && fwp_flag_by_name(fl, nf, "man", 3) < 0) {
        fputs(fwp_cli_man, stdout);
        return 0;
    }
    if (strncmp(a, "--completions", 13) != 0 || fwp_flag_by_name(fl, nf, "completions", 11) >= 0) return -1;
    const char *shell;
    if (a[13] == '=') shell = a + 14;
    else if (a[13] != 0) return -1;
    else if (argc < 2) {
        fprintf(stderr, "%s: option `--completions` needs a value (bash, zsh or fish)\n", name);
        return 2;
    } else shell = argv[1];
    static const char *const shells[3] = {"bash", "zsh", "fish"};
    for (int i = 0; i < 3; i++)
        if (strcmp(shell, shells[i]) == 0) { fputs(fwp_cli_scripts[i], stdout); return 0; }
    V sh = fwp_str_lossy(shell, strlen(shell));
    fprintf(stderr, "%s: unknown shell `%s` (bash, zsh or fish)\n", name, STR(sh)->d);
    return 2;
}

/* The positional parameters from the arguments (src/cli.rs
 * bind_positional) into args[first..]: 0, or 2 after a usage error or an
 * argument that does not parse; *from_stdin when the last one is
 * missing. */
static int fwp_bind_positional(const fwp_exec_spec *s, V *pos, int k, V *args, int first, int *from_stdin) {
    int nfixed = s->npos - s->variadic;
    int stdin_last = s->npos > 0 && s->nreq == s->npos;
    *from_stdin = k < s->nreq;
    if ((*from_stdin && !(stdin_last && k + 1 == s->nreq)) || (!s->variadic && k > nfixed))
        return fwp_usage_error(s, 0);
    int i = 0;
    for (int j = 0; j < s->npos; j++) {
        const fwp_pos *p = &s->pos[j];
        V *slot = &args[first + j];
        switch (p->kind) {
        case POS_REQUIRED:
            if (i >= k) return 0;
            if (!fwp_parse_arg(s, i, pos[i], p->value, p->value_name, slot)) return 2;
            i++;
            break;
        case POS_OPTIONAL:
        case POS_DEFAULTED:
            if (i < k) {
                V v;
                if (!fwp_parse_arg(s, i, pos[i], p->value, p->value_name, &v)) return 2;
                if (p->kind == POS_OPTIONAL) { V x[1] = {v}; v = fwp_data(1, 1, x); }
                *slot = v;
                i++;
            } else if (p->kind == POS_OPTIONAL) {
                *slot = FWP_NONE;
            } else if (!fwp_parse_text(p->def, strlen(p->def), p->param, slot)) {
                *slot = FWP_UNIT;
            }
            break;
        default: {
            V *rest = (V *)fwp_alloc((size_t)(k + 1) * sizeof(V));
            int r = 0;
            for (; i < k; i++, r++)
                if (!fwp_parse_arg(s, i, pos[i], p->value, p->value_name, &rest[r])) return 2;
            if (r == 0 && p->def && fwp_parse_text(p->def, strlen(p->def), p->param, slot)) break;
            *slot = fwp_list_from(rest, (size_t)r);
        }
        }
    }
    return 0;
}

static int fwp_exec(const fwp_exec_spec *s, int argc, char **argv) {
    int n = s->arity;
    int na = argc - 1;
    if (fwp_cli_single) {
        int g = fwp_generated(s->name, s->flags, s->has_options ? s->nflags : 0, na, argv + 1);
        if (g >= 0) return g;
    }
    V *av = (V *)fwp_alloc((size_t)(na + 1) * sizeof(V));
    for (int i = 0; i < na; i++) av[i] = fwp_str_lossy(argv[i + 1], strlen(argv[i + 1]));
    /* flags, unless a record parameter is given as before */
    int flags_mode = s->has_options && (!s->record_fallback || (na > 0 && STR(av[0])->d[0] == '-'));
    int nf = flags_mode ? s->nflags : 0;
    V *vals = (V *)fwp_alloc((size_t)(nf + 1) * sizeof(V));
    char *state = (char *)fwp_alloc_leaf((size_t)nf + 1);
    V *pos = (V *)fwp_alloc((size_t)(na + 1) * sizeof(V));
    int k;
    V err = 0;
    int r = fwp_cli_parse(flags_mode ? s->flags : 0, nf, 1, fwp_cli_version != 0, na, av, vals, state, pos, &k, &err);
    if (r < 0) return fwp_usage_error(s, err);
    if (r == 1) { fputs(s->help, stdout); fflush(stdout); return 0; }
    if (r == 2) {
        const char *sp = strchr(s->name, ' ');
        printf("%.*s %s\n", sp ? (int)(sp - s->name) : (int)strlen(s->name), s->name, fwp_cli_version);
        fflush(stdout);
        return 0;
    }
    V *args = (V *)fwp_alloc((size_t)(n + 1) * sizeof(V));
    int first = 0;
    if (flags_mode) {
        V *defs = (V *)fwp_alloc((size_t)(nf + 1) * sizeof(V));
        char *have = (char *)fwp_alloc_leaf((size_t)nf + 1);
        for (int j = 0; j < nf; j++) {
            const fwp_flag *f = &s->flags[j];
            have[j] = f->def != 0;
            if (f->def && !fwp_parse_text(f->def, strlen(f->def), f->field, &defs[j])) have[j] = 0;
        }
        if (!fwp_cli_record(s->flags, nf, s->nfields, vals, state, defs, have, 1, &args[0], &err))
            return fwp_usage_error(s, err);
        first = 1;
    }
    int m = n - s->unit_last; /* the parameters before a final () */
    int from_stdin = 0;
    if (s->unit_last) args[n - 1] = FWP_UNIT;
    if (!flags_mode && s->record_fallback) {
        /* the record as an argument or from stdin, as before */
        if (k > 1) return fwp_usage_error(s, 0);
        if (k == 1 && !fwp_parse_arg(s, 0, pos[0], s->params[0], s->param_names[0], &args[0])) return 2;
        from_stdin = k == 0;
    } else {
        int rc = fwp_bind_positional(s, pos, k, args, first, &from_stdin);
        if (rc) return rc;
    }
    const char *outv = getenv("FWP_OUT");
    fwp_exec_binary_out = outv && strcmp(outv, "bin") == 0;
    fwp_prog_out = fwp_exec_binary_out ? stderr : stdout;
    if (fwp_exec_binary_out) {
        fwp_pipe_out_start();
        fwp_pipe_write(s->out_header, s->out_header_len);
        fwp_pipe_flush();
        fwp_pipe_out_ready();
    }
    int code = 0, failed = 0, ok = 1;
    if (!from_stdin) {
        V r = fwp_exec_call(s, args, n, &failed);
        fflush(fwp_prog_out);
        if (failed) code = 1;
        else if ((code = fwp_emit_result(s, r)) < 0) code = 1;
    } else {
        /* input records from stdin; binary input starts with the magic */
        int binary = 0;
        setvbuf(stdin, 0, _IOFBF, 1 << 20);
        fwp_in_npend = (int)fread(fwp_in_pend, 1, 4, stdin);
        fwp_in_ppos = 0;
        if (fwp_in_npend == 4 && memcmp(fwp_in_pend, "FWP1", 4) == 0) {
            binary = 1;
            fwp_in_ppos = 4;
        }
        if (binary) {
            unsigned char ver;
            uint64_t ncaps, l;
            unsigned char fp[16];
            if (!fwp_read_exact(&ver, 1)) goto bad_header;
            if ((ok = fwp_stdin_leb(&ncaps)) != 1) goto header_error;
            int uds = 0;
            for (uint64_t i = 0; i < ncaps && i < 64; i++) {
                if ((ok = fwp_stdin_name_len(&l)) != 1) goto header_error;
                unsigned char tmp[256];
                if (l == 6) {
                    if (!fwp_read_exact(tmp, 6)) goto bad_header;
                    if (memcmp(tmp, "UDS_V1", 6) == 0) uds = 1;
                    l = 0;
                }
                while (l > 0) {
                    size_t chunk = l > sizeof tmp ? sizeof tmp : (size_t)l;
                    if (!fwp_read_exact(tmp, chunk)) goto bad_header;
                    l -= chunk;
                }
            }
            if (!fwp_read_exact(fp, 16)) goto bad_header;
            if ((ok = fwp_stdin_name_len(&l)) != 1) goto header_error;
            char *tname = (char *)fwp_alloc_leaf((size_t)l + 1);
            if (l && !fwp_read_exact((unsigned char *)tname, (size_t)l)) goto bad_header;
            tname[l] = 0;
            if (ver != 1) {
                fprintf(stderr, "%s: unsupported protocol version %d\n", s->name, ver);
                return 3;
            }
            if (memcmp(fp, s->in_fp, 16) != 0) {
                fprintf(stderr, "%s: input type mismatch: expected `%s`, got `%s`\n", s->name, s->in_type, tname);
                return 3;
            }
            if (uds) fwp_pipe_in_offer();
        }
        size_t cap = 16, cnt = 0;
        V *items = s->last_is_list ? (V *)fwp_mem_alloc(cap * sizeof(V)) : 0;
        fwp_buf line = {0};
        for (;;) {
            V v;
            if (binary) {
                unsigned char hdr[5];
                if (!fwp_read_exact(hdr, 1)) break;
                if (!fwp_read_exact(hdr + 1, 4)) { fprintf(stderr, "%s: truncated frame\n", s->name); code = 3; break; }
                size_t len = (size_t)hdr[1] | ((size_t)hdr[2] << 8) | ((size_t)hdr[3] << 16) | ((size_t)hdr[4] << 24);
                unsigned char *pl = (unsigned char *)fwp_alloc_leaf(len + 1);
                if (len && !fwp_read_exact(pl, len)) { fprintf(stderr, "%s: truncated frame\n", s->name); code = 3; break; }
                if (hdr[0] == 0) break;
                if (hdr[0] == 2) {
                    if (fwp_pipe_in_switch(pl, len)) continue;
                    fprintf(stderr, "%s: bad switch frame\n", s->name);
                    code = 3;
                    break;
                }
                fwp_rd rd = {pl, len, 0};
                if (!fwp_decode(&rd, s->in_elem, &v)) { fprintf(stderr, "%s: malformed value\n", s->name); code = 3; break; }
            } else {
                if (!fwp_read_text_line(&line)) break;
                V t = fwp_str_lossy(line.d ? line.d : "", line.len);
                if (!fwp_parse_text(STR(t)->d, STR(t)->len, s->in_elem, &v)) {
                    fprintf(stderr, "%s: cannot parse input `%.*s` as %s\n", s->name, (int)STR(t)->len,
                            STR(t)->d, s->in_type);
                    code = 3;
                    break;
                }
            }
            if (s->last_is_list) {
                if (cnt == cap) { cap *= 2; items = (V *)fwp_mem_realloc(items, cap / 2 * sizeof(V), cap * sizeof(V)); }
                items[cnt++] = v;
            } else {
                args[m - 1] = v;
                V r = fwp_exec_call(s, args, n, &failed);
                fflush(fwp_prog_out);
                if (failed) { code = 1; break; }
                int st = fwp_emit_result(s, r);
                if (st < 0) { code = 1; break; }
                if (st > code) code = st;
                fwp_pipe_flush();
            }
        }
        if (s->last_is_list && code == 0) {
            args[m - 1] = fwp_list_from(items, cnt);
            V r = fwp_exec_call(s, args, n, &failed);
            fflush(fwp_prog_out);
            if (failed) code = 1;
            else if ((code = fwp_emit_result(s, r)) < 0) code = 1;
        }
        fwp_mem_free(items);
        free(line.d);
    }
    if (fwp_exec_binary_out) {
        static const unsigned char end[5] = {0, 0, 0, 0, 0};
        fwp_pipe_write(end, 5);
        fwp_pipe_out_end();
    }
    fflush(stdout);
    return code;
header_error:
    if (ok < 0) {
        fprintf(stderr, "%s: bad header\n", s->name);
        return 3;
    }
bad_header:
    fprintf(stderr, "%s: truncated header\n", s->name);
    return 3;
}

/* A multi-command program: the first argument names the command. */
static int fwp_exec_program(const char *name, const fwp_exec_spec *const *cmds, int ncmds, const char *help,
                            const char *usage, int argc, char **argv) {
    if (argc < 2) { fputs(help, stderr); return 2; }
    const char *first = argv[1];
    for (int i = 0; i < ncmds; i++)
        if (strcmp(cmds[i]->export_name, first) == 0) return fwp_exec(cmds[i], argc - 1, argv + 1);
    int g = fwp_generated(name, 0, 0, argc - 1, argv + 1);
    if (g >= 0) return g;
    if (strcmp(first, "--help") == 0 || strcmp(first, "-h") == 0) { fputs(help, stdout); return 0; }
    if (strcmp(first, "--version") == 0 && fwp_cli_version) { printf("%s %s\n", name, fwp_cli_version); return 0; }
    if (strcmp(first, "help") == 0) {
        if (argc < 3) { fputs(help, stdout); return 0; }
        for (int i = 0; i < ncmds; i++)
            if (strcmp(cmds[i]->export_name, argv[2]) == 0) { fputs(cmds[i]->help, stdout); return 0; }
        first = argv[2];
    }
    V f = fwp_str_lossy(first, strlen(first));
    fprintf(stderr, "%s: unknown command `%.*s`\n%s\n", name, (int)STR(f)->len, STR(f)->d, usage);
    return 2;
}

/* ------------------------------------------------------------------- csv */
/* As src/csv.rs: records of fields, a one-byte separator, `"` quotes. */

static V fwp_p_csv_parse_with(V sepv, V text) {
    char sep = STR(sepv)->len ? STR(sepv)->d[0] : ',';
    const char *s = STR(text)->d;
    size_t n = STR(text)->len, i = 0;
    V rows = 0, row = 0;
    fwp_buf f = {0};
    int at_start = 1, any = 0;
#define CSV_FIELD() do { row = fwp_cons(fwp_str_lossy(f.d ? f.d : "", f.len), row); f.len = 0; } while (0)
#define CSV_ROW() do { rows = fwp_cons(fwp_p_reverse(row), rows); row = 0; } while (0)
    while (i < n) {
        char c = s[i];
        if (at_start && c == '"') {
            i++;
            while (i < n) {
                if (s[i] == '"') {
                    if (i + 1 < n && s[i + 1] == '"') { buf_putc(&f, '"'); i += 2; continue; }
                    i++;
                    break;
                }
                buf_putc(&f, s[i++]);
            }
            at_start = 0;
            any = 1;
            continue;
        }
        if (c == sep) { CSV_FIELD(); at_start = 1; any = 1; i++; continue; }
        if (c == '\n' || (c == '\r' && i + 1 < n && s[i + 1] == '\n')) {
            i += c == '\r' ? 2 : 1;
            if (any) { CSV_FIELD(); CSV_ROW(); }
            f.len = 0;
            at_start = 1;
            any = 0;
            continue;
        }
        buf_putc(&f, c);
        at_start = 0;
        any = 1;
        i++;
    }
    if (any) { CSV_FIELD(); CSV_ROW(); }
#undef CSV_FIELD
#undef CSV_ROW
    free(f.d);
    return fwp_p_reverse(rows);
}

/* a header as a field name (src/csv.rs column_name) */
static V fwp_csv_column(V h) {
    const char *s = STR(h)->d;
    size_t a = 0, b = STR(h)->len;
    while (a < b && (s[a] == ' ' || s[a] == '\t' || s[a] == '\n' || s[a] == '\r')) a++;
    while (b > a && (s[b - 1] == ' ' || s[b - 1] == '\t' || s[b - 1] == '\n' || s[b - 1] == '\r')) b--;
    fwp_buf o = {0};
    for (size_t i = a; i < b; i++) {
        char c = s[i];
        buf_putc(&o, c == ' ' || c == '_' ? '-' : c >= 'A' && c <= 'Z' ? (char)(c - 'A' + 'a') : c);
    }
    return buf_to_str(&o);
}

static int fwp_is_option(const fwp_desc *d) {
    return d->kind == K_ADT && d->name && strcmp(d->name, "Option") == 0 && d->n == 2;
}

static int fwp_blank(V t) {
    for (size_t i = 0; i < STR(t)->len; i++) {
        char c = STR(t)->d[i];
        if (c != ' ' && c != '\t' && c != '\n' && c != '\r') return 0;
    }
    return 1;
}

/* csv.decode: records of the record type `d` (its fields' displayed
 * types `tnames`; `rname` for a type that is not one) */
static V fwp_p_csv_decode(V rows, const fwp_desc *d, const char *const *tnames, const char *rname) {
    V err;
    if (!rname) {
        if (!rows) { V ok[1] = {0}; return fwp_data(0, 1, ok); }
        int nf = d->n;
        V header = OBJ(rows)->f[0];
        size_t hn = fwp_list_len(header);
        V *hs = (V *)fwp_alloc((hn + 1) * sizeof(V));
        size_t k = 0;
        for (V l = header; l; l = OBJ(l)->f[1]) hs[k++] = fwp_csv_column(OBJ(l)->f[0]);
        int *cols = (int *)fwp_alloc_leaf((size_t)(nf + 1) * sizeof(int));
        for (int j = 0; j < nf; j++) {
            cols[j] = -1;
            for (size_t c = 0; c < hn && cols[j] < 0; c++)
                if (strcmp(STR(hs[c])->d, d->names[j]) == 0) cols[j] = (int)c;
            if (cols[j] < 0 && !fwp_is_option(d->fields[j])) {
                err = fwp_strf("missing column `%s`", d->names[j]);
                goto fail;
            }
        }
        V out = 0;
        int r = 1;
        for (V l = OBJ(rows)->f[1]; l; l = OBJ(l)->f[1]) {
            r++;
            V row = OBJ(l)->f[0];
            size_t rn = fwp_list_len(row);
            V *cells = (V *)fwp_alloc((rn + 1) * sizeof(V));
            k = 0;
            for (V c = row; c; c = OBJ(c)->f[1]) cells[k++] = OBJ(c)->f[0];
            V *vals = (V *)fwp_alloc((size_t)(nf + 1) * sizeof(V));
            for (int j = 0; j < nf; j++) {
                V t = cols[j] >= 0 && (size_t)cols[j] < rn ? cells[cols[j]] : fwp_cstr("");
                const fwp_desc *fd = d->fields[j];
                V m;
                int ok;
                if (fwp_is_option(fd)) {
                    if (fwp_blank(t)) { vals[j] = FWP_NONE; continue; }
                    V v;
                    ok = fwp_cli_value(STR(t)->d, STR(t)->len, fd->vfields[1][0], tnames[j], &v, &m);
                    if (ok) { V x[1] = {v}; vals[j] = fwp_data(1, 1, x); }
                } else {
                    ok = fwp_cli_value(STR(t)->d, STR(t)->len, fd, tnames[j], &vals[j], &m);
                }
                if (!ok) {
                    err = fwp_strf("row %d: column `%s`: %s", r, d->names[j], STR(m)->d);
                    goto fail;
                }
            }
            out = fwp_cons(fwp_record((uint32_t)nf, vals), out);
        }
        V ok[1] = {fwp_p_reverse(out)};
        return fwp_data(0, 1, ok);
    }
    err = fwp_strf("`%s` is not a record with named fields", rname);
fail:;
    V e[1] = {err};
    return fwp_data(1, 1, e);
}
