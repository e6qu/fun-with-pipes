/* Standalone function executables (mirrors src/exec.rs, src/textio.rs and
 * the decoding half of src/proto.rs). */

/* Temporary textual diagnostics own ordinary counted string leaves. */
static void fwp_cli_text_drop(V value) {
    if (!fwp_rc_release_last(value)) return;
#ifdef FWP_RESOURCE_NO_FREE
    fwp_rc_drop(value);
#else
    fwp_rc_free_obj(value);
#endif
}

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
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_buf_release, &b);
    for (;;) {
        if (p->i >= p->n) { fwp_cleanup_pop(&cleanup); free(b.d); return 0; }
        char c = p->s[p->i++];
        if (c == '"') break;
        if (c != '\\') { buf_putc(&b, c); continue; }
        if (p->i >= p->n) { fwp_cleanup_pop(&cleanup); free(b.d); return 0; }
        char e = p->s[p->i++];
        switch (e) {
        case 'n': buf_putc(&b, '\n'); break;
        case 't': buf_putc(&b, '\t'); break;
        case 'r': buf_putc(&b, '\r'); break;
        case '0': buf_putc(&b, 0); break;
        case '"': buf_putc(&b, '"'); break;
        case '\\': buf_putc(&b, '\\'); break;
        case 'u': {
            if (p->i >= p->n || p->s[p->i] != '{') { fwp_cleanup_pop(&cleanup); free(b.d); return 0; }
            p->i++;
            uint32_t cp = 0;
            int digits = 0;
            while (p->i < p->n && isxdigit((unsigned char)p->s[p->i])) {
                char h = p->s[p->i++];
                cp = cp * 16 + (uint32_t)(h <= '9' ? h - '0' : (h | 32) - 'a' + 10);
                digits++;
            }
            if (!digits || p->i >= p->n || p->s[p->i] != '}' || cp > 0x10FFFF || (cp >= 0xD800 && cp <= 0xDFFF)) {
                fwp_cleanup_pop(&cleanup); free(b.d);
                return 0;
            }
            p->i++;
            fwp_utf8_put(&b, cp);
            break;
        }
        default: fwp_cleanup_pop(&cleanup); free(b.d); return 0;
        }
    }
    if (!fwp_valid_utf8((const unsigned char *)(b.d ? b.d : ""), b.len)) { fwp_cleanup_pop(&cleanup); free(b.d); return 0; }
    *out = fwp_str_new(b.d ? b.d : "", b.len);
    fwp_cleanup_pop(&cleanup); free(b.d);
    return 1;
}

static int tp_value(fwp_tp *p, const fwp_desc *d, int top, V *out);

static int tp_atom(fwp_tp *p, const fwp_desc *d, V *out) {
    tp_ws(p);
    int tuple_like = d->kind == K_RECORD && !d->name && (d->n == 0 || d->width);
    if (p->i < p->n && p->s[p->i] == '(' && !tuple_like) {
        p->i++;
        if (!tp_value(p, d, 0, out)) return 0;
        if (tp_eat(p, ")")) return 1;
        if (d->drop) d->drop(*out);
        *out = 0;
        return 0;
    }
    return tp_value(p, d, 0, out);
}

static int tp_record_body(fwp_tp *p, const fwp_desc *d, V *out, fwp_decode_fields *fields) {
    fwp_decode_fields_begin(fields, (size_t)d->n, d->fields, (size_t)d->n, NULL);
    V *vals = fields->values;
    // Presence differs from value zero (unit, False, Nil and None).
    unsigned char *have = fwp_mem_alloc((size_t)d->n + 1);
    fields->scratch = have;
    if (!tp_eat(p, "{")) return 0;
    if (!tp_eat(p, "}")) {
        for (;;) {
            char name[256];
            tp_ident(p, name, sizeof name);
            int idx = -1;
            for (int i = 0; i < d->n; i++) if (strcmp(d->names[i], name) == 0) idx = i;
            if (idx < 0 || !tp_eat(p, "=")) return 0;
            if (have[idx] && d->fields[idx]->drop) d->fields[idx]->drop(vals[idx]);
            vals[idx] = 0;
            if (!tp_value(p, d->fields[idx], 0, &vals[idx])) return 0;
            have[idx] = 1;
            if (tp_eat(p, "}")) break;
            if (!tp_eat(p, ",")) return 0;
        }
    }
    for (int i = 0; i < d->n; i++) if (!have[i]) return 0;
    *out = fwp_decode_record(fields);
    return 1;
}

static int tp_int(fwp_tp *p, const fwp_desc *d, V *out) {
    char t[128];
    size_t l = tp_token(p, t, sizeof t);
    if (l >= sizeof t) return 0;
    return fwp_parse_integer_bytes(t, l, d->kind, d->width, out);
}

