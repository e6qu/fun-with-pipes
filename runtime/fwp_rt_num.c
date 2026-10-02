/* Numeric primitives by kind (mirroring src/interp.rs). Operands arrive
 * already in "subject op argument" order. */

enum { OP_ADD, OP_SUB, OP_MUL, OP_DIV, OP_REM };

/* value -> i128 for integer kinds (U128 above i128 max not representable;
 * callers handle U128 separately) */
static i128 fwp_as_i128(int k, V v) {
    switch (k) {
    case K_I8: case K_I16: case K_I32: case K_I64: case K_TINT: case K_TRIT: return (int64_t)v;
    case K_U8: case K_U16: case K_U32: case K_U64: return (i128)v;
    case K_I128: return fwp_i128(v);
    case K_U128: return (i128)fwp_u128(v);
    default: return 0;
    }
}

static double fwp_as_f64(int k, V v) { return k == K_F32 ? (double)fwp_f32(v) : fwp_f64(v); }

static i128 fwp_tint_max(int w) {
    i128 p = 1;
    for (int i = 0; i < w && i < 80; i++) p *= 3;
    return (p - 1) / 2;
}

/* checked conversion of an integer to kind k; 0 if out of range */
static int fwp_int_fits(i128 x, int k, int w, V *out) {
    switch (k) {
    case K_I8: if (x < -128 || x > 127) return 0; *out = (V)(int64_t)x; return 1;
    case K_I16: if (x < -32768 || x > 32767) return 0; *out = (V)(int64_t)x; return 1;
    case K_I32: if (x < -2147483648LL || x > 2147483647LL) return 0; *out = (V)(int64_t)x; return 1;
    case K_I64: if (x < (i128)INT64_MIN || x > (i128)INT64_MAX) return 0; *out = (V)(int64_t)x; return 1;
    case K_I128: *out = fwp_box_i128(x); return 1;
    case K_U8: if (x < 0 || x > 255) return 0; *out = (V)x; return 1;
    case K_U16: if (x < 0 || x > 65535) return 0; *out = (V)x; return 1;
    case K_U32: if (x < 0 || x > 4294967295LL) return 0; *out = (V)x; return 1;
    case K_U64: if (x < 0 || x > (i128)UINT64_MAX) return 0; *out = (V)(uint64_t)x; return 1;
    case K_U128: if (x < 0) return 0; *out = fwp_box_u128((u128)x); return 1;
    case K_TINT: {
        i128 m = fwp_tint_max(w);
        if (x > m || x < -m) return 0;
        *out = (V)(int64_t)x;
        return 1;
    }
    default: return 0;
    }
}

static V fwp_int_in_range(int neg, u128 mag, int k, int w, V *out) {
    if (k == K_U128) {
        if (neg && mag != 0) return 0;
        *out = fwp_box_u128(mag);
        return 1;
    }
    if (mag > (u128)1 << 127) return 0;
    if (!neg && mag == (u128)1 << 127) return 0;
    i128 x = neg ? -(i128)mag : (i128)mag;
    if (neg && mag == (u128)1 << 127) x = (i128)((u128)1 << 127);
    return (V)fwp_int_fits(x, k, w, out);
}

static V fwp_float_of(int k, double x) { return k == K_F32 ? fwp_from_f32((float)x) : fwp_from_f64(x); }

static void fwp_fmt_i128(char *out, i128 x);

/* integer constant of kind k (traps when out of range) */
static V fwp_from_i128(int k, i128 x, const char *name, int w) {
    V out;
    if (k == K_F32 || k == K_F64) return fwp_float_of(k, (double)x);
    if (fwp_int_fits(x, k, w, &out)) return out;
    char n[64], buf[160];
    fwp_fmt_i128(n, x);
    snprintf(buf, sizeof buf, "integer %s does not fit in %s", n, name);
    fwp_trap(buf);
    return 0;
}

/* a op b; returns 0 on overflow / division by zero (and sets *err: 1
 * overflow, 2 division by zero) */
