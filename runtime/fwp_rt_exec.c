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
    char *have = (char *)fwp_alloc((size_t)d->n + 1);
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
        c->cap = c->cap ? c->cap * 2 : 8;
        c->items = (V *)realloc(c->items, c->cap * sizeof(V));
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
    tp_ws(p);
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
        if (!tp_eat(p, "bytes") || !tp_list_of(p, "[", "]", tp_byte_item, &c)) { free(c.items); return 0; }
        fwp_buf b = {0};
        for (size_t i = 0; i < c.n; i++) buf_putc(&b, (char)(uint8_t)c.items[i]);
        free(c.items);
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
        if (!tp_list_of(p, "[", "]", tp_elem_item, &c)) { free(c.items); return 0; }
        V l = fwp_list_from(c.items, c.n);
        free(c.items);
        *out = d->kind == K_ARRAY ? fwp_p_array_from_list(l) : l;
        return 1;
    }
    case K_MAP: case K_SET: {
        tp_coll c = {d->elem, d->elem2};
        c.is_set = d->kind == K_SET;
        if (!tp_eat(p, c.is_set ? "set" : "map")) return 0;
        if (!tp_list_of(p, "{", "}", tp_kv_item, &c)) { free(c.items); return 0; }
        V m = FWP_EMPTY_MAP;
        for (size_t i = 0; i < c.n; i += 2) m = fwp_p_map_insert(c.items[i], c.items[i + 1], m, d->elem);
        free(c.items);
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
                        V f[1] = {(V)(strtoll(num, 0, 10) * units[u].k)};
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
    if (r->i + k > r->n) return 0;
    *out = r->d + r->i;
    r->i += k;
    return 1;
}

