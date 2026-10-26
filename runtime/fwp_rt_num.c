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
    i128 x = neg ? (i128)((u128)0 - mag) : (i128)mag;
    return (V)fwp_int_fits(x, k, w, out);
}

static V fwp_float_of(int k, double x) {
#ifdef FWP_EXACT_FLOAT
    if (k == K_F16 || k == K_BF16 || k == K_F128) return fwp_quad_float(k, f64_to_f128((float64_t){fwp_from_f64(x)}));
#endif
    return k == K_F32 ? fwp_from_f32((float)x) : fwp_from_f64(x);
}
static V fwp_integer_float(int k, int negative, u128 magnitude) {
#ifdef FWP_EXACT_FLOAT
    uint64_t low = (uint64_t)magnitude, high = (uint64_t)(magnitude >> 64);
    uint16_t sign = negative && magnitude ? 0x8000 : 0;
    if (k == K_F16) return fwp_u128_to_f16(low, high) ^ sign;
    if (k == K_BF16) return fwp_u128_to_bf16(low, high) ^ sign;
    if (k == K_F128) { float128_t x = fwp_u128_to_f128(low, high); x.v[1] ^= (uint64_t)sign << 48; return fwp_box_f128(x); }
#endif
    if (k == K_F32) { float x = (float)magnitude; return fwp_from_f32(negative && magnitude ? -x : x); }
    double x = (double)magnitude; return fwp_from_f64(negative && magnitude ? -x : x);
}

static void fwp_fmt_i128(char *out, i128 x);

/* integer constant of kind k (traps when out of range) */
static V fwp_from_i128(int k, i128 x, const char *name, int w) {
    V out;
    if (fwp_float_kind(k)) return fwp_integer_float(k, x < 0, x < 0 ? (u128)0 - (u128)x : (u128)x);
    if (fwp_int_fits(x, k, w, &out)) return out;
    char n[64], buf[160];
    fwp_fmt_i128(n, x);
    snprintf(buf, sizeof buf, "integer %s does not fit in %s", n, name);
    fwp_trap(buf);
    return 0;
}

static int fwp_arith_u128(int op, u128 x, u128 y, u128 *out, int *err) {
    *err = 0;
    u128 r;
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
    *out = r;
    return 1;
}
static int fwp_arith_i128(int op, i128 x, i128 y, i128 *out, int *err) {
    *err = 0;
    i128 r;
    if ((op == OP_DIV || op == OP_REM) && y == 0) { *err = 2; return 0; }
    int ovf = 0;
    i128 mn = (i128)((u128)1 << 127);
    switch (op) {
    case OP_ADD: ovf = __builtin_add_overflow(x, y, &r); break;
    case OP_SUB: ovf = __builtin_sub_overflow(x, y, &r); break;
    case OP_MUL: {
        /* Unsigned magnitudes include I128_MIN without signed negation.
         * Clang's signed overflow builtin can require __muloti4, absent
         * from libgcc on Linux ARM64; unsigned overflow lowers directly. */
        int negative = (x < 0) != (y < 0);
        u128 ax = x < 0 ? (u128)0 - (u128)x : (u128)x;
        u128 ay = y < 0 ? (u128)0 - (u128)y : (u128)y;
        u128 product;
        ovf = __builtin_mul_overflow(ax, ay, &product);
        u128 limit = ((u128)1 << 127) - (u128)!negative;
        ovf |= product > limit;
        r = (i128)(negative ? (u128)0 - product : product);
        break;
    }
    case OP_DIV: if (x == mn && y == -1) ovf = 1; else r = x / y; break;
    default: if (x == mn && y == -1) ovf = 1; else r = x % y;
    }
    if (ovf) { *err = 1; return 0; }
    *out = r;
    return 1;
}

/* a op b; returns 0 on overflow / division by zero (and sets *err: 1
 * overflow, 2 division by zero) */
