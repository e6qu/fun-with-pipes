/* Structural operations driven by type descriptors: the canonical text
 * format, total order, equality, binary encoding and hashing. These must
 * agree byte for byte with the interpreter (src/value.rs, src/proto.rs). */

/* ---------------------------------------------------------------- buffers */

typedef struct { char *d; size_t len, cap; } fwp_buf;

static void buf_grow(fwp_buf *b, size_t extra) {
    if (b->len + extra + 1 > b->cap) {
        size_t cap = b->cap ? b->cap : 64;
        while (cap < b->len + extra + 1) cap *= 2;
        b->d = (char *)realloc(b->d, cap);
        b->cap = cap;
    }
}
static void buf_put(fwp_buf *b, const char *s, size_t n) {
    buf_grow(b, n);
    memcpy(b->d + b->len, s, n);
    b->len += n;
    b->d[b->len] = 0;
}
static void buf_puts(fwp_buf *b, const char *s) { buf_put(b, s, strlen(s)); }
static void buf_putc(fwp_buf *b, char c) { buf_put(b, &c, 1); }
static V buf_to_str(fwp_buf *b) {
    V r = fwp_str_new(b->d ? b->d : "", b->len);
    free(b->d);
    return r;
}

/* ------------------------------------------------------------------ floats */

/* p significant digits: fixed notation for exponents in [-5, 16], C-style
 * scientific otherwise (mirrors format_g in src/value.rs). */
static void fwp_format_g(char *out, size_t cap, double x, int p) {
    char sci[64];
    snprintf(sci, sizeof sci, "%.*e", p - 1, x);
    char *e = strchr(sci, 'e');
    int exp = atoi(e + 1);
    if (exp < -5 || exp > 16) {
        char mant[64];
        size_t ml = (size_t)(e - sci);
        memcpy(mant, sci, ml);
        mant[ml] = 0;
        if (strchr(mant, '.')) {
            while (ml > 0 && mant[ml - 1] == '0') mant[--ml] = 0;
            if (ml > 0 && mant[ml - 1] == '.') mant[--ml] = 0;
        }
        snprintf(out, cap, "%se%c%02d", mant, exp < 0 ? '-' : '+', exp < 0 ? -exp : exp);
    } else {
        int decimals = p - 1 - exp;
        if (decimals < 0) decimals = 0;
        snprintf(out, cap, "%.*f", decimals, x);
        size_t l = strlen(out);
        if (strchr(out, '.')) {
            while (l > 0 && out[l - 1] == '0') out[--l] = 0;
            if (l > 0 && out[l - 1] == '.') out[--l] = 0;
        }
    }
}

static void fwp_finish_float(char *s) {
    if (!strchr(s, '.') && !strchr(s, 'e') && !strstr(s, "inf") && !strstr(s, "NaN"))
        strcat(s, ".0");
}

static void fwp_fmt_f64(char *out, double x) {
    if (isnan(x)) { strcpy(out, "NaN"); return; }
    if (isinf(x)) { strcpy(out, x > 0 ? "inf" : "-inf"); return; }
    for (int p = 1; p <= 17; p++) {
        fwp_format_g(out, 400, x, p);
        if (strtod(out, 0) == x) { fwp_finish_float(out); return; }
    }
    fwp_format_g(out, 400, x, 17);
    fwp_finish_float(out);
}

static void fwp_fmt_f32(char *out, float x) {
    if (isnan(x)) { strcpy(out, "NaN"); return; }
    if (isinf(x)) { strcpy(out, x > 0 ? "inf" : "-inf"); return; }
    for (int p = 1; p <= 9; p++) {
        fwp_format_g(out, 400, (double)x, p);
        if (strtof(out, 0) == x) { fwp_finish_float(out); return; }
    }
    fwp_format_g(out, 400, (double)x, 9);
    fwp_finish_float(out);
}

static void fwp_fmt_u128(char *out, u128 x) {
    char tmp[64];
    int i = 0;
    if (x == 0) tmp[i++] = '0';
    while (x > 0) { tmp[i++] = (char)('0' + (int)(x % 10)); x /= 10; }
    int j = 0;
    while (i > 0) out[j++] = tmp[--i];
    out[j] = 0;
}