static int fwp_arith_raw(int k, int op, V a, V b, int w, V *out, int *err) {
    *err = 0;
    if (k == K_F32) {
        float x = fwp_f32(a), y = fwp_f32(b), r;
        switch (op) {
        case OP_ADD: r = x + y; break;
        case OP_SUB: r = x - y; break;
        case OP_MUL: r = x * y; break;
        case OP_DIV: r = x / y; break;
        default: r = fmodf(x, y);
        }
        *out = fwp_from_f32(r);
        return 1;
    }
    if (k == K_F64) {
        double x = fwp_f64(a), y = fwp_f64(b), r;
        switch (op) {
        case OP_ADD: r = x + y; break;
        case OP_SUB: r = x - y; break;
        case OP_MUL: r = x * y; break;
        case OP_DIV: r = x / y; break;
        default: r = fmod(x, y);
        }
        *out = fwp_from_f64(r);
        return 1;
    }
    if (k == K_U128) {
        u128 x = fwp_u128(a), y = fwp_u128(b), r;
        if ((op == OP_DIV || op == OP_REM) && y == 0) { *err = 2; return 0; }
        int ovf = 0;
        switch (op) {
        case OP_ADD: ovf = __builtin_add_overflow(x, y, &r); break;
        case OP_SUB: ovf = __builtin_sub_overflow(x, y, &r); break;
        case OP_MUL: ovf = __builtin_mul_overflow(x, y, &r); break;
        case OP_DIV: r = x / y; break;
        default: r = x % y;
        }
        if (ovf) { *err = 1; return 0; }
        *out = fwp_box_u128(r);
        return 1;
    }
    if (k == K_I128) {
        i128 x = fwp_i128(a), y = fwp_i128(b), r;
        if ((op == OP_DIV || op == OP_REM) && y == 0) { *err = 2; return 0; }
        int ovf = 0;
        i128 mn = (i128)((u128)1 << 127);
        switch (op) {
        case OP_ADD: ovf = __builtin_add_overflow(x, y, &r); break;
        case OP_SUB: ovf = __builtin_sub_overflow(x, y, &r); break;
        case OP_MUL: ovf = __builtin_mul_overflow(x, y, &r); break;
        case OP_DIV: if (x == mn && y == -1) ovf = 1; else r = x / y; break;
        default: if (x == mn && y == -1) ovf = 1; else r = x % y;
        }
        if (ovf) { *err = 1; return 0; }
        *out = fwp_box_i128(r);
        return 1;
    }
    /* integers up to 64 bits (and TInt) computed in i128 and range checked */
    i128 x = fwp_as_i128(k, a), y = fwp_as_i128(k, b), r;
    if ((op == OP_DIV || op == OP_REM) && y == 0) { *err = 2; return 0; }
    if (op == OP_REM && y == -1 && fwp_is_signed_kind(k)) {
        /* MIN % -1 overflows (as in Rust's checked_rem) */
        V mn;
        int fits_lower = fwp_int_fits(x - 1, k, w, &mn);
        if (!fits_lower) { *err = 1; return 0; }
    }
    switch (op) {
    case OP_ADD: r = x + y; break;
    case OP_SUB: r = x - y; break;
    case OP_MUL: r = x * y; break;
    case OP_DIV: r = x / y; break;
    default: r = x % y;
    }
    if (!fwp_int_fits(r, k, w, out)) { *err = 1; return 0; }
    return 1;
}

static V fwp_arith(int k, int op, V a, V b, const char *name, int w) {
    V out;
    int err;
    if (fwp_arith_raw(k, op, a, b, w, &out, &err)) return out;
    if (err == 2) fwp_trap("division by zero");
    if (k == K_TINT) {
        char buf[64];
        snprintf(buf, sizeof buf, "TInt[%d]", w);
        fwp_trap_overflow(buf);
    }
    fwp_trap_overflow(name);
    return 0;
}

/* floats flip the sign (so neg 0.0 is -0.0); integers are checked 0 - x */
static V fwp_neg(int k, V v, const char *name, int w) {
    if (k == K_F32) return fwp_from_f32(-fwp_f32(v));
    if (k == K_F64) return fwp_from_f64(-fwp_f64(v));
    return fwp_arith(k, OP_SUB, fwp_from_i128(k, 0, name, w), v, name, w);
}

static V fwp_checked(int k, int op, V a, V b) {
    V out;
    int err;
    if (fwp_arith_raw(k, op, a, b, 0, &out, &err)) return fwp_some(out);
    return FWP_NONE;
}

static int fwp_bits_of(int k) {
    switch (k) {
    case K_I8: case K_U8: return 8;
    case K_I16: case K_U16: return 16;
    case K_I32: case K_U32: return 32;
    case K_I64: case K_U64: return 64;
    default: return 128;
    }
}

/* truncate a 128-bit pattern to kind k */
static V fwp_wrap_to(int k, u128 x) {
    switch (k) {
    case K_I8: return (V)(int64_t)(int8_t)(uint8_t)x;
    case K_I16: return (V)(int64_t)(int16_t)(uint16_t)x;
    case K_I32: return (V)(int64_t)(int32_t)(uint32_t)x;
    case K_I64: return (V)(int64_t)(uint64_t)x;
    case K_U8: return (V)(uint8_t)x;
    case K_U16: return (V)(uint16_t)x;
    case K_U32: return (V)(uint32_t)x;
    case K_U64: return (V)(uint64_t)x;
    case K_I128: return fwp_box_i128((i128)x);
    default: return fwp_box_u128(x);
    }
}