static int tp_float(fwp_tp *p, const fwp_desc *d, V *out) {
    char t[128];
    size_t l = tp_token(p, t, sizeof t);
    if (l >= sizeof t) return 0;
#ifdef FWP_EXACT_FLOAT
    if (d->kind == K_F16 || d->kind == K_BF16 || d->kind == K_F128) {
        if (strcmp(t, "inf") && strcmp(t, "-inf") && strcmp(t, "NaN") && !fwp_valid_float(t, l)) return 0;
        return fwp_parse_exact(t, d->kind, out);
    }
#endif
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

typedef struct { const fwp_desc *d, *d2; fwp_decode_fields *owner; size_t n; int is_set; } tp_coll;

static V *tp_slots(tp_coll *c, size_t n) {
    if (n > SIZE_MAX - c->n) fwp_trap("text value too large");
    size_t need = c->n + n;
    if (need > c->owner->count) {
        size_t count = c->owner->count;
        if (count > SIZE_MAX / 2) fwp_trap("text value too large");
        count = count ? 2 * count : 8;
        if (count < need) count = need;
        fwp_decode_fields_resize(c->owner, count);
    }
    V *slot = c->owner->values + c->n;
    c->n = need;
    return slot;
}
static int tp_elem_item(fwp_tp *p, void *ctx) {
    tp_coll *c = ctx;
    return tp_value(p, c->d, 0, tp_slots(c, 1));
}
static int tp_byte_item(fwp_tp *p, void *ctx) {
    static const fwp_desc u8d = {K_U8, "U8"};
    tp_coll *c = ctx;
    return tp_int(p, &u8d, tp_slots(c, 1));
}
static int tp_kv_item(fwp_tp *p, void *ctx) {
    tp_coll *c = ctx;
    V *pair = tp_slots(c, c->is_set ? 1 : 2);
    if (!tp_value(p, c->d, 0, &pair[0])) return 0;
    if (!c->is_set && (!tp_eat(p, ":") || !tp_value(p, c->d2, 0, &pair[1]))) return 0;
    return 1;
}

static int tp_value_inner(fwp_tp *p, const fwp_desc *d, int top, V *out, fwp_decode_fields *fields) {
    /* a top-level string is the text as it is, spaces included */
    if (!(top && d->kind == K_STR)) tp_ws(p);
    switch (d->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64: case K_I128:
    case K_U8: case K_U16: case K_U32: case K_U64: case K_U128:
        return tp_int(p, d, out);
    case K_F16: case K_BF16: case K_F128: case K_F32: case K_F64: return tp_float(p, d, out);
    case K_STR:
        if (top) {
            if (!fwp_valid_utf8((const unsigned char *)p->s + p->i, p->n - p->i)) return 0;
            *out = fwp_str_new(p->s + p->i, p->n - p->i);
            p->i = p->n;
            return 1;
        }
        return tp_quoted(p, out);
    case K_BYTES: {
        static const fwp_desc byte = {.kind = K_U8};
        fwp_decode_fields_begin(fields, 0, NULL, 0, &byte);
        tp_coll c = {&byte, NULL, fields, 0, 0};
        if (!tp_eat(p, "bytes") || !tp_list_of(p, "[", "]", tp_byte_item, &c)) return 0;
        fwp_buf b = {0};
        fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_buf_release, &b);
        for (size_t i = 0; i < c.n; i++) buf_putc(&b, (char)(uint8_t)fields->values[i]);
        *out = fwp_str_new(b.d ? b.d : "", b.len);
        fwp_cleanup_pop(&cleanup); free(b.d);
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
        fwp_decode_fields_begin(fields, 0, NULL, 0, d->elem);
        tp_coll c = {d->elem, NULL, fields, 0, 0};
        if (d->kind == K_ARRAY && !tp_eat(p, "array")) return 0;
        if (!tp_list_of(p, "[", "]", tp_elem_item, &c)) return 0;
        fields->count = c.n;
        *out = fwp_decode_sequence(fields, d);
        return 1;
    }
    case K_MAP: case K_SET: {
        fields->local_types[0] = d->elem; fields->local_types[1] = d->elem2;
        fwp_decode_fields_begin(fields, 0, fields->local_types, d->kind == K_SET ? 1 : 2, NULL);
        tp_coll c = {d->elem, d->elem2, fields, 0, d->kind == K_SET};
        if (!tp_eat(p, c.is_set ? "set" : "map")) return 0;
        if (!tp_list_of(p, "{", "}", tp_kv_item, &c)) return 0;
        fields->count = c.n;
        *out = fwp_decode_map(fields, d);
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
                        *out = fwp_rc_fresh(fwp_record(1, f));
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
            fwp_decode_fields_begin(fields, (size_t)d->n, d->fields, (size_t)d->n, NULL);
            V *vals = fields->values;
            if (!tp_eat(p, "(")) return 0;
            for (int i = 0; i < d->n; i++) {
                if (i > 0 && !tp_eat(p, ",")) return 0;
                if (!tp_value(p, d->fields[i], 0, &vals[i])) return 0;
            }
            if (!tp_eat(p, ")")) return 0;
            *out = fwp_decode_record(fields);
            return 1;
        }
        if (d->name) {
            tp_ws(p);
            size_t l = strlen(d->name);
            if (p->n - p->i >= l && memcmp(p->s + p->i, d->name, l) == 0) p->i += l;
        }
        return tp_record_body(p, d, out, fields);
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
        fwp_decode_fields_begin(fields, (size_t)n, d->vfields[tag], (size_t)n, NULL);
        V *fs = fields->values;
        for (int i = 0; i < n; i++)
            if (!tp_atom(p, d->vfields[tag][i], &fs[i])) return 0;
        *out = fwp_decode_variant(fields, (uint32_t)tag);
        return 1;
    }
    default: return 0;
    }
}

static int tp_value(fwp_tp *p, const fwp_desc *d, int top, V *out) {
    fwp_decode_fields fields = {0};
    int ok = tp_value_inner(p, d, top, out, &fields);
    if (fields.active) fwp_decode_fields_end(&fields, 0);
    if (ok && (d->kind == K_STR || d->kind == K_BYTES || d->kind == K_I128 || d->kind == K_U128 || d->kind == K_F128)) fwp_rc_fresh(*out);
    return ok;
}