static void fwp_fmt_i128(char *out, i128 x) {
    if (x < 0) {
        out[0] = '-';
        fwp_fmt_u128(out + 1, (u128)0 - (u128)x);
    } else {
        fwp_fmt_u128(out, (u128)x);
    }
}

static void fwp_fmt_duration(char *out, i128 ns) {
    static const struct { const char *u; long long s; } units[] = {
        {"h", 3600000000000LL}, {"min", 60000000000LL}, {"s", 1000000000LL},
        {"ms", 1000000LL}, {"us", 1000LL}};
    for (int i = 0; i < 5; i++) {
        if (ns != 0 && ns % units[i].s == 0) {
            char n[64];
            fwp_fmt_i128(n, ns / units[i].s);
            sprintf(out, "%s%s", n, units[i].u);
            return;
        }
    }
    char n[64];
    fwp_fmt_i128(n, ns);
    sprintf(out, "%sns", n);
}

/* balanced ternary digits of v, most significant first, as "0t..."
 * (widths are bounded at compile time, but the buffer is sized by width) */
static void fwp_trits(fwp_buf *b, int64_t v, int width) {
    char *tmp = (char *)fwp_alloc((size_t)width + 3);
    tmp[0] = '0';
    tmp[1] = 't';
    for (int i = 0; i < width; i++) {
        int64_t r = ((v % 3) + 3) % 3;
        int carry = 0;
        char d;
        if (r == 0) d = '0';
        else if (r == 1) d = '+';
        else { d = '-'; carry = 1; }
        tmp[2 + width - 1 - i] = d;
        int64_t q = v / 3;
        if (v % 3 != 0 && v < 0) q -= 1; /* floor division */
        v = q + carry;
    }
    tmp[2 + width] = 0;
    buf_puts(b, tmp);
}

/* --------------------------------------------------------------- display */

static void fwp_escape(fwp_buf *b, const char *s, size_t n) {
    buf_putc(b, '"');
    for (size_t i = 0; i < n; i++) {
        unsigned char c = (unsigned char)s[i];
        switch (c) {
        case '"': buf_puts(b, "\\\""); break;
        case '\\': buf_puts(b, "\\\\"); break;
        case '\n': buf_puts(b, "\\n"); break;
        case '\t': buf_puts(b, "\\t"); break;
        case '\r': buf_puts(b, "\\r"); break;
        default:
            if (c < 0x20 || c == 0x7f) {
                char t[16];
                snprintf(t, sizeof t, "\\u{%x}", c);
                buf_puts(b, t);
            } else {
                buf_putc(b, (char)c);
            }
        }
    }
    buf_putc(b, '"');
}

static int fwp_is_negative(V v, const fwp_desc *d) {
    switch (d->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64: return (int64_t)v < 0;
    case K_I128: return fwp_i128(v) < 0;
    case K_F32: return signbit(fwp_f32(v)) != 0;
    case K_F64: return signbit(fwp_f64(v)) != 0;
    default: return 0;
    }
}

static int fwp_needs_parens(V v, const fwp_desc *d) {
    if (d->kind == K_ADT) return v >= 4096;
    if (d->kind == K_RECORD && d->name) return strcmp(d->name, "Duration") != 0;
    return fwp_is_negative(v, d);
}