static int rd_leb(fwp_rd *r, uint64_t *x) {
    *x = 0;
    for (int shift = 0; shift < 64; shift += 7) {
        const unsigned char *b;
        if (!rd_take(r, 1, &b)) return 0;
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
        if (!rd_leb(r, &x) || !rd_take(r, (size_t)x, &b)) return 0;
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

/* ------------------------------------------------------------------ exec */

typedef struct {
    const char *name;
    const char *usage;
    uint32_t fn;
    int arity;
    const fwp_desc *const *params;
    const char *const *param_names;   /* displayed parameter types */
    const fwp_desc *result;
    int result_is_list;
    const fwp_desc *out_elem;
    const unsigned char *out_header;
    size_t out_header_len;
    int last_is_list;
    const fwp_desc *in_elem;
    const char *in_type;
    const unsigned char *in_fp;
} fwp_exec_spec;

static int fwp_exec_binary_out = 0;

static void fwp_emit(const fwp_exec_spec *s, V v) {
    if (fwp_exec_binary_out) {
        fwp_buf b = {0};
        fwp_encode(&b, v, s->out_elem);
        unsigned char hdr[5] = {1, (unsigned char)(b.len & 0xff), (unsigned char)((b.len >> 8) & 0xff),
                                (unsigned char)((b.len >> 16) & 0xff), (unsigned char)((b.len >> 24) & 0xff)};
        fwrite(hdr, 1, 5, stdout);
        if (b.len) fwrite(b.d, 1, b.len, stdout);
        free(b.d);
    } else if (!(s->out_elem->kind == K_RECORD && s->out_elem->n == 0 && !s->out_elem->name)) {
        fwp_display_top(v, s->out_elem, stdout);
        fputc('\n', stdout);
    }
}

static void fwp_emit_result(const fwp_exec_spec *s, V v) {
    if (s->result_is_list) {
        for (; v != 0; v = OBJ(v)->f[1]) fwp_emit(s, OBJ(v)->f[0]);
    } else {
        fwp_emit(s, v);
    }
}

static V caf_exec_entry(void);

/* Call the function; an uncaught Error is reported and returns 0 with
 * *failed set. */
static V fwp_exec_call(const fwp_exec_spec *s, V *args, int n, int *failed) {
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = fwp_state_len;
    fwp_handlers = &h;
    if (setjmp(h.jb) == 0) {
        V r = n == 0 ? caf_exec_entry() : fwp_apply(fwp_pap(s->fn, 0, 0), (uint32_t)n, args);
        fwp_handlers = h.prev;
        *failed = 0;
        return r;
    }
    fwp_handlers = h.prev;
    fwp_flush();
    fprintf(stderr, "error: ");
    fwp_display_top(h.value, h.desc, stderr);
    fprintf(stderr, "\n");
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
    return i == n || fread(buf + i, 1, n - i, stdin) == n - i;
}

static int fwp_stdin_leb(uint64_t *x) {
    *x = 0;
    for (int shift = 0; shift < 64; shift += 7) {
        unsigned char b;
        if (!fwp_read_exact(&b, 1)) return 0;
        *x |= (uint64_t)(b & 0x7f) << shift;
        if (!(b & 0x80)) return 1;
    }
    return 0;
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

static int fwp_exec(const fwp_exec_spec *s, int argc, char **argv) {
    int k = argc - 1;
    int n = s->arity;
    if (k > n || k + 1 < n) {
        fprintf(stderr, "%s\n", s->usage);
        return 2;
    }
    V *args = (V *)fwp_alloc((size_t)(n + 1) * sizeof(V));
    for (int i = 0; i < k; i++) {
        if (!fwp_parse_text(argv[i + 1], strlen(argv[i + 1]), s->params[i], &args[i])) {
            fprintf(stderr, "%s: argument %d: cannot parse `%s` as %s\n", s->name, i + 1, argv[i + 1],
                    s->param_names[i]);
            return 2;
        }
    }
    const char *outv = getenv("FWP_OUT");
    fwp_exec_binary_out = outv && strcmp(outv, "bin") == 0;
    fwp_prog_out = fwp_exec_binary_out ? stderr : stdout;
    if (fwp_exec_binary_out) fwrite(s->out_header, 1, s->out_header_len, stdout);
    int code = 0, failed = 0;
    if (k == n) {
        V r = fwp_exec_call(s, args, n, &failed);
        fflush(fwp_prog_out);
        if (failed) code = 1;
        else fwp_emit_result(s, r);
    } else {
        /* input records from stdin; binary input starts with the magic */
        int binary = 0;
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
            if (!fwp_read_exact(&ver, 1) || !fwp_stdin_leb(&ncaps)) goto bad_header;
            for (uint64_t i = 0; i < ncaps && i < 64; i++) {
                if (!fwp_stdin_leb(&l)) goto bad_header;
                unsigned char tmp[256];
                while (l > 0) {
                    size_t chunk = l > sizeof tmp ? sizeof tmp : (size_t)l;
                    if (!fwp_read_exact(tmp, chunk)) goto bad_header;
                    l -= chunk;
                }
            }
            if (!fwp_read_exact(fp, 16) || !fwp_stdin_leb(&l)) goto bad_header;
            char *tname = (char *)fwp_alloc((size_t)l + 1);
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
        }
        size_t cap = 16, cnt = 0;
        V *items = s->last_is_list ? (V *)malloc(cap * sizeof(V)) : 0;
        fwp_buf line = {0};
        for (;;) {
            V v;
            if (binary) {
                unsigned char hdr[5];
                if (!fwp_read_exact(hdr, 5) || hdr[0] == 0) break;
                size_t len = (size_t)hdr[1] | ((size_t)hdr[2] << 8) | ((size_t)hdr[3] << 16) | ((size_t)hdr[4] << 24);
                unsigned char *pl = (unsigned char *)fwp_alloc(len + 1);
                if (len && !fwp_read_exact(pl, len)) { fprintf(stderr, "%s: truncated frame\n", s->name); code = 3; break; }
                fwp_rd r = {pl, len, 0};
                if (!fwp_decode(&r, s->in_elem, &v)) { fprintf(stderr, "%s: truncated value\n", s->name); code = 3; break; }
            } else {
                if (!fwp_read_text_line(&line)) break;
                if (!fwp_parse_text(line.d ? line.d : "", line.len, s->in_elem, &v)) {
                    fprintf(stderr, "%s: cannot parse input `%.*s` as %s\n", s->name, (int)line.len,
                            line.d ? line.d : "", s->in_type);
                    code = 3;
                    break;
                }
            }
            if (s->last_is_list) {
                if (cnt == cap) { cap *= 2; items = (V *)realloc(items, cap * sizeof(V)); }
                items[cnt++] = v;
            } else {
                args[n - 1] = v;
                V r = fwp_exec_call(s, args, n, &failed);
                fflush(fwp_prog_out);
                if (failed) { code = 1; break; }
                fwp_emit_result(s, r);
                fflush(stdout);
            }
        }
        if (s->last_is_list && code == 0) {
            args[n - 1] = fwp_list_from(items, cnt);
            V r = fwp_exec_call(s, args, n, &failed);
            fflush(fwp_prog_out);
            if (failed) code = 1;
            else fwp_emit_result(s, r);
        }
        free(items);
        free(line.d);
    }
    if (fwp_exec_binary_out) {
        static const unsigned char end[5] = {0, 0, 0, 0, 0};
        fwrite(end, 1, 5, stdout);
    }
    fflush(stdout);
    return code;
bad_header:
    fprintf(stderr, "%s: truncated header\n", s->name);
    return 3;
}