static int fwp_parse_text(const char *s, size_t n, const fwp_desc *d, V *out) {
    fwp_tp p = {s, n, 0};
    if (!tp_value(&p, d, 1, out)) return 0;
    tp_ws(&p);
    if (p.i == p.n) return 1;
    if (d->drop) d->drop(*out);
    *out = 0;
    return 0;
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

/* Only records can encode no bytes; constructor tags and counts occupy bytes.
 * Avoid following a recursive descriptor graph indefinitely. */
typedef struct fwp_wire_path { const fwp_desc *desc; const struct fwp_wire_path *parent; } fwp_wire_path;
static int fwp_wire_empty_inner(const fwp_desc *d,const fwp_wire_path *path) {
    if(!d || d->kind!=K_RECORD)return 0;
    for(const fwp_wire_path *p=path;p;p=p->parent)if(p->desc==d)return 0;
    const fwp_wire_path here={d,path};
    for(int i=0;i<d->n;i++)if(!fwp_wire_empty_inner(d->fields[i],&here))return 0;
    return 1;
}
static int fwp_decode_count(fwp_rd *r,const fwp_desc *elem,int unique,uint64_t *count) {
    if(!rd_leb(r,count) || *count>(SIZE_MAX-sizeof(fwp_arr))/sizeof(V))return 0;
    if(fwp_wire_empty_inner(elem,0))return !unique || *count<=1;
    return *count<=r->n;
}

static int fwp_decode(fwp_rd *r, const fwp_desc *d, V *out);
static int fwp_decode_inner(fwp_rd *r, const fwp_desc *d, V *out, fwp_decode_fields *fields) {
    uint64_t x;
    switch (d->kind) {
    case K_I8: if (!rd_le(r, 1, &x)) return 0; *out = (V)(int64_t)(int8_t)x; return 1;
    case K_I16: if (!rd_le(r, 2, &x)) return 0; *out = (V)(int64_t)(int16_t)x; return 1;
    case K_I32: if (!rd_le(r, 4, &x)) return 0; *out = (V)(int64_t)(int32_t)x; return 1;
    case K_U8: case K_U16: case K_U32: case K_U64: case K_I64: case K_F32: case K_F64: {
        int k = d->kind == K_U8 ? 1 : d->kind == K_U16 ? 2 : (d->kind == K_U32 || d->kind == K_F32) ? 4 : 8;
        if (!rd_le(r, k, &x)) return 0;
        *out = x;
        return 1;
    }
    case K_TINT: {
        if (d->width < 0 || d->width > 40 || !rd_le(r, 8, &x)) return 0;
        i128 value = (int64_t)x, max = fwp_tint_max(d->width);
        if (value < -max || value > max) return 0;
        *out = x; return 1;
    }
    case K_TRIT:
        if (!rd_le(r, 1, &x) || (x != 255 && x > 1)) return 0;
        *out = (V)(int64_t)(int8_t)x; return 1;
#ifdef FWP_EXACT_FLOAT
    case K_F16: case K_BF16: if (!rd_le(r, 2, &x)) return 0; *out = x; return 1;
    case K_F128: {
        uint64_t lo, hi;
        if (!rd_le(r, 8, &lo) || !rd_le(r, 8, &hi)) return 0;
        *out = fwp_box_f128((float128_t){{lo, hi}}); return 1;
    }
#endif
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
        if (!fwp_decode_count(r, d->elem, 0, &x)) return 0;
        int array = d->kind == K_ARRAY;
        fwp_decode_fields_begin(fields, array ? 1 : (size_t)x, NULL, 0, d->elem);
        if (array) {
            fields->aggregate_type = d;
            fields->aggregate = fwp_rc_fresh(fwp_array_new_packed((size_t)x, d->elem));
            fwp_array_set_len(fields->aggregate, 0);
        }
        for (size_t i = 0; i < (size_t)x; i++) {
            if (!fwp_decode(r, d->elem, &fields->values[array ? 0 : i])) return 0;
            if (array) {
                fwp_array_store_owned(fields->aggregate, i, fields->values[0], d->elem);
                fwp_array_set_len(fields->aggregate, i + 1);
                fields->values[0] = 0;
            }
        }
        *out = fwp_decode_sequence(fields, d);
        return 1;
    }
    case K_MAP: case K_SET: {
        int empty_values = d->kind == K_SET || fwp_wire_empty_inner(d->elem2, 0);
        if (!fwp_decode_count(r, d->elem, empty_values, &x) || (!empty_values && x > r->n)) return 0;
        size_t stride = d->kind == K_SET ? 1 : 2;
        if (x > SIZE_MAX / stride / sizeof(V)) return 0;
        fields->local_types[0] = d->elem; fields->local_types[1] = d->elem2;
        fwp_decode_fields_begin(fields, (size_t)x * stride, fields->local_types, stride, NULL);
        for (size_t i = 0; i < (size_t)x; i++) {
            if (!fwp_decode(r, d->elem, &fields->values[i * stride])) return 0;
            if (stride == 2 && !fwp_decode(r, d->elem2, &fields->values[i * stride + 1])) return 0;
        }
        *out = fwp_decode_map(fields, d);
        return 1;
    }
    case K_RECORD: {
        if (d->n == 0) { *out = 0; return 1; }
        fwp_decode_fields_begin(fields, (size_t)d->n, d->fields, (size_t)d->n, NULL);
        V *fs = fields->values;
        for (int i = 0; i < d->n; i++) if (!fwp_decode(r, d->fields[i], &fs[i])) return 0;
        *out = fwp_decode_record(fields);
        return 1;
    }
    case K_ADT: {
        if (!rd_leb(r, &x) || x >= (uint64_t)d->n) return 0;
        int n = d->arity[x];
        fwp_decode_fields_begin(fields, (size_t)n, d->vfields[x], (size_t)n, NULL);
        V *fs = fields->values;
        for (int i = 0; i < n; i++) if (!fwp_decode(r, d->vfields[x][i], &fs[i])) return 0;
        *out = fwp_decode_variant(fields, (uint32_t)x);
        return 1;
    }
    default: return 0;
    }
}