static void fwp_write(fwp_buf *b, V v, const fwp_desc *d, int top) {
    char t[512];
    switch (d->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64:
        snprintf(t, sizeof t, "%lld", (long long)(int64_t)v); buf_puts(b, t); return;
    case K_U8: case K_U16: case K_U32: case K_U64:
        snprintf(t, sizeof t, "%llu", (unsigned long long)v); buf_puts(b, t); return;
    case K_I128: fwp_fmt_i128(t, fwp_i128(v)); buf_puts(b, t); return;
    case K_U128: fwp_fmt_u128(t, fwp_u128(v)); buf_puts(b, t); return;
    case K_F32: fwp_fmt_f32(t, fwp_f32(v)); buf_puts(b, t); return;
    case K_F64: fwp_fmt_f64(t, fwp_f64(v)); buf_puts(b, t); return;
    case K_TINT: fwp_trits(b, (int64_t)v, d->width); return;
    case K_TRIT: buf_puts(b, (int64_t)v == 1 ? "+1" : (int64_t)v == -1 ? "-1" : "0"); return;
    case K_FUN: buf_puts(b, "<function>"); return;
    case K_OPAQUE: buf_puts(b, "<opaque>"); return;
    case K_NATIVE: buf_putc(b, '<'); buf_puts(b, d->name); buf_putc(b, '>'); return;
    case K_FILE: {
        fwp_file *f = (fwp_file *)(uintptr_t)v;
        buf_puts(b, "<file ");
        buf_puts(b, f->path);
        buf_putc(b, '>');
        return;
    }
    case K_STR:
        if (top) buf_put(b, STR(v)->d, STR(v)->len);
        else fwp_escape(b, STR(v)->d, STR(v)->len);
        return;
    case K_BYTES: {
        buf_puts(b, "bytes[");
        for (uint64_t i = 0; i < STR(v)->len; i++) {
            if (i) buf_puts(b, ", ");
            snprintf(t, sizeof t, "%u", (unsigned char)STR(v)->d[i]);
            buf_puts(b, t);
        }
        buf_putc(b, ']');
        return;
    }
    case K_LIST: {
        buf_putc(b, '[');
        int first = 1;
        while (v != 0) {
            if (!first) buf_puts(b, ", ");
            first = 0;
            fwp_write(b, OBJ(v)->f[0], d->elem, 0);
            v = OBJ(v)->f[1];
        }
        buf_putc(b, ']');
        return;
    }
    case K_ARRAY: {
        buf_puts(b, "array[");
        for (uint64_t i = 0; i < ARR(v)->len; i++) {
            if (i) buf_puts(b, ", ");
            fwp_write(b, ARR(v)->d[i], d->elem, 0);
        }
        buf_putc(b, ']');
        return;
    }
    case K_MAP: case K_SET: {
        buf_puts(b, d->kind == K_SET ? "set{" : "map{");
        for (uint64_t i = 0; i < MAP(v)->len; i++) {
            if (i) buf_puts(b, ", ");
            fwp_write(b, MAP(v)->d[2 * i], d->elem, 0);
            if (d->kind == K_MAP) {
                buf_puts(b, ": ");
                fwp_write(b, MAP(v)->d[2 * i + 1], d->elem2, 0);
            }
        }
        buf_putc(b, '}');
        return;
    }
    case K_RECORD: {
        if (d->name && strcmp(d->name, "Duration") == 0) {
            fwp_fmt_duration(t, (int64_t)OBJ(v)->f[0]);
            buf_puts(b, t);
            return;
        }
        if (d->n == 0 && !d->name) { buf_puts(b, "()"); return; }
        int tuple = d->width && !d->name;
        if (d->name) { buf_puts(b, d->name); buf_putc(b, ' '); }
        buf_putc(b, tuple ? '(' : '{');
        for (int i = 0; i < d->n; i++) {
            if (i) buf_puts(b, ", ");
            if (!tuple) { buf_puts(b, d->names[i]); buf_puts(b, " = "); }
            fwp_write(b, OBJ(v)->f[i], d->fields[i], 0);
        }
        buf_putc(b, tuple ? ')' : '}');
        return;
    }
    case K_ADT: {
        uint32_t tag = fwp_tag(v);
        buf_puts(b, d->names[tag]);
        for (int i = 0; i < d->arity[tag]; i++) {
            V x = OBJ(v)->f[i];
            const fwp_desc *fd = d->vfields[tag][i];
            buf_putc(b, ' ');
            if (fwp_needs_parens(x, fd)) {
                buf_putc(b, '(');
                fwp_write(b, x, fd, 0);
                buf_putc(b, ')');
            } else {
                fwp_write(b, x, fd, 0);
            }
        }
        return;
    }
    }
}

static V fwp_show(V v, const fwp_desc *d) {
    fwp_buf b = {0};
    fwp_write(&b, v, d, 1);
    return buf_to_str(&b);
}

static void fwp_display_top(V v, const fwp_desc *d, FILE *out) {
    fwp_buf b = {0};
    fwp_write(&b, v, d, 1);
    if (b.d) fwrite(b.d, 1, b.len, out);
    free(b.d);
}

/* ----------------------------------------------------------- total order */