static u128 fwp_bits(int k, V v) {
    if (k == K_U128) return fwp_u128(v);
    if (k == K_I128) return (u128)fwp_i128(v);
    return (u128)fwp_as_i128(k, v);
}

static V fwp_wrapping(int k, int op, V a, V b) {
    u128 x = fwp_bits(k, a), y = fwp_bits(k, b);
    switch (op) {
    case OP_ADD: return fwp_wrap_to(k, x + y);
    case OP_SUB: return fwp_wrap_to(k, x - y);
    default: return fwp_wrap_to(k, x * y);
    }
}

static V fwp_saturating(int k, int op, V a, V b, const char *name) {
    V out;
    int err;
    if (fwp_arith_raw(k, op, a, b, 0, &out, &err)) return out;
    /* direction of the overflow decides the bound */
    int sgn;
    if (k == K_U128 || k == K_U8 || k == K_U16 || k == K_U32 || k == K_U64) {
        sgn = op == OP_SUB ? -1 : 1;
    } else {
        i128 x = k == K_I128 ? fwp_i128(a) : fwp_as_i128(k, a);
        i128 y = k == K_I128 ? fwp_i128(b) : fwp_as_i128(k, b);
        if (op == OP_ADD) sgn = y > 0 ? 1 : -1;
        else if (op == OP_SUB) sgn = y < 0 ? 1 : -1;
        else sgn = ((x < 0) == (y < 0)) ? 1 : -1;
    }
    (void)name;
    switch (k) {
    case K_I8: return sgn > 0 ? (V)127 : (V)(int64_t)-128;
    case K_I16: return sgn > 0 ? (V)32767 : (V)(int64_t)-32768;
    case K_I32: return sgn > 0 ? (V)2147483647 : (V)(int64_t)(-2147483647LL - 1);
    case K_I64: return sgn > 0 ? (V)INT64_MAX : (V)INT64_MIN;
    case K_I128: return fwp_box_i128(sgn > 0 ? (i128)(((u128)1 << 127) - 1) : (i128)((u128)1 << 127));
    case K_U8: return sgn > 0 ? 255 : 0;
    case K_U16: return sgn > 0 ? 65535 : 0;
    case K_U32: return sgn > 0 ? 4294967295ULL : 0;
    case K_U64: return sgn > 0 ? UINT64_MAX : 0;
    default: return fwp_box_u128(sgn > 0 ? ~(u128)0 : 0);
    }
}

static V fwp_overflowing(int k, int op, V a, V b) {
    V w = fwp_wrapping(k, op, a, b), out;
    int err;
    int ok = fwp_arith_raw(k, op, a, b, 0, &out, &err);
    return fwp_tuple2(w, ok ? FWP_FALSE : FWP_TRUE);
}

static V fwp_bitop(int k, int which, V a, V b) {
    u128 x = fwp_bits(k, a), y = fwp_bits(k, b);
    return fwp_wrap_to(k, which == 0 ? (x & y) : which == 1 ? (x | y) : (x ^ y));
}

static V fwp_bitnot(int k, V a) { return fwp_wrap_to(k, ~fwp_bits(k, a)); }

static V fwp_shift(int k, int left, uint32_t n, V v) {
    int bits = fwp_bits_of(k);
    if (n >= (uint32_t)bits) {
        char buf[96];
        snprintf(buf, sizeof buf, "shift by %u bits overflows a %d-bit integer", n, bits);
        fwp_trap(buf);
    }
    if (left) return fwp_wrap_to(k, fwp_bits(k, v) << n);
    switch (k) {
    case K_I8: case K_I16: case K_I32: case K_I64: return (V)((int64_t)v >> n);
    case K_I128: return fwp_box_i128(fwp_i128(v) >> n);
    case K_U128: return fwp_box_u128(fwp_u128(v) >> n);
    default: return v >> n;
    }
}

static V fwp_int_convert(int ks, int kt, V v) {
    V out;
    if (ks == K_U128) {
        u128 x = fwp_u128(v);
        if (kt == K_U128) return fwp_some(fwp_box_u128(x));
        if (x > (u128)(((u128)1 << 127) - 1)) return FWP_NONE;
        return fwp_int_fits((i128)x, kt, 0, &out) ? fwp_some(out) : FWP_NONE;
    }
    return fwp_int_fits(fwp_as_i128(ks, v), kt, 0, &out) ? fwp_some(out) : FWP_NONE;
}