static int fwp_decode(fwp_rd *r, const fwp_desc *d, V *out) {
    fwp_decode_fields fields = {0};
    int ok = fwp_decode_inner(r, d, out, &fields);
    if (fields.active) fwp_decode_fields_end(&fields, 0);
    if (ok && (d->kind == K_STR || d->kind == K_BYTES || d->kind == K_I128 || d->kind == K_U128 || d->kind == K_F128)) fwp_rc_fresh(*out);
    return ok;
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
    if (n < 0) fwp_trap("cannot format string");
    fwp_str *result = fwp_alloc_leaf(sizeof(fwp_str) + (size_t)n + 1);
    result->len = (size_t)n;
    va_start(ap, fmt);
    vsnprintf(result->d, (size_t)n + 1, fmt, ap);
    va_end(ap);
    return PTR(result);
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
static void fwp_choices(fwp_buf *b, const fwp_desc *d) {
    for (int i = 0; i < d->n; i++) {
        if (i) buf_puts(b, ", ");
        fwp_kebab(b, d->names[i]);
    }
}

/* A value on the command line (src/cli.rs parse_value): 1, or 0 with
 * *err the message after "option `--x`: " */
static int fwp_cli_value(const char *t, size_t n, const fwp_desc *d, const char *dname, V *out, V *err) {
    if (fwp_is_enum(d)) {
        fwp_buf a = {0}, c = {0};
        fwp_cleanup ca, cc;
        fwp_cleanup_push(&ca, fwp_buf_release, &a);
        fwp_cleanup_push(&cc, fwp_buf_release, &c);
        fwp_loose(&a, t, n);
        int tag = -1;
        for (int i = 0; i < d->n && tag < 0 && a.len; i++) {
            fwp_loose(&c, d->names[i], strlen(d->names[i]));
            if (c.len == a.len && memcmp(c.d, a.d, a.len) == 0) tag = i;
        }
        fwp_cleanup_pop(&cc); free(c.d);
        fwp_cleanup_pop(&ca); free(a.d);
        if (tag >= 0) { *out = (V)tag; return 1; }
        fwp_buf choices = {0};
        fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_buf_release, &choices);
        fwp_choices(&choices, d);
        *err = fwp_strf("`%.*s` is not one of %s", (int)n, t, choices.d ? choices.d : "");
        fwp_cleanup_pop(&cleanup); fwp_buf_release(&choices);
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
        fwp_value_owner message = {fwp_rc_fresh(m), fwp_cli_text_drop};
        fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_value_release, &message);
        *err = fwp_strf("option `--%s`: %s", f->name, STR(m)->d);
        fwp_cleanup_pop(&cleanup); fwp_value_release(&message);
        return 0;
    }
    if (f->kind == FL_REPEATED) {
        fwp_value_owner pending = {v, f->value->drop};
        fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_value_release, &pending);
        vals[k] = fwp_private_cons_owned(v, vals[k]);
        fwp_cleanup_pop(&cleanup); /* the new cell takes v and the previous tail */
    } else {
        if (state[k] && f->value->drop) f->value->drop(vals[k]);
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
#ifdef _WIN32
    V value;
    if (!fwp_win_env_text(f->env, strlen(f->env), &value)) return 0;
    fwp_value_owner text = {fwp_rc_fresh(value), fwp_cli_text_drop};
    if (!STR(value)->len) { fwp_value_release(&text); return 0; }
#else
    const char *e = getenv(f->env);
    if (!e || !*e) return 0;
    fwp_value_owner text = {fwp_rc_fresh(fwp_str_lossy(e, strlen(e))), fwp_cli_text_drop};
#endif
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_value_release, &text);
    const char *s = STR(text.value)->d;
    size_t n = STR(text.value)->len;
    if (f->kind == FL_SWITCH && n == 1 && (s[0] == '1' || s[0] == '0')) {
        s = s[0] == '1' ? "true" : "false";
        n = strlen(s);
    }
    V v, m;
    if (!fwp_cli_value(s, n, f->value, f->value_name, &v, &m)) {
        fwp_value_owner message = {fwp_rc_fresh(m), fwp_cli_text_drop};
        fwp_cleanup message_cleanup; fwp_cleanup_push(&message_cleanup, fwp_value_release, &message);
        *err = fwp_strf("environment variable `%s`: %s", f->env, STR(m)->d);
        fwp_cleanup_pop(&message_cleanup); fwp_value_release(&message);
        fwp_cleanup_pop(&cleanup); fwp_value_release(&text);
        return -1;
    }
    fwp_value_owner pending = {v, f->value->drop};
    fwp_cleanup pending_cleanup; fwp_cleanup_push(&pending_cleanup, fwp_value_release, &pending);
    if (f->kind == FL_OPTIONAL) v = fwp_rc_fresh(fwp_some(v));
    else if (f->kind == FL_REPEATED) v = fwp_private_cons_owned(v, 0);
    fwp_cleanup_pop(&pending_cleanup);
    *out = v;
    fwp_cleanup_pop(&cleanup); fwp_value_release(&text);
    return 1;
}

/* The options record from parsed values, environment variables (with
 * `env`) and defaults (have_def[k]: defs[k] is the default). 0 with *err
 * for a missing required flag or a bad environment variable. */
static int fwp_cli_record(const fwp_flag *fl, int nf, int nfields, V *vals, const char *state,
                          const V *defs, const char *have_def, int env, V *out, V *err) {
    const fwp_desc *types[nfields ? nfields : 1];
    memset(types, 0, sizeof types);
    for (int k = 0; k < nf; k++) types[fl[k].index] = fl[k].field;
    fwp_decode_fields fields;
    fwp_decode_fields_begin(&fields, (size_t)nfields, types, (size_t)nfields, NULL);
    V *fs = fields.values;
    char *present = fields.scratch = fwp_mem_alloc((size_t)nf + 1);
    for (int k = 0; k < nf; k++) {
        const fwp_flag *f = &fl[k];
        V v;
        int e = 0;
        if (!state[k] && env && (e = fwp_flag_env(f, &v, err)) < 0) goto failure;
        present[k] = state[k] || e;
        if (state[k]) {
            if (f->kind == FL_OPTIONAL) v = fwp_rc_fresh(fwp_some(vals[k]));
            else if (f->kind == FL_REPEATED) v = fwp_private_reverse_owned(vals[k]);
            else v = vals[k];
            vals[k] = 0; /* the field takes the parsed owner */
        } else if (e) {
            /* from the environment */
        } else if (have_def[k]) {
            v = defs[k];
            if (f->field->dup) f->field->dup(v);
        } else if (f->kind == FL_SINGLE) {
            *err = fwp_strf("missing option `--%s`", f->name);
            goto failure;
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
                goto failure;
            }
        for (const int *r = fl[k].requires; r && *r >= 0; r++)
            if (!present[*r]) {
                *err = fwp_strf("option `--%s` needs `--%s`", fl[k].name, fl[*r].name);
                goto failure;
            }
    }
    *out = fwp_decode_record(&fields);
    return 1;
failure:
    fwp_decode_fields_end(&fields, 0);
    return 0;
}

/* help text of a default value (as src/cli.rs default_note), or 0 */
static V fwp_flag_default_note(const fwp_flag *f, V v) {
    fwp_buf b = {0};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_buf_release, &b);
    switch (f->kind) {
    case FL_SWITCH: if (v == FWP_FALSE) goto empty; fwp_write(&b, v, f->field, 0); break;
    case FL_OPTIONAL: if (v == FWP_NONE) goto empty; fwp_show_value(&b, OBJ(v)->f[0], f->value); break;
    case FL_REPEATED: if (v == 0) goto empty; fwp_write(&b, v, f->field, 0); break;
    default: fwp_show_value(&b, v, f->field);
    }
    V result = fwp_str_new(b.d ? b.d : "", b.len);
    fwp_cleanup_pop(&cleanup); free(b.d);
    return result;