static int fwp_arith_raw(int k, int op, V a, V b, int w, V *out, int *err) {
    *err = 0;
#ifdef FWP_EXACT_FLOAT
    if (k == K_F16) {
        float16_t x = (float16_t){(uint16_t)a}, y = (float16_t){(uint16_t)b}, r;
        switch (op) {
        case OP_ADD: r = f16_add(x, y); break;
        case OP_SUB: r = f16_sub(x, y); break;
        case OP_MUL: r = f16_mul(x, y); break;
        case OP_DIV: r = f16_div(x, y); break;
        default: r = (float16_t){fwp_f16_rem(x.v, y.v)};
        }
        *out = r.v; return 1;
    }
    if (k == K_BF16) {
        uint16_t x = (uint16_t)a, y = (uint16_t)b, r;
        switch (op) {
        case OP_ADD: r = fwp_bf16_add(x, y); break;
        case OP_SUB: r = fwp_bf16_sub(x, y); break;
        case OP_MUL: r = fwp_bf16_mul(x, y); break;
        case OP_DIV: r = fwp_bf16_div(x, y); break;
        default: r = fwp_bf16_rem(x, y);
        }
        *out = r; return 1;
    }
    if (k == K_F128) {
        float128_t x = fwp_f128(a), y = fwp_f128(b), r;
        switch (op) {
        case OP_ADD: r = f128_add(x, y); break;
        case OP_SUB: r = f128_sub(x, y); break;
        case OP_MUL: r = f128_mul(x, y); break;
        case OP_DIV: r = f128_div(x, y); break;
        default: r = fwp_f128_rem(x, y);
        }
        *out = fwp_box_f128(r); return 1;
    }
#endif
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
        u128 value;
        if (!fwp_arith_u128(op, fwp_u128(a), fwp_u128(b), &value, err)) return 0;
        *out = fwp_box_u128(value); return 1;
    }
    if (k == K_I128) {
        i128 value;
        if (!fwp_arith_i128(op, fwp_i128(a), fwp_i128(b), &value, err)) return 0;
        *out = fwp_box_i128(value); return 1;
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
    case OP_MUL:
        /* A full U64 product fits unsigned, but not signed, 128 bits. */
        if (k == K_U64) {
            u128 product = (u128)x * (u128)y;
            if (product > UINT64_MAX) { *err = 1; return 0; }
            r = (i128)product;
        } else r = x * y;
        break;
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
#ifdef FWP_EXACT_FLOAT
    if (k == K_F16 || k == K_BF16) return v ^ UINT64_C(0x8000);
    if (k == K_F128) { float128_t x = fwp_f128(v); x.v[1] ^= UINT64_C(1) << 63; return fwp_box_f128(x); }
#endif
    if (k == K_F32) return fwp_from_f32(-fwp_f32(v));
    if (k == K_F64) return fwp_from_f64(-fwp_f64(v));
    if (k == K_I128) {
        i128 result;
        if (__builtin_sub_overflow((i128)0, fwp_i128(v), &result))
            fwp_trap("arithmetic overflow in I128");
        return fwp_box_i128(result);
    }
    if (k == K_U128) {
        if (fwp_u128(v)) fwp_trap("arithmetic overflow in U128");
        return fwp_box_u128(0);
    }
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
    V out;
    int err;
    int ok = fwp_arith_raw(k, op, a, b, 0, &out, &err);
    /* The successful checked result already is the wrapped result. In the
     * wide case allocating both would abandon one 16-byte numeric box. */
    if (!ok) out = fwp_wrapping(k, op, a, b);
    return fwp_tuple2(out, ok ? FWP_FALSE : FWP_TRUE);
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
    if (ks == K_U128) return fwp_integer_float(kt, 0, fwp_u128(v));
    i128 x = fwp_as_i128(ks, v);
    return fwp_integer_float(kt, x < 0, x < 0 ? (u128)0 - (u128)x : (u128)x);
}