static V fwp_int_to_float(int ks, int kt, V v) {
    double x = ks == K_U128 ? (double)fwp_u128(v) : (double)fwp_as_i128(ks, v);
    return fwp_float_of(kt, x);
}

static V fwp_float_to_int(int ks, int kt, V v) {
    double x = fwp_as_f64(ks, v);
    V out;
    if (!isfinite(x)) return FWP_NONE;
    /* exact bounds (as src/interp.rs): [-2^127, 2^127) converts through
     * i128, [2^127, 2^128) only to U128 */
    double t = trunc(x);
    if (t < -0x1p127 || t >= 0x1p128) return FWP_NONE;
    if (t >= 0x1p127) {
        if (kt != K_U128) return FWP_NONE;
        return fwp_some(fwp_box_u128((u128)t));
    }
    return fwp_int_fits((i128)t, kt, 0, &out) ? fwp_some(out) : FWP_NONE;
}

enum { FM_SQRT, FM_EXP, FM_LN, FM_SIN, FM_COS, FM_TAN, FM_FLOOR, FM_CEIL, FM_ROUND };

static V fwp_fmath(int k, int f, V v) {
    if (k == K_F32) {
        float x = fwp_f32(v);
        switch (f) {
        case FM_SQRT: return fwp_from_f32(sqrtf(x));
        case FM_FLOOR: return fwp_from_f32(floorf(x));
        case FM_CEIL: return fwp_from_f32(ceilf(x));
        case FM_ROUND: return fwp_from_f32(roundf(x));
        default: break;
        }
    }
    double x = fwp_as_f64(k, v), y;
    switch (f) {
    case FM_SQRT: y = sqrt(x); break;
    case FM_EXP: y = exp(x); break;
    case FM_LN: y = log(x); break;
    case FM_SIN: y = sin(x); break;
    case FM_COS: y = cos(x); break;
    case FM_TAN: y = tan(x); break;
    case FM_FLOOR: y = floor(x); break;
    case FM_CEIL: y = ceil(x); break;
    default: y = round(x);
    }
    return fwp_float_of(k, y);
}

static V fwp_abs(int k, V v, const char *name) {
    if (k == K_F32) return fwp_from_f32(fabsf(fwp_f32(v)));
    if (k == K_F64) return fwp_from_f64(fabs(fwp_f64(v)));
    i128 x = k == K_U128 ? 0 : fwp_as_i128(k, v);
    if (x < 0) return fwp_arith(k, OP_SUB, fwp_from_i128(k, 0, name, 0), v, name, 0);
    return v;
}

/* built from the end; the counters never step past lo or hi, so the
 * extremes of 128-bit types do not overflow */
static V fwp_p_range(int k, V lo, V hi) {
    V r = 0;
    if (k == K_U128) {
        u128 a = fwp_u128(lo);
        for (u128 i = fwp_u128(hi); i > a;) {
            i--;
            r = fwp_cons(fwp_box_u128(i), r);
        }
        return r;
    }
    i128 a = fwp_as_i128(k, lo);
    for (i128 i = fwp_as_i128(k, hi); i > a;) {
        i--;
        V x;
        fwp_int_fits(i, k, 0, &x);
        r = fwp_cons(x, r);
    }
    return r;
}

static int fwp_str_eq(V a, V b) {
    return STR(a)->len == STR(b)->len && memcmp(STR(a)->d, STR(b)->d, STR(a)->len) == 0;
}

/* ----- balanced ternary */

static V fwp_p_tint_trits(V v, int w) {
    int64_t x = (int64_t)v;
    V *ds = (V *)fwp_alloc((size_t)(w + 1) * sizeof(V));
    for (int i = w - 1; i >= 0; i--) {
        int64_t r = ((x % 3) + 3) % 3;
        int64_t d = r == 2 ? -1 : r;
        ds[i] = (V)d;
        x = (x - d) / 3;
    }
    return fwp_list_from(ds, (size_t)w);
}

static V fwp_p_tint_from_trits(V xs, int w) {
    size_t n;
    V *ts = fwp_list_items(xs, &n);
    if (n > (size_t)w) return FWP_NONE;
    i128 acc = 0;
    for (size_t i = 0; i < n; i++) acc = acc * 3 + (int64_t)ts[i];
    V out;
    return fwp_int_fits(acc, K_TINT, w, &out) ? fwp_some(out) : FWP_NONE;
}

static V fwp_p_tint_of_int(V x, int w) {
    V out;
    return fwp_int_fits((int64_t)x, K_TINT, w, &out) ? fwp_some(out) : FWP_NONE;
}