empty:
    fwp_cleanup_pop(&cleanup); free(b.d);
    return 0;
}

/* the help line of a flag, with its default note (src/cli.rs rows,
 * without the environment variable) */
static void fwp_flag_help(fwp_buf *b, const fwp_flag *f, V note) {
    fwp_buf t = {0};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_buf_release, &t);
    buf_puts(&t, f->doc);
    int enm = fwp_is_enum(f->value);
    if (note || f->kind == FL_REPEATED || enm || f->post) {
        if (t.len) buf_putc(&t, ' ');
        buf_putc(&t, '(');
        if (enm) {
            buf_puts(&t, "one of: ");
            fwp_choices(&t, f->value);
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
    fwp_cleanup_pop(&cleanup); free(t.d);
}

/* cli.parse: the options record (every field with the default of `defs`)
 * and the positional arguments, or an error message. */
static V fwp_p_cli_parse(V defs, V args, const fwp_flag *fl, int nf, int nfields, const fwp_desc *result_type) {
    const fwp_desc *pair_type = result_type->vfields[0][0];
    const fwp_desc *list_type = pair_type->fields[1];
    fwp_decode_fields result;
    fwp_decode_fields_begin(&result, 1, result_type->vfields[0], 1, NULL);
    size_t n = fwp_list_len(args);
    if (n > INT_MAX || n > (SIZE_MAX / sizeof(V) - (size_t)nf - 2) / 2)
        fwp_trap("too many command-line arguments");
    const fwp_desc *types[nf ? nf : 1];
    for (int k = 0; k < nf; k++) types[k] = fl[k].kind == FL_REPEATED ? fl[k].field : fl[k].value;
    fwp_decode_fields parsed;
    fwp_decode_fields_begin(&parsed, (size_t)nf, types, (size_t)nf, NULL);
    size_t words = 2 * (n + 1) + (size_t)nf;
    size_t bytes = words * sizeof(V);
    if ((size_t)nf + 1 > (SIZE_MAX - bytes) / 2) fwp_trap("too many command-line flags");
    V *argv = parsed.scratch = fwp_mem_alloc(bytes + 2 * ((size_t)nf + 1));
    V *pos = argv + n + 1, *dv = pos + n + 1;
    char *state = (char *)(argv + words), *have = state + nf + 1;
    size_t i = 0;
    for (V l = args; l; l = OBJ(l)->f[1]) argv[i++] = OBJ(l)->f[0];
    for (int k = 0; k < nf; k++) { dv[k] = OBJ(defs)->f[fl[k].index]; have[k] = 1; }
    int npos;
    V err = 0;
    int failed = fwp_cli_parse(fl, nf, 0, 0, (int)n, argv, parsed.values, state, pos, &npos, &err) != 0;
    fwp_decode_fields pair;
    fwp_decode_fields_begin(&pair, 2, pair_type->fields, 2, NULL);
    if (!failed) failed = !fwp_cli_record(fl, nf, nfields, parsed.values, state, dv, have, 0, &pair.values[0], &err);
    if (failed) {
        result.descs = result_type->vfields[1];
        result.values[0] = fwp_rc_fresh(err);
        fwp_decode_fields_end(&pair, 0);
    } else {
        fwp_decode_fields positional;
        fwp_decode_fields_begin(&positional, (size_t)npos, NULL, 0, list_type->elem);
        for (int k = 0; k < npos; k++) {
            if (list_type->elem->dup) list_type->elem->dup(pos[k]);
            positional.values[k] = pos[k];
        }
        pair.values[1] = fwp_decode_sequence(&positional, list_type);
        result.values[0] = fwp_decode_record(&pair);
    }
    fwp_decode_fields_end(&parsed, 0);
    V value = fwp_decode_variant(&result, failed ? 1 : 0);

    return value;
}

/* cli.help: the help lines of the flags with the defaults of `defs` */
static V fwp_p_cli_help(V defs, const fwp_flag *fl, int nf) {
    fwp_buf b = {0};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_buf_release, &b);
    for (int k = 0; k < nf; k++) {
        fwp_value_owner note = {fwp_rc_fresh(fwp_flag_default_note(&fl[k], OBJ(defs)->f[fl[k].index])), fwp_cli_text_drop};
        fwp_cleanup note_cleanup; fwp_cleanup_push(&note_cleanup, fwp_value_release, &note);
        fwp_flag_help(&b, &fl[k], note.value);
        fwp_cleanup_pop(&note_cleanup); fwp_value_release(&note);
    }
    V result = fwp_str_new(b.d ? b.d : "", b.len);
    fwp_cleanup_pop(&cleanup); free(b.d);

    return result;
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
    const fwp_clo *callable; /* static address; converted to V only at the call */
    const fwp_desc *result; /* complete result, before output projections */
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
        fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_buf_release, &b);
        fwp_encode(&b, v, s->out_elem);
        unsigned char hdr[5] = {1, (unsigned char)(b.len & 0xff), (unsigned char)((b.len >> 8) & 0xff),
                                (unsigned char)((b.len >> 16) & 0xff), (unsigned char)((b.len >> 24) & 0xff)};
        fwp_pipe_write(hdr, 5);
        if (b.len) fwp_pipe_write(b.d, b.len);
        fwp_cleanup_pop(&cleanup); free(b.d);
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
    fwp_value_owner owner = {v, s->result->drop};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_value_release, &owner);
    int status = 0;
    if (s->res_outcome) {
        int64_t st = (int64_t)(int32_t)OBJ(v)->f[s->res_status];
        status = (int)(((st % 256) + 256) % 256);
        v = OBJ(v)->f[s->res_output];
    }
    if (s->res_err) {
        if (fwp_tag(v) != 0) { fwp_exec_error(s, OBJ(v)->f[0], s->res_err); status = -1; goto finish; }
        v = OBJ(v)->f[0];
    }
    if (s->res_option) {
        if (v == FWP_NONE) goto finish;
        v = OBJ(v)->f[0];
    }
    if (s->res_list) {
        for (; v != 0; v = OBJ(v)->f[1]) fwp_emit(s, OBJ(v)->f[0]);
    } else {
        fwp_emit(s, v);
    }