static int64_t fwp_total_key64(double x) {
    int64_t i;
    memcpy(&i, &x, 8);
    i ^= (int64_t)(((uint64_t)(i >> 63)) >> 1);
    return i;
}
static int32_t fwp_total_key32(float x) {
    int32_t i;
    memcpy(&i, &x, 4);
    i ^= (int32_t)(((uint32_t)(i >> 31)) >> 1);
    return i;
}

#define CMP(a, b) ((a) < (b) ? -1 : (a) > (b) ? 1 : 0)

static int fwp_cmp(V a, V b, const fwp_desc *d) {
    switch (d->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64: case K_TINT: case K_TRIT:
        return CMP((int64_t)a, (int64_t)b);
    case K_U8: case K_U16: case K_U32: case K_U64: return CMP(a, b);
    case K_I128: return CMP(fwp_i128(a), fwp_i128(b));
    case K_U128: return CMP(fwp_u128(a), fwp_u128(b));
    case K_F32: return CMP(fwp_total_key32(fwp_f32(a)), fwp_total_key32(fwp_f32(b)));
    case K_F64: return CMP(fwp_total_key64(fwp_f64(a)), fwp_total_key64(fwp_f64(b)));
    case K_STR: case K_BYTES: {
        uint64_t la = STR(a)->len, lb = STR(b)->len;
        int c = memcmp(STR(a)->d, STR(b)->d, la < lb ? la : lb);
        if (c) return c < 0 ? -1 : 1;
        return CMP(la, lb);
    }
    case K_LIST:
        for (;;) {
            if (a == 0 || b == 0) return CMP(a != 0, b != 0);
            int c = fwp_cmp(OBJ(a)->f[0], OBJ(b)->f[0], d->elem);
            if (c) return c;
            a = OBJ(a)->f[1];
            b = OBJ(b)->f[1];
        }
    case K_ARRAY: {
        uint64_t la = ARR(a)->len, lb = ARR(b)->len;
        for (uint64_t i = 0; i < la && i < lb; i++) {
            int c = fwp_cmp(ARR(a)->d[i], ARR(b)->d[i], d->elem);
            if (c) return c;
        }
        return CMP(la, lb);
    }
    case K_MAP: case K_SET: {
        uint64_t la = MAP(a)->len, lb = MAP(b)->len;
        for (uint64_t i = 0; i < la && i < lb; i++) {
            int c = fwp_cmp(MAP(a)->d[2 * i], MAP(b)->d[2 * i], d->elem);
            if (c) return c;
            if (d->kind == K_MAP) {
                c = fwp_cmp(MAP(a)->d[2 * i + 1], MAP(b)->d[2 * i + 1], d->elem2);
                if (c) return c;
            }
        }
        return CMP(la, lb);
    }
    case K_RECORD:
        for (int i = 0; i < d->n; i++) {
            int c = fwp_cmp(OBJ(a)->f[i], OBJ(b)->f[i], d->fields[i]);
            if (c) return c;
        }
        return 0;
    case K_ADT: {
        uint32_t ta = fwp_tag(a), tb = fwp_tag(b);
        if (ta != tb) return CMP(ta, tb);
        for (int i = 0; i < d->arity[ta]; i++) {
            int c = fwp_cmp(OBJ(a)->f[i], OBJ(b)->f[i], d->vfields[ta][i]);
            if (c) return c;
        }
        return 0;
    }
    default: return CMP(a, b);
    }
}

/* Equality as seen by programs: IEEE for floats (also nested in data,
 * records, lists and arrays); total order elsewhere. */
static int fwp_eq(V a, V b, const fwp_desc *d) {
    switch (d->kind) {
    case K_F32: return fwp_f32(a) == fwp_f32(b);
    case K_F64: return fwp_f64(a) == fwp_f64(b);
    case K_LIST:
        for (;;) {
            if (a == 0 || b == 0) return a == b;
            if (!fwp_eq(OBJ(a)->f[0], OBJ(b)->f[0], d->elem)) return 0;
            a = OBJ(a)->f[1];
            b = OBJ(b)->f[1];
        }
    case K_ARRAY:
        if (ARR(a)->len != ARR(b)->len) return 0;
        for (uint64_t i = 0; i < ARR(a)->len; i++)
            if (!fwp_eq(ARR(a)->d[i], ARR(b)->d[i], d->elem)) return 0;
        return 1;
    case K_RECORD:
        for (int i = 0; i < d->n; i++)
            if (!fwp_eq(OBJ(a)->f[i], OBJ(b)->f[i], d->fields[i])) return 0;
        return 1;
    case K_ADT: {
        uint32_t ta = fwp_tag(a), tb = fwp_tag(b);
        if (ta != tb) return 0;
        for (int i = 0; i < d->arity[ta]; i++)
            if (!fwp_eq(OBJ(a)->f[i], OBJ(b)->f[i], d->vfields[ta][i])) return 0;
        return 1;
    }
    default: return fwp_cmp(a, b, d) == 0;
    }
}