static V fwp_p_trits_pack(V xs) {
    size_t n;
    V *ts = fwp_list_items(xs, &n);
    size_t nb = (n + 4) / 5;
    char *b = (char *)fwp_alloc_leaf(nb + 1);
    for (size_t c = 0; c < nb; c++) {
        uint32_t byte = 0, p = 1;
        for (size_t k = 0; k < 5 && c * 5 + k < n; k++, p *= 3)
            byte += (uint32_t)((int64_t)ts[c * 5 + k] + 1) * p;
        b[c] = (char)(uint8_t)byte;
    }
    return fwp_str_new(b, nb);
}

static V fwp_p_trits_unpack(V nv, V bs) {
    int64_t n = (int64_t)nv;
    if (n < 0) n = 0;
    /* only trits the bytes hold: none past the end */
    if ((uint64_t)n > STR(bs)->len * 5) n = (int64_t)(STR(bs)->len * 5);
    V *out = (V *)fwp_alloc(((size_t)n + 1) * sizeof(V));
    static const uint32_t pw[5] = {1, 3, 9, 27, 81};
    for (int64_t i = 0; i < n; i++) {
        uint32_t byte = (uint8_t)STR(bs)->d[i / 5];
        out[i] = (V)((int64_t)((byte / pw[i % 5]) % 3) - 1);
    }
    return fwp_list_from(out, (size_t)n);
}

/* ----- portable SIMD: a vector is a one-field record holding an array of
 * lanes. Fixed-width loops over uniform words; the C compiler vectorizes
 * them where the lane kind allows. */

static V fwp_simd_wrap(V arr) { return fwp_record(1, &arr); }
#define LANES(v) ARR(OBJ(v)->f[0])

static V fwp_p_simd_splat(V x, size_t n) {
    V a = fwp_arr_new(n);
    for (size_t i = 0; i < n; i++) ARR(a)->d[i] = x;
    return fwp_simd_wrap(a);
}

static V fwp_p_simd_from_array(V a, size_t n) {
    if (ARR(a)->len != n) return FWP_NONE;
    return fwp_some(fwp_simd_wrap(a));
}

static int fwp_num_lt(int k, V a, V b) {
    if (k == K_F32 || k == K_F64) return fwp_as_f64(k, a) < fwp_as_f64(k, b);
    if (k == K_U128) return fwp_u128(a) < fwp_u128(b);
    if (k == K_I128) return fwp_i128(a) < fwp_i128(b);
    return fwp_as_i128(k, a) < fwp_as_i128(k, b);
}

/* op: OP_ADD/OP_SUB/OP_MUL/OP_DIV, 5 = min, 6 = max; `subj` op `arg` */
static V fwp_p_simd_op(int k, int op, V subj, V arg, const char *name, int w) {
    fwp_arr *xs = LANES(subj), *ys = LANES(arg);
    size_t n = xs->len < ys->len ? xs->len : ys->len;
    int fl = k == K_F32 || k == K_F64;
    V r = fwp_arr_new(n);
    V *out = ARR(r)->d;
    if (k == K_F64 && op <= OP_DIV) {
        for (size_t i = 0; i < n; i++) {
            double x = fwp_f64(xs->d[i]), y = fwp_f64(ys->d[i]), z;
            switch (op) {
            case OP_ADD: z = x + y; break;
            case OP_SUB: z = x - y; break;
            case OP_MUL: z = x * y; break;
            default: z = x / y;
            }
            out[i] = fwp_from_f64(z);
        }
        return fwp_simd_wrap(r);
    }
    for (size_t i = 0; i < n; i++) {
        V x = xs->d[i], y = ys->d[i];
        if (op == 5) out[i] = fwp_num_lt(k, y, x) ? y : x;
        else if (op == 6) out[i] = fwp_num_lt(k, x, y) ? y : x;
        else if (!fl && op != OP_DIV) out[i] = fwp_wrapping(k, op, x, y);
        else out[i] = fwp_arith(k, op, x, y, name, w);
    }
    return fwp_simd_wrap(r);
}

static V fwp_p_simd_sum(int k, V v, const char *name, int w) {
    fwp_arr *xs = LANES(v);
    if (xs->len == 0) return fwp_from_i128(k, 0, name, w);
    int fl = k == K_F32 || k == K_F64;
    V acc = xs->d[0];
    for (size_t i = 1; i < xs->len; i++)
        acc = fl ? fwp_arith(k, OP_ADD, acc, xs->d[i], name, w) : fwp_wrapping(k, OP_ADD, acc, xs->d[i]);
    return acc;
}