static V fwp_float_to_int(int ks, int kt, V v) {
#ifdef FWP_EXACT_FLOAT
    if (ks == K_F16 || ks == K_BF16 || ks == K_F128) {
        uint64_t low, high; int negative; V out;
        if (!fwp_f128_to_integer(fwp_float_quad(ks, v), &low, &high, &negative)) return FWP_NONE;
        return fwp_int_in_range(negative, ((u128)high << 64) | low, kt, 0, &out) ? fwp_some(out) : FWP_NONE;
    }
#endif
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

enum { FM_SQRT, FM_EXP, FM_LN, FM_SIN, FM_COS, FM_TAN, FM_FLOOR, FM_CEIL, FM_ROUND, FM_ASIN, FM_ACOS, FM_ATAN, FM_SINH, FM_COSH, FM_TANH, FM_ASINH, FM_ACOSH, FM_ATANH, FM_LOG2, FM_LOG10, FM_LOG1P, FM_EXP2, FM_EXPM1 };

static V fwp_fmath(int k, int f, V v) {
#ifdef FWP_EXACT_FLOAT
    if (k == K_F16) {
        uint16_t x = (uint16_t)v, r;
        uint_fast8_t mode = f == FM_FLOOR ? softfloat_round_min : f == FM_CEIL ? softfloat_round_max : softfloat_round_near_maxMag;
        switch (f) {
        case FM_SQRT: r = f16_sqrt((float16_t){x}).v; break;
        case FM_EXP: r = fwp_f16_exp(x); break;
        case FM_LN: r = fwp_f16_ln(x); break;
        case FM_SIN: r = fwp_f16_sin(x); break;
        case FM_COS: r = fwp_f16_cos(x); break;
        case FM_TAN: r = fwp_f16_tan(x); break;
        case FM_ASIN: r = fwp_f16_asin(x); break;
        case FM_ACOS: r = fwp_f16_acos(x); break;
        case FM_ATAN: r = fwp_f16_atan(x); break;
        case FM_SINH: r = fwp_f16_sinh(x); break;
        case FM_COSH: r = fwp_f16_cosh(x); break;
        case FM_TANH: r = fwp_f16_tanh(x); break;
        case FM_ASINH: r = fwp_f16_asinh(x); break;
        case FM_ACOSH: r = fwp_f16_acosh(x); break;
        case FM_ATANH: r = fwp_f16_atanh(x); break;
        case FM_LOG2: r = fwp_f16_log2(x); break;
        case FM_LOG10: r = fwp_f16_log10(x); break;
        case FM_LOG1P: r = fwp_f16_log1p(x); break;
        case FM_EXP2: r = fwp_f16_exp2(x); break;
        case FM_EXPM1: r = fwp_f16_expm1(x); break;

        default: r = f16_roundToInt((float16_t){x}, mode, false).v;
        }
        return r;
    }
    if (k == K_BF16) {
        uint16_t x = (uint16_t)v, r;
        uint_fast8_t mode = f == FM_FLOOR ? softfloat_round_min : f == FM_CEIL ? softfloat_round_max : softfloat_round_near_maxMag;
        switch (f) {
        case FM_SQRT: r = fwp_bf16_sqrt(x); break;
        case FM_EXP: r = fwp_bf16_exp(x); break;
        case FM_LN: r = fwp_bf16_ln(x); break;
        case FM_SIN: r = fwp_bf16_sin(x); break;
        case FM_COS: r = fwp_bf16_cos(x); break;
        case FM_TAN: r = fwp_bf16_tan(x); break;
        case FM_ASIN: r = fwp_bf16_asin(x); break;
        case FM_ACOS: r = fwp_bf16_acos(x); break;
        case FM_ATAN: r = fwp_bf16_atan(x); break;
        case FM_SINH: r = fwp_bf16_sinh(x); break;
        case FM_COSH: r = fwp_bf16_cosh(x); break;
        case FM_TANH: r = fwp_bf16_tanh(x); break;
        case FM_ASINH: r = fwp_bf16_asinh(x); break;
        case FM_ACOSH: r = fwp_bf16_acosh(x); break;
        case FM_ATANH: r = fwp_bf16_atanh(x); break;
        case FM_LOG2: r = fwp_bf16_log2(x); break;
        case FM_LOG10: r = fwp_bf16_log10(x); break;
        case FM_LOG1P: r = fwp_bf16_log1p(x); break;
        case FM_EXP2: r = fwp_bf16_exp2(x); break;
        case FM_EXPM1: r = fwp_bf16_expm1(x); break;

        default: r = fwp_f128_to_bf16(f128_roundToInt(fwp_bf16_to_f128(x), mode, false));
        }
        return r;
    }
    if (k == K_F128) {
        float128_t x = fwp_f128(v), r;
        uint_fast8_t mode = f == FM_FLOOR ? softfloat_round_min : f == FM_CEIL ? softfloat_round_max : softfloat_round_near_maxMag;
        switch (f) {
        case FM_SQRT: r = f128_sqrt(x); break;
        case FM_EXP: r = fwp_f128_exp(x); break;
        case FM_LN: r = fwp_f128_ln(x); break;
        case FM_SIN: r = fwp_f128_sin(x); break;
        case FM_COS: r = fwp_f128_cos(x); break;
        case FM_TAN: r = fwp_f128_tan(x); break;
        case FM_ASIN: r = fwp_f128_asin(x); break;
        case FM_ACOS: r = fwp_f128_acos(x); break;
        case FM_ATAN: r = fwp_f128_atan(x); break;
        case FM_SINH: r = fwp_f128_sinh(x); break;
        case FM_COSH: r = fwp_f128_cosh(x); break;
        case FM_TANH: r = fwp_f128_tanh(x); break;
        case FM_ASINH: r = fwp_f128_asinh(x); break;
        case FM_ACOSH: r = fwp_f128_acosh(x); break;
        case FM_ATANH: r = fwp_f128_atanh(x); break;
        case FM_LOG2: r = fwp_f128_log2(x); break;
        case FM_LOG10: r = fwp_f128_log10(x); break;
        case FM_LOG1P: r = fwp_f128_log1p(x); break;
        case FM_EXP2: r = fwp_f128_exp2(x); break;
        case FM_EXPM1: r = fwp_f128_expm1(x); break;

        default: r = f128_roundToInt(x, mode, false);
        }
        return fwp_box_f128(r);
    }
#endif
    if (k == K_F32) {
        float x = fwp_f32(v);
        switch (f) {
        case FM_SQRT: return fwp_from_f32(sqrtf(x));
        case FM_FLOOR: return fwp_from_f32(floorf(x));
        case FM_CEIL: return fwp_from_f32(ceilf(x));
        case FM_ROUND: return fwp_from_f32(roundf(x));
        case FM_ASIN: return fwp_from_f32(asinf(x));
        case FM_ACOS: return fwp_from_f32(acosf(x));
        case FM_ATAN: return fwp_from_f32(atanf(x));
        case FM_SINH: return fwp_from_f32(sinhf(x));
        case FM_COSH: return fwp_from_f32(coshf(x));
        case FM_TANH: return fwp_from_f32(tanhf(x));
        case FM_ASINH: return fwp_from_f32(asinhf(x));
        case FM_ACOSH: return fwp_from_f32(acoshf(x));
        case FM_ATANH: return fwp_from_f32(atanhf(x));
        case FM_LOG2: return fwp_from_f32(log2f(x));
        case FM_LOG10: return fwp_from_f32(log10f(x));
        case FM_LOG1P: return fwp_from_f32(log1pf(x));
        case FM_EXP2: return fwp_from_f32(exp2f(x));
        case FM_EXPM1: return fwp_from_f32(expm1f(x));

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
    case FM_ASIN: y = asin(x); break;
    case FM_ACOS: y = acos(x); break;
    case FM_ATAN: y = atan(x); break;
    case FM_SINH: y = sinh(x); break;
    case FM_COSH: y = cosh(x); break;
    case FM_TANH: y = tanh(x); break;
    case FM_ASINH: y = asinh(x); break;
    case FM_ACOSH: y = acosh(x); break;
    case FM_ATANH: y = atanh(x); break;
    case FM_LOG2: y = log2(x); break;
    case FM_LOG10: y = log10(x); break;
    case FM_LOG1P: y = log1p(x); break;
    case FM_EXP2: y = exp2(x); break;
    case FM_EXPM1: y = expm1(x); break;

    case FM_FLOOR: y = floor(x); break;
    case FM_CEIL: y = ceil(x); break;
    default: y = round(x);
    }
    return fwp_float_of(k, y);
}

static V fwp_float_convert(int source, int target, V v) {
#ifdef FWP_EXACT_FLOAT
    if (source == K_F16 || source == K_BF16 || source == K_F128 || target == K_F16 || target == K_BF16 || target == K_F128)
        return fwp_quad_float(target, fwp_float_quad(source, v));
#endif
    return fwp_float_of(target, fwp_as_f64(source, v));
}
static V fwp_pow(int k, V base, V exponent) {
#ifdef FWP_EXACT_FLOAT
    if (k == K_F16) return fwp_f16_pow((uint16_t)base, (uint16_t)exponent);
    if (k == K_BF16) return fwp_bf16_pow((uint16_t)base, (uint16_t)exponent);
    if (k == K_F128) return fwp_box_f128(fwp_f128_pow(fwp_f128(base), fwp_f128(exponent)));
#endif
    return fwp_float_of(k, pow(fwp_as_f64(k, base), fwp_as_f64(k, exponent)));
}

static V fwp_atan2(int k, V subject, V other) {
#ifdef FWP_EXACT_FLOAT
    if (k == K_F16) return fwp_f16_atan2((uint16_t)subject, (uint16_t)other);
    if (k == K_BF16) return fwp_bf16_atan2((uint16_t)subject, (uint16_t)other);
    if (k == K_F128) return fwp_box_f128(fwp_f128_atan2(fwp_f128(subject), fwp_f128(other)));
#endif
    if (k == K_F32) return fwp_from_f32(atan2f(fwp_f32(subject), fwp_f32(other)));
    return fwp_from_f64(atan2(fwp_f64(subject), fwp_f64(other)));
}

static V fwp_hypot(int k, V subject, V other) {
#ifdef FWP_EXACT_FLOAT
    if (k == K_F16) return fwp_f16_hypot((uint16_t)subject, (uint16_t)other);
    if (k == K_BF16) return fwp_bf16_hypot((uint16_t)subject, (uint16_t)other);
    if (k == K_F128) return fwp_box_f128(fwp_f128_hypot(fwp_f128(subject), fwp_f128(other)));
#endif
    if (k == K_F32) return fwp_from_f32(hypotf(fwp_f32(subject), fwp_f32(other)));
    return fwp_from_f64(hypot(fwp_f64(subject), fwp_f64(other)));
}

static V fwp_abs(int k, V v, const char *name) {
#ifdef FWP_EXACT_FLOAT
    if (k == K_F16 || k == K_BF16) return v & UINT64_C(0x7fff);
    if (k == K_F128) { float128_t x = fwp_f128(v); x.v[1] &= UINT64_C(0x7fffffffffffffff); return fwp_box_f128(x); }
#endif
    if (k == K_F32) return fwp_from_f32(fabsf(fwp_f32(v)));
    if (k == K_F64) return fwp_from_f64(fabs(fwp_f64(v)));
    i128 x = k == K_U128 ? 0 : fwp_as_i128(k, v);
    if (x < 0) return fwp_neg(k, v, name, 0);
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

/* Count wide numeric leaves as well as spine nodes. Registration keeps the
 * current element and completed list owned if construction traps. */
typedef struct { V list, element; void (*drop_element)(V), (*drop_list)(V); } fwp_range_owner;
static void fwp_range_release(void *arg) {
    fwp_range_owner *owner = (fwp_range_owner *)arg;
    if (owner->drop_element) owner->drop_element(owner->element);
    owner->drop_list(owner->list);
}
static V fwp_p_range_owned(int k, V lo, V hi,
                          void (*drop_element)(V), void (*drop_list)(V)) {
    fwp_range_owner owner = {0, 0, drop_element, drop_list};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_range_release, &owner);
    if (k == K_U128) {
        u128 a = fwp_u128(lo);
        for (u128 i = fwp_u128(hi); i > a;) {
            i--;
            owner.element = fwp_rc_fresh(fwp_box_u128(i));
            owner.list = fwp_rc_fresh(fwp_cons(owner.element, owner.list));
            owner.element = 0;
        }
    } else {
        i128 a = fwp_as_i128(k, lo);
        for (i128 i = fwp_as_i128(k, hi); i > a;) {
            i--;
            fwp_int_fits(i, k, 0, &owner.element);
            if (k == K_I128) fwp_rc_fresh(owner.element);
            owner.list = fwp_rc_fresh(fwp_cons(owner.element, owner.list));
            owner.element = 0;
        }
    }
    V result = owner.list;
    owner.list = 0;
    fwp_cleanup_pop(&cleanup);

    return result;
}

static int fwp_str_eq(V a, V b) {
    return STR(a)->len == STR(b)->len && memcmp(STR(a)->d, STR(b)->d, STR(a)->len) == 0;
}