finish:
    fwp_cleanup_pop(&cleanup); fwp_value_release(&owner);
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
        V r = n == 0 ? s->caf() : fwp_apply_borrowed(PTR(s->callable), (uint32_t)n, args);
        fwp_value_owner owner = {r, s->result->drop};
        fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_value_release, &owner);
        fwp_tasks_finish();
        fwp_cleanup_pop(&cleanup);
        fwp_handlers = h.prev;
        *failed = 0;
        return r;
    }
    fwp_handlers = h.prev;
    fwp_value_owner owner = {h.value, h.desc->drop};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_value_release, &owner);
    fwp_tasks_abort();
    fwp_flush();
    fwp_exec_error(s, h.value, h.desc);
    fwp_cleanup_pop(&cleanup); fwp_value_release(&owner);
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
    if (msg) fwp_cli_text_drop(fwp_rc_fresh(msg));
    return 2;
}

static int fwp_parse_arg(const fwp_exec_spec *s, int i, V a, const fwp_desc *d, const char *dname, V *out) {
    V err;
    if (fwp_cli_value(STR(a)->d, STR(a)->len, d, dname, out, &err)) return 1;
    fprintf(stderr, "%s: argument %d: %s\n", s->name, i + 1, STR(err)->d);
    fwp_cli_text_drop(fwp_rc_fresh(err));
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
    fwp_cli_text_drop(fwp_rc_fresh(sh));
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
                fwp_value_owner pending = {v, p->value->drop};
                fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_value_release, &pending);
                if (p->kind == POS_OPTIONAL) v = fwp_rc_fresh(fwp_some(v));
                *slot = v;
                fwp_cleanup_pop(&cleanup);
                i++;
            } else if (p->kind == POS_OPTIONAL) {
                *slot = FWP_NONE;
            } else if (!fwp_parse_text(p->def, strlen(p->def), p->param, slot)) {
                fwp_trap("invalid compiled command-line default");
            }
            break;
        default: {
            if (i == k && p->def) {
                if (!fwp_parse_text(p->def, strlen(p->def), p->param, slot))
                    fwp_trap("invalid compiled command-line default");
                break;
            }
            fwp_decode_fields rest;
            fwp_decode_fields_begin(&rest, (size_t)(k - i), NULL, 0, p->value);
            for (int r = 0; i < k; i++, r++)
                if (!fwp_parse_arg(s, i, pos[i], p->value, p->value_name, &rest.values[r])) {
                    fwp_decode_fields_end(&rest, 0); return 2;
                }
            *slot = fwp_decode_sequence(&rest, p->param);
        }
        }
    }
    return 0;
}

/* One command owns parsed arguments, defaults, decoded values and scratch.
 * Early usage/header failures and nonlocal exits use the same cleanup. */
typedef struct {
    const fwp_exec_spec *spec;
    int argc, nflags;
    V *av, *args, *vals, *defs, *pos, *items;
    char *state, *have, *header;
    unsigned char *payload;
    size_t count;
    V input, text;
    fwp_buf line;
    FILE *previous_output;
} fwp_exec_owner;
static void fwp_exec_release(void *pointer) {
    fwp_exec_owner *owner = pointer;
    const fwp_exec_spec *s = owner->spec;
    if (owner->args) for (int i = 0; i < s->arity; i++)
        if (s->params[i]->drop) s->params[i]->drop(owner->args[i]);
    if (owner->av) for (int i = 0; i < owner->argc; i++) fwp_cli_text_drop(owner->av[i]);
    for (int i = 0; i < owner->nflags; i++) {
        const fwp_flag *f = &s->flags[i];
        const fwp_desc *parsed = f->kind == FL_REPEATED ? f->field : f->value;
        if (owner->vals && parsed->drop) parsed->drop(owner->vals[i]);
        if (owner->defs && f->field->drop) f->field->drop(owner->defs[i]);
    }
    if (s->in_elem->drop) {
        s->in_elem->drop(owner->input);
        for (size_t i = 0; i < owner->count; i++) s->in_elem->drop(owner->items[i]);
    }
    fwp_cli_text_drop(owner->text);
    fwp_mem_free(owner->av); fwp_mem_free(owner->args);
    fwp_mem_free(owner->vals); fwp_mem_free(owner->defs);
    fwp_mem_free(owner->pos); fwp_mem_free(owner->items);
    fwp_mem_free(owner->state); fwp_mem_free(owner->have);
    fwp_mem_free(owner->header); fwp_mem_free(owner->payload);
    free(owner->line.d);
    fwp_pipe_finish();
    fwp_prog_out = owner->previous_output;
}

