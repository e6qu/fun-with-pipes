/* Structural operations driven by type descriptors: the canonical text
 * format, total order, equality, binary encoding and hashing. These must
 * agree byte for byte with the interpreter (src/value.rs, src/proto.rs). */

/* ---------------------------------------------------------------- buffers */

typedef struct { char *d; size_t len, cap; } fwp_buf;

static void buf_grow(fwp_buf *b, size_t extra) {
    if (b->len == SIZE_MAX || extra > SIZE_MAX - b->len - 1) {
        fprintf(stderr, "fwp: out of memory\n");
        fflush(NULL); _Exit(102);
    }
    size_t needed = b->len + extra + 1;
    if (needed > b->cap) {
        size_t cap = b->cap ? b->cap : 64;
        while (cap < needed) {
            if (cap > SIZE_MAX / 2) { cap = needed; break; }
            cap *= 2;
        }
        char *data = (char *)realloc(b->d, cap);
        if (!data) {
            fprintf(stderr, "fwp: out of memory\n");
            fflush(NULL); _Exit(102);
        }
        b->d = data;
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
        if (decimals <= 0 || p == 1) {
            /* Integer output prints the exact rounded integer even when it has
             * more than p digits. At p=1 the scientific text has no decimal
             * separator to reuse (which can depend on the C locale). */
            if (decimals < 0) decimals = 0;
            snprintf(out, cap, "%.*f", decimals, x);
        } else {
            /* The scientific conversion already rounded these digits to the
             * required precision. Move its separator instead of performing a
             * second floating conversion. If rounding raised the exponent,
             * its mantissa is exactly 1 followed by zeros, also the fixed result.
             * Fixed exponents are at least -5, so eight extra bytes suffice. */
            char fixed[sizeof sci + 8];
            char *at = fixed;
            const char *first = sci + (sci[0] == '-');
            const char *fraction = e - (p - 1);
            size_t separator = (size_t)(fraction - first - 1);
            if (sci[0] == '-') *at++ = '-';
            if (exp < 0) {
                *at++ = '0';
                memcpy(at, first + 1, separator); at += separator;
                for (int i = 0; i < -exp - 1; i++) *at++ = '0';
                *at++ = *first;
                memcpy(at, fraction, (size_t)(p - 1)); at += p - 1;
            } else {
                *at++ = *first;
                memcpy(at, fraction, (size_t)exp); at += exp;
                memcpy(at, first + 1, separator); at += separator;
                memcpy(at, fraction + exp, (size_t)decimals); at += decimals;
            }
            size_t size = (size_t)(at - fixed);
            if (!cap) return;
            if (size >= cap) size = cap - 1;
            memcpy(out, fixed, size);
            out[size] = 0;
        }
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

#ifdef FWP_EXACT_FLOAT
static void fwp_fmt_exact(char *out, int k, V v) {
    float128_t bits = k == K_F128 ? fwp_f128(v) : (float128_t){{v, 0}};
    if (fwp_decimal_show(bits.v[0], bits.v[1], fwp_exact_format(k), out, 64) < 0) fwp_trap("out of memory");
    fwp_finish_float(out);
}
static u128 fwp_float_total_key(int k, V v) {
    u128 bits, sign;
    if (k == K_F128) { float128_t x = fwp_f128(v); bits = ((u128)x.v[1] << 64) | x.v[0]; sign = (u128)1 << 127; }
    else { bits = v; sign = (u128)1 << 15; }
    return bits & sign ? (~bits & (sign | (sign - 1))) : bits ^ sign;
}
#endif

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

/* Balanced ternary digits, written directly into the destination buffer. */
static void fwp_trits(fwp_buf *b, int64_t v, int width) {
    buf_grow(b, (size_t)width + 2);
    char *tmp = b->d + b->len;
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
    b->len += (size_t)width + 2;
    b->d[b->len] = 0;
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
#ifdef FWP_EXACT_FLOAT
    case K_F16: case K_BF16: return (v & 0x8000) != 0;
    case K_F128: return (fwp_f128(v).v[1] >> 63) != 0;
#endif
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
#ifdef FWP_EXACT_FLOAT
    case K_F16: case K_BF16: case K_F128: fwp_fmt_exact(t, d->kind, v); buf_puts(b, t); return;
#endif
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
        for (uint64_t i = 0; i < fwp_array_len(v); i++) {
            if (i) buf_puts(b, ", ");
            fwp_write(b, fwp_array_load(v, i, d->elem), d->elem, 0);
        }
        buf_putc(b, ']');
        return;
    }
    case K_MAP: case K_SET: {
        buf_puts(b, d->kind == K_SET ? "set{" : "map{");
        for (uint64_t i = 0; i < MAP(v)->len; i++) {
            if (i) buf_puts(b, ", ");
            fwp_write(b, MAP(v)->d[(d->kind == K_SET ? 1 : 2) * i], d->elem, 0);
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

/* The compiler proves that array.to-list is used only by show. Read the
 * borrowed numeric array directly while preserving the list's text syntax. */
static V fwp_show_array_list(V array, const fwp_desc *elem) {
    fwp_buf b = {0};
    buf_putc(&b, '[');
    uint64_t count = fwp_array_len(array);
    for (uint64_t i = 0; i < count; i++) {
        if (i) buf_puts(&b, ", ");
        fwp_write(&b, fwp_array_load(array, i, elem), elem, 0);
    }
    buf_putc(&b, ']');
    return buf_to_str(&b);
}

/* integers up to 64 bits: digits written backwards into a buffer, and
 * their count, without formatting through a descriptor */
static int fwp_u64_fmt(char *end, uint64_t x) {
    char *p = end;
    do { *--p = (char)('0' + x % 10); x /= 10; } while (x);
    return (int)(end - p);
}

static V fwp_show_u64(V v) {
    char b[24];
    int n = fwp_u64_fmt(b + sizeof b, (uint64_t)v);
    return fwp_str_new(b + sizeof b - n, (size_t)n);
}

static V fwp_show_i64(V v) {
    int64_t x = (int64_t)v;
    char b[24];
    uint64_t m = x < 0 ? (uint64_t)0 - (uint64_t)x : (uint64_t)x;
    int n = fwp_u64_fmt(b + sizeof b, m);
    if (x < 0) b[sizeof b - ++n] = '-';
    return fwp_str_new(b + sizeof b - n, (size_t)n);
}

static inline int64_t fwp_u64_chars(uint64_t x) {
    /* Split the 20 decimal-width intervals at exact powers of ten.
     * Zero belongs to the one-digit interval; every path uses at most
     * five comparisons, with no division or indexed table access. */
    if (x < UINT64_C(10000000000)) {
        if (x < UINT64_C(100000)) {
            if (x < UINT64_C(1000)) {
                if (x < UINT64_C(100)) {
                    return x < UINT64_C(10) ? 1 : 2;
                }
                return 3;
            }
            return x < UINT64_C(10000) ? 4 : 5;
        }
        if (x < UINT64_C(100000000)) {
            if (x < UINT64_C(10000000)) {
                return x < UINT64_C(1000000) ? 6 : 7;
            }
            return 8;
        }
        return x < UINT64_C(1000000000) ? 9 : 10;
    }
    if (x < UINT64_C(1000000000000000)) {
        if (x < UINT64_C(10000000000000)) {
            if (x < UINT64_C(1000000000000)) {
                return x < UINT64_C(100000000000) ? 11 : 12;
            }
            return 13;
        }
        return x < UINT64_C(100000000000000) ? 14 : 15;
    }
    if (x < UINT64_C(1000000000000000000)) {
        if (x < UINT64_C(100000000000000000)) {
            return x < UINT64_C(10000000000000000) ? 16 : 17;
        }
        return 18;
    }
    return x < UINT64_C(10000000000000000000) ? 19 : 20;
}

static inline int64_t fwp_i64_chars(int64_t x) {
    uint64_t magnitude = x < 0 ? (uint64_t)0 - (uint64_t)x : (uint64_t)x;
    return fwp_u64_chars(magnitude) + (x < 0);
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
#ifdef FWP_EXACT_FLOAT
    case K_F16: case K_BF16: case K_F128: return CMP(fwp_float_total_key(d->kind, a), fwp_float_total_key(d->kind, b));
#endif
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
        uint64_t la = fwp_array_len(a), lb = fwp_array_len(b);
        for (uint64_t i = 0; i < la && i < lb; i++) {
            int c = fwp_cmp(fwp_array_load(a, i, d->elem), fwp_array_load(b, i, d->elem), d->elem);
            if (c) return c;
        }
        return CMP(la, lb);
    }
    case K_MAP: case K_SET: {
        uint64_t la = MAP(a)->len, lb = MAP(b)->len;
        for (uint64_t i = 0; i < la && i < lb; i++) {
            int c = fwp_cmp(MAP(a)->d[(d->kind == K_SET ? 1 : 2) * i], MAP(b)->d[(d->kind == K_SET ? 1 : 2) * i], d->elem);
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
#ifdef FWP_EXACT_FLOAT
    case K_F16: case K_BF16: case K_F128: return fwp_f128_compare(fwp_float_quad(d->kind, a), fwp_float_quad(d->kind, b)) == 0;
#endif
    case K_LIST:
        for (;;) {
            if (a == 0 || b == 0) return a == b;
            if (!fwp_eq(OBJ(a)->f[0], OBJ(b)->f[0], d->elem)) return 0;
            a = OBJ(a)->f[1];
            b = OBJ(b)->f[1];
        }
    case K_ARRAY:
        if (fwp_array_len(a) != fwp_array_len(b)) return 0;
        for (uint64_t i = 0; i < fwp_array_len(a); i++)
            if (!fwp_eq(fwp_array_load(a, i, d->elem), fwp_array_load(b, i, d->elem), d->elem)) return 0;
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
#ifdef FWP_EXACT_FLOAT
    if (d->kind == K_F16 || d->kind == K_BF16 || d->kind == K_F128)
        return fwp_f128_compare(fwp_float_quad(d->kind, a), fwp_float_quad(d->kind, b));
#endif
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
    case K_I16: case K_U16: case K_F16: case K_BF16: fwp_le(b, v, 2); return;
    case K_I32: case K_U32: case K_F32: fwp_le(b, v, 4); return;
    case K_I64: case K_U64: case K_F64: case K_TINT: fwp_le(b, v, 8); return;
#ifdef FWP_EXACT_FLOAT
    case K_F128: { float128_t x = fwp_f128(v); fwp_le(b, x.v[0], 8); fwp_le(b, x.v[1], 8); return; }
#endif
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
        fwp_leb128(b, fwp_array_len(v));
        for (uint64_t i = 0; i < fwp_array_len(v); i++) fwp_encode(b, fwp_array_load(v, i, d->elem), d->elem);
        return;
    case K_MAP: case K_SET:
        fwp_leb128(b, MAP(v)->len);
        for (uint64_t i = 0; i < MAP(v)->len; i++) {
            fwp_encode(b, MAP(v)->d[(d->kind == K_SET ? 1 : 2) * i], d->elem);
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

/* Hash the canonical encoding as a stream, without a temporary byte buffer.
 * Keep this traversal in agreement with fwp_encode and src/proto.rs. */
static uint64_t fwp_hash_le(uint64_t h, uint64_t x, int n) {
    for (int i = 0; i < n; i++) {
        h ^= (x >> (8 * i)) & 0xff;
        h *= 0x100000001b3ULL;
    }
    return h;
}
static uint64_t fwp_hash_leb128(uint64_t h, uint64_t x) {
    for (;;) {
        unsigned char c = x & 0x7f;
        x >>= 7;
        h = fwp_hash_le(h, c | (x ? 0x80 : 0), 1);
        if (!x) return h;
    }
}
static uint64_t fwp_hash_value(uint64_t h, V v, const fwp_desc *d) {
    switch (d->kind) {
    case K_I8: case K_U8: case K_TRIT: return fwp_hash_le(h, v, 1);
    case K_I16: case K_U16: case K_F16: case K_BF16: return fwp_hash_le(h, v, 2);
    case K_I32: case K_U32: case K_F32: return fwp_hash_le(h, v, 4);
    case K_I64: case K_U64: case K_F64: case K_TINT: return fwp_hash_le(h, v, 8);
#ifdef FWP_EXACT_FLOAT
    case K_F128: {
        float128_t x = fwp_f128(v);
        return fwp_hash_le(fwp_hash_le(h, x.v[0], 8), x.v[1], 8);
    }
#endif
    case K_I128: case K_U128: {
        u128 x = d->kind == K_I128 ? (u128)fwp_i128(v) : fwp_u128(v);
        return fwp_hash_le(fwp_hash_le(h, (uint64_t)x, 8), (uint64_t)(x >> 64), 8);
    }
    case K_STR: case K_BYTES:
        h = fwp_hash_leb128(h, STR(v)->len);
        for (uint64_t i = 0; i < STR(v)->len; i++) {
            h ^= (unsigned char)STR(v)->d[i]; h *= 0x100000001b3ULL;
        }
        return h;
    case K_LIST:
        h = fwp_hash_leb128(h, fwp_list_len(v));
        while (v) { h = fwp_hash_value(h, OBJ(v)->f[0], d->elem); v = OBJ(v)->f[1]; }
        return h;
    case K_ARRAY:
        h = fwp_hash_leb128(h, fwp_array_len(v));
        for (uint64_t i = 0; i < fwp_array_len(v); i++)
            h = fwp_hash_value(h, fwp_array_load(v, i, d->elem), d->elem);
        return h;
    case K_MAP: case K_SET:
        h = fwp_hash_leb128(h, MAP(v)->len);
        for (uint64_t i = 0; i < MAP(v)->len; i++) {
            h = fwp_hash_value(h, MAP(v)->d[(d->kind == K_SET ? 1 : 2) * i], d->elem);
            if (d->kind == K_MAP) h = fwp_hash_value(h, MAP(v)->d[2 * i + 1], d->elem2);
        }
        return h;
    case K_RECORD:
        for (int i = 0; i < d->n; i++) h = fwp_hash_value(h, OBJ(v)->f[i], d->fields[i]);
        return h;
    case K_ADT: {
        uint32_t tag = fwp_tag(v);
        h = fwp_hash_leb128(h, tag);
        for (int i = 0; i < d->arity[tag]; i++)
            h = fwp_hash_value(h, OBJ(v)->f[i], d->vfields[tag][i]);
        return h;
    }
    default: return h;
    }
}
static uint64_t fwp_hash(V v, const fwp_desc *d) {
    return fwp_hash_value(0xcbf29ce484222325ULL, v, d);
}