/* IEEE partial order for lt/le/gt/ge at the top level (2 = unordered). */
static int fwp_partial_cmp(V a, V b, const fwp_desc *d) {
    if (d->kind == K_F64) {
        double x = fwp_f64(a), y = fwp_f64(b);
        if (isnan(x) || isnan(y)) return 2;
        return CMP(x, y);
    }
    if (d->kind == K_F32) {
        float x = fwp_f32(a), y = fwp_f32(b);
        if (isnan(x) || isnan(y)) return 2;
        return CMP(x, y);
    }
    return fwp_cmp(a, b, d);
}

/* --------------------------------------------------------------- encoding */

static void fwp_leb128(fwp_buf *b, uint64_t x) {
    for (;;) {
        unsigned char c = x & 0x7f;
        x >>= 7;
        if (x == 0) { buf_putc(b, (char)c); return; }
        buf_putc(b, (char)(c | 0x80));
    }
}

static void fwp_le(fwp_buf *b, uint64_t x, int n) {
    for (int i = 0; i < n; i++) buf_putc(b, (char)((x >> (8 * i)) & 0xff));
}

static void fwp_encode(fwp_buf *b, V v, const fwp_desc *d) {
    switch (d->kind) {
    case K_I8: case K_U8: case K_TRIT: fwp_le(b, v, 1); return;
    case K_I16: case K_U16: fwp_le(b, v, 2); return;
    case K_I32: case K_U32: case K_F32: fwp_le(b, v, 4); return;
    case K_I64: case K_U64: case K_F64: case K_TINT: fwp_le(b, v, 8); return;
    case K_I128: case K_U128: {
        u128 x = d->kind == K_I128 ? (u128)fwp_i128(v) : fwp_u128(v);
        fwp_le(b, (uint64_t)x, 8);
        fwp_le(b, (uint64_t)(x >> 64), 8);
        return;
    }
    case K_STR: case K_BYTES:
        fwp_leb128(b, STR(v)->len);
        buf_put(b, STR(v)->d, STR(v)->len);
        return;
    case K_LIST: {
        fwp_leb128(b, fwp_list_len(v));
        while (v != 0) { fwp_encode(b, OBJ(v)->f[0], d->elem); v = OBJ(v)->f[1]; }
        return;
    }
    case K_ARRAY:
        fwp_leb128(b, ARR(v)->len);
        for (uint64_t i = 0; i < ARR(v)->len; i++) fwp_encode(b, ARR(v)->d[i], d->elem);
        return;
    case K_MAP: case K_SET:
        fwp_leb128(b, MAP(v)->len);
        for (uint64_t i = 0; i < MAP(v)->len; i++) {
            fwp_encode(b, MAP(v)->d[2 * i], d->elem);
            if (d->kind == K_MAP) fwp_encode(b, MAP(v)->d[2 * i + 1], d->elem2);
        }
        return;
    case K_RECORD:
        for (int i = 0; i < d->n; i++) fwp_encode(b, OBJ(v)->f[i], d->fields[i]);
        return;
    case K_ADT: {
        uint32_t tag = fwp_tag(v);
        fwp_leb128(b, tag);
        for (int i = 0; i < d->arity[tag]; i++) fwp_encode(b, OBJ(v)->f[i], d->vfields[tag][i]);
        return;
    }
    default: return;
    }
}

static uint64_t fwp_hash(V v, const fwp_desc *d) {
    fwp_buf b = {0};
    fwp_encode(&b, v, d);
    uint64_t h = 0xcbf29ce484222325ULL;
    for (size_t i = 0; i < b.len; i++) {
        h ^= (unsigned char)b.d[i];
        h *= 0x100000001b3ULL;
    }
    free(b.d);
    return h;
}