static int fwp_exec_run(const fwp_exec_spec *s, int argc, char **argv, fwp_exec_owner *owner) {
    int n = s->arity;
    int na = argc - 1;
    if (fwp_cli_single) {
        int g = fwp_generated(s->name, s->flags, s->has_options ? s->nflags : 0, na, argv + 1);
        if (g >= 0) return g;
    }
    V *av = owner->av = (V *)fwp_mem_alloc((size_t)(na + 1) * sizeof(V));
    for (int i = 0; i < na; i++) av[i] = fwp_rc_fresh(fwp_str_lossy(argv[i + 1], strlen(argv[i + 1])));
    /* flags, unless a record parameter is given as before */
    int flags_mode = s->has_options && (!s->record_fallback || (na > 0 && STR(av[0])->d[0] == '-'));
    int nf = owner->nflags = flags_mode ? s->nflags : 0;
    V *vals = owner->vals = (V *)fwp_mem_alloc((size_t)(nf + 1) * sizeof(V));
    char *state = owner->state = (char *)fwp_mem_alloc((size_t)nf + 1);
    V *pos = owner->pos = (V *)fwp_mem_alloc((size_t)(na + 1) * sizeof(V));
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
    V *args = owner->args = (V *)fwp_mem_alloc((size_t)(n + 1) * sizeof(V));
    int first = 0;
    if (flags_mode) {
        V *defs = owner->defs = (V *)fwp_mem_alloc((size_t)(nf + 1) * sizeof(V));
        char *have = owner->have = (char *)fwp_mem_alloc((size_t)nf + 1);
        for (int j = 0; j < nf; j++) {
            const fwp_flag *f = &s->flags[j];
            have[j] = f->def != 0;
            if (f->def && !fwp_parse_text(f->def, strlen(f->def), f->field, &defs[j]))
                fwp_trap("invalid compiled command-line default");
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
            if (ver != 2) {
                fprintf(stderr, "%s: unsupported protocol version %d\n", s->name, ver);
                return 3;
            }
            if ((ok = fwp_stdin_leb(&ncaps)) != 1) goto header_error;
            int uds = 0;
            if (ncaps > 64) goto bad_header;
            for (uint64_t i = 0; i < ncaps; i++) {
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
            char *tname = owner->header = (char *)fwp_mem_alloc((size_t)l + 1);
            if (l && !fwp_read_exact((unsigned char *)tname, (size_t)l)) goto bad_header;
            tname[l] = 0;
            if (memcmp(fp, s->in_fp, 16) != 0) {
                fprintf(stderr, "%s: input type mismatch: expected `%s`, got `%s`\n", s->name, s->in_type, tname);
                return 3;
            }
            fwp_mem_free(owner->header); owner->header = NULL;
            if (uds) fwp_pipe_in_offer();
        }
        size_t cap = 16;
        if (s->last_is_list) owner->items = (V *)fwp_mem_alloc(cap * sizeof(V));
        for (;;) {
            fwp_mem_free(owner->payload); owner->payload = NULL;
            fwp_cli_text_drop(owner->text); owner->text = 0;
            if (binary) {
                unsigned char hdr[5];
                if (!fwp_read_exact(hdr, 1)) break;
                if (!fwp_read_exact(hdr + 1, 4)) { fprintf(stderr, "%s: truncated frame\n", s->name); code = 3; break; }
                size_t len = (size_t)hdr[1] | ((size_t)hdr[2] << 8) | ((size_t)hdr[3] << 16) | ((size_t)hdr[4] << 24);
                unsigned char *pl = owner->payload = (unsigned char *)fwp_mem_alloc(len + 1);
                if (len && !fwp_read_exact(pl, len)) { fprintf(stderr, "%s: truncated frame\n", s->name); code = 3; break; }
                if (hdr[0] == 0) break;
                if (hdr[0] == 2) {
                    if (fwp_pipe_in_switch(pl, len)) continue;
                    fprintf(stderr, "%s: bad switch frame\n", s->name);
                    code = 3;
                    break;
                }
                fwp_rd rd = {pl, len, 0};
                if (!fwp_decode(&rd, s->in_elem, &owner->input)) { fprintf(stderr, "%s: malformed value\n", s->name); code = 3; break; }
            } else {
                if (!fwp_read_text_line(&owner->line)) break;
                V t = owner->text = fwp_rc_fresh(fwp_str_lossy(owner->line.d ? owner->line.d : "", owner->line.len));
                if (!fwp_parse_text(STR(t)->d, STR(t)->len, s->in_elem, &owner->input)) {
                    fprintf(stderr, "%s: cannot parse input `%.*s` as %s\n", s->name, (int)STR(t)->len,
                            STR(t)->d, s->in_type);
                    code = 3;
                    break;
                }
            }
            if (s->last_is_list) {
                if (owner->count == cap) {
                    if (cap > SIZE_MAX / 2 / sizeof(V)) fwp_trap("too many input values");
                    owner->items = (V *)fwp_mem_realloc(owner->items, cap * sizeof(V), cap * 2 * sizeof(V));
                    cap *= 2;
                }
                owner->items[owner->count++] = owner->input;
                owner->input = 0;
            } else {
                if (s->params[m - 1]->drop) s->params[m - 1]->drop(args[m - 1]);
                args[m - 1] = owner->input; owner->input = 0;
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
            for (size_t i = owner->count; i > 0; i--) {
                args[m - 1] = fwp_rc_fresh(fwp_cons(owner->items[i - 1], args[m - 1]));
                owner->items[i - 1] = 0;
            }
            V r = fwp_exec_call(s, args, n, &failed);
            fflush(fwp_prog_out);
            if (failed) code = 1;
            else if ((code = fwp_emit_result(s, r)) < 0) code = 1;
        }
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

static int fwp_exec(const fwp_exec_spec *s, int argc, char **argv) {
    fwp_exec_owner owner = {.spec = s, .argc = argc - 1, .previous_output = fwp_prog_out};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_exec_release, &owner);
    int result = fwp_exec_run(s, argc, argv, &owner);
    fwp_cleanup_pop(&cleanup); fwp_exec_release(&owner);
    return result;
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
    fwp_cli_text_drop(fwp_rc_fresh(f));
    return 2;
}

/* ------------------------------------------------------------------- csv */
/* As src/csv.rs: records of fields, a one-byte separator, `"` quotes. */

typedef struct {
    V rows, row, field;
    fwp_buf buffer;
    void (*drop_row)(V), (*drop_rows)(V), (*drop_field)(V);
} fwp_csv_owner;
static void fwp_csv_release(void *arg) {
    fwp_csv_owner *o = (fwp_csv_owner *)arg;
    o->drop_rows(o->rows);
    o->drop_row(o->row);
    o->drop_field(o->field);
    free(o->buffer.d);
}
static V fwp_p_csv_parse_with(V sepv, V text,
                            void (*drop_row)(V), void (*drop_rows)(V), void (*drop_field)(V)) {
    char sep = STR(sepv)->len ? STR(sepv)->d[0] : ',';
    const char *s = STR(text)->d;
    size_t n = STR(text)->len, i = 0;
    fwp_csv_owner owner = {0, 0, 0, {0}, drop_row, drop_rows, drop_field};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_csv_release, &owner);
    int at_start = 1, any = 0;
#define CSV_OWNED_FIELD() do { \
    owner.field = fwp_rc_fresh(fwp_str_lossy(owner.buffer.d ? owner.buffer.d : "", owner.buffer.len)); \
    owner.row = fwp_private_cons_owned(owner.field, owner.row); \
    owner.field = 0; owner.buffer.len = 0; \
} while (0)
#define CSV_OWNED_ROW() do { \
    owner.row = fwp_private_reverse_owned(owner.row); \
    owner.rows = fwp_private_cons_owned(owner.row, owner.rows); \
    owner.row = 0; \
} while (0)
    while (i < n) {
        char c = s[i];
        if (at_start && c == '"') {
            i++;
            while (i < n) {
                if (s[i] == '"') {
                    if (i + 1 < n && s[i + 1] == '"') { buf_putc(&owner.buffer, '"'); i += 2; continue; }
                    i++;
                    break;
                }
                buf_putc(&owner.buffer, s[i++]);
            }
            at_start = 0; any = 1;
            continue;
        }
        if (c == sep) { CSV_OWNED_FIELD(); at_start = 1; any = 1; i++; continue; }
        if (c == '\n' || (c == '\r' && i + 1 < n && s[i + 1] == '\n')) {
            i += c == '\r' ? 2 : 1;
            if (any) { CSV_OWNED_FIELD(); CSV_OWNED_ROW(); }
            owner.buffer.len = 0; at_start = 1; any = 0;
            continue;
        }
        buf_putc(&owner.buffer, c);
        at_start = 0; any = 1; i++;
    }
    if (any) { CSV_OWNED_FIELD(); CSV_OWNED_ROW(); }
#undef CSV_OWNED_FIELD
#undef CSV_OWNED_ROW
    V result = fwp_private_reverse_owned(owner.rows);
    owner.rows = 0;
    fwp_cleanup_pop(&cleanup);
    fwp_csv_release(&owner);


    return result;
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
static V fwp_p_csv_decode(V rows, const fwp_desc *result_type, const char *const *tnames, const char *rname) {
    const fwp_desc *list = result_type->vfields[0][0];
    const fwp_desc *d = list->elem, *string = result_type->vfields[1][0];
    fwp_decode_fields result;
    fwp_decode_fields_begin(&result, 1, result_type->vfields[0], 1, NULL);
    fwp_decode_fields records;
    fwp_decode_fields_begin(&records, 0, NULL, 0, d);
    V err = 0;
    if (rname) { err = fwp_rc_fresh(fwp_strf("`%s` is not a record with named fields", rname)); goto finish; }
    if (rows) {
        int nf = d->n;
        V header = OBJ(rows)->f[0];
        size_t hn = fwp_list_len(header), nr = fwp_list_len(OBJ(rows)->f[1]);
        fwp_decode_fields_resize(&records, nr);
        fwp_decode_fields headers;
        fwp_decode_fields_begin(&headers, hn, NULL, 0, string);
        size_t k = 0;
        for (V l = header; l; l = OBJ(l)->f[1]) headers.values[k++] = fwp_rc_fresh(fwp_csv_column(OBJ(l)->f[0]));
        int *cols = fwp_mem_alloc((size_t)(nf + 1) * sizeof(int));
        headers.scratch = cols;
        for (int j = 0; j < nf; j++) {
            cols[j] = -1;
            for (size_t c = 0; c < hn && cols[j] < 0; c++)
                if (strcmp(STR(headers.values[c])->d, d->names[j]) == 0) cols[j] = (int)c;
            if (cols[j] < 0 && !fwp_is_option(d->fields[j])) {
                err = fwp_rc_fresh(fwp_strf("missing column `%s`", d->names[j]));
                break;
            }
        }
        size_t row_index = 0;
        for (V l = OBJ(rows)->f[1]; l && !err; l = OBJ(l)->f[1], row_index++) {
            V row = OBJ(l)->f[0];
            fwp_decode_fields cells;
            fwp_decode_fields_begin(&cells, fwp_list_len(row), NULL, 0, string);
            cells.transferred = 1; /* borrowed cells, protected by rows */
            k = 0;
            for (V c = row; c; c = OBJ(c)->f[1]) cells.values[k++] = OBJ(c)->f[0];
            fwp_decode_fields fields;
            fwp_decode_fields_begin(&fields, (size_t)nf, d->fields, (size_t)nf, NULL);
            for (int j = 0; j < nf; j++) {
                V t = cols[j] >= 0 && (size_t)cols[j] < cells.count ? cells.values[cols[j]] : 0;
                const char *text = t ? STR(t)->d : "";
                size_t length = t ? STR(t)->len : 0;
                const fwp_desc *fd = d->fields[j];
                V message = 0;
                int ok;
                if (fwp_is_option(fd)) {
                    if (!t || fwp_blank(t)) { fields.values[j] = FWP_NONE; continue; }
                    fwp_decode_fields option;
                    fwp_decode_fields_begin(&option, 1, fd->vfields[1], 1, NULL);
                    ok = fwp_cli_value(text, length, fd->vfields[1][0], tnames[j], &option.values[0], &message);
                    if (ok) fields.values[j] = fwp_decode_variant(&option, 1);
                    else fwp_decode_fields_end(&option, 0);
                } else {
                    ok = fwp_cli_value(text, length, fd, tnames[j], &fields.values[j], &message);
                }
                if (!ok) {
                    fwp_value_owner owner = {fwp_rc_fresh(message), string->drop};
                    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_value_release, &owner);
                    err = fwp_rc_fresh(fwp_strf("row %zu: column `%s`: %s", row_index + 2, d->names[j], STR(message)->d));
                    fwp_cleanup_pop(&cleanup);
                    if (string->drop) string->drop(message);
                    break;
                }
            }
            if (!err) records.values[row_index] = fwp_decode_record(&fields);
            else fwp_decode_fields_end(&fields, 0);
            fwp_decode_fields_end(&cells, 1);
        }
        fwp_decode_fields_end(&headers, 0);
    }
finish:
    if (err) {
        fwp_decode_fields_end(&records, 0);
        result.descs = result_type->vfields[1];
        result.values[0] = err;
    } else {
        result.values[0] = fwp_decode_sequence(&records, list);
    }
    V value = fwp_decode_variant(&result, err ? 1 : 0);

    return value;
}
