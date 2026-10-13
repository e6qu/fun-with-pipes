/* Exact format bridges shared by the interpreter and generated programs.
 * This follows the selected SoftFloat source, outside the upstream vendor tree.
 * Round-to-odd preserves the sticky bit during intermediate narrowing; the
 * destination is then rounded once, nearest with ties to even. */
static uint16_t fwp_bf16_from_odd_f32(uint32_t bits) {
    uint32_t magnitude = bits & UINT32_C(0x7fffffff);
    if (magnitude > UINT32_C(0x7f800000)) return UINT16_C(0x7fc0);
    return (uint16_t)((bits + UINT32_C(0x7fff) + ((bits >> 16) & 1)) >> 16);
}

uint16_t fwp_f128_to_bf16(float128_t value) {
    uint_fast8_t saved = softfloat_roundingMode;
    softfloat_roundingMode = softfloat_round_odd;
    uint32_t bits = f128_to_f32(value).v;
    softfloat_roundingMode = saved;
    return fwp_bf16_from_odd_f32(bits);
}

float128_t fwp_bf16_to_f128(uint16_t bits) {
    float32_t value = {(uint32_t)bits << 16};
    return f32_to_f128(value);
}

/* Even though the working format is wider, round-to-odd is deliberate: no
 * intermediate nearest rounding may erase which side of a midpoint is exact.
 * Restore the caller's mode; library operations do not change ambient rounding. */
#define FWP_BF16_BINARY(name) \
uint16_t fwp_bf16_##name(uint16_t a, uint16_t b) { \
    uint_fast8_t saved = softfloat_roundingMode; \
    softfloat_roundingMode = softfloat_round_odd; \
    float128_t result = f128_##name(fwp_bf16_to_f128(a), fwp_bf16_to_f128(b)); \
    uint16_t bits = fwp_f128_to_bf16(result); \
    softfloat_roundingMode = saved; \
    return bits; \
}
FWP_BF16_BINARY(add)
FWP_BF16_BINARY(sub)
FWP_BF16_BINARY(mul)
FWP_BF16_BINARY(div)
#undef FWP_BF16_BINARY

uint16_t fwp_bf16_sqrt(uint16_t a) {
    uint_fast8_t saved = softfloat_roundingMode;
    softfloat_roundingMode = softfloat_round_odd;
    uint16_t bits = fwp_f128_to_bf16(f128_sqrt(fwp_bf16_to_f128(a)));
    softfloat_roundingMode = saved;
    return bits;
}

/* Each 64-bit limb is exactly representable in binary128. Scaling the high
 * limb is exact; only their sum rounds. Narrow destinations use round-to-odd
 * here so a low integer bit cannot disappear at their rounding midpoint. */
static float128_t fwp_u128_quad(uint64_t low, uint64_t high, uint_fast8_t mode) {
    float128_t upper = ui64_to_f128(high);
    if (high) upper.v[1] += UINT64_C(64) << 48;
    uint_fast8_t saved = softfloat_roundingMode;
    softfloat_roundingMode = mode;
    float128_t result = f128_add(upper, ui64_to_f128(low));
    softfloat_roundingMode = saved;
    return result;
}

float128_t fwp_u128_to_f128(uint64_t low, uint64_t high) {
    return fwp_u128_quad(low, high, softfloat_round_near_even);
}

uint16_t fwp_u128_to_f16(uint64_t low, uint64_t high) {
    return f128_to_f16(fwp_u128_quad(low, high, softfloat_round_odd)).v;
}

uint16_t fwp_u128_to_bf16(uint64_t low, uint64_t high) {
    return fwp_f128_to_bf16(fwp_u128_quad(low, high, softfloat_round_odd));
}

/* Truncate to a sign and unsigned magnitude. Range checks for the destination
 * integer follow truncation; in particular -0.5 converts to unsigned zero.
 * Reject nonfinite values and magnitudes >= 2^128 before shifting. */
int fwp_f128_to_integer(float128_t value, uint64_t *low, uint64_t *high, int *negative) {
    uint64_t hi = value.v[1], lo = value.v[0];
    int exponent = (int)((hi >> 48) & 0x7fff) - 16383;
    if (exponent >= 128) return 0;
    if (exponent < 0) { *low = *high = 0; *negative = 0; return 1; }
    *negative = (int)(hi >> 63);
    hi = (hi & UINT64_C(0x0000ffffffffffff)) | (UINT64_C(1) << 48);
    if (exponent > 112) {
        unsigned shift = (unsigned)(exponent - 112);
        hi = (hi << shift) | (lo >> (64 - shift));
        lo <<= shift;
    } else if (exponent < 112) {
        unsigned shift = (unsigned)(112 - exponent);
        if (shift >= 64) { lo = hi >> (shift - 64); hi = 0; }
        else { lo = (lo >> shift) | (hi << (64 - shift)); hi >>= shift; }
    }
    *low = lo; *high = hi;
    return 1;
}

/* Numeric comparison differs from raw-bit equality for zeros and NaNs.
 * Return 2 for unordered, otherwise -1, 0 or 1. */
int fwp_f128_compare(float128_t a, float128_t b) {
    uint64_t ah = a.v[1] & UINT64_C(0x7fffffffffffffff);
    uint64_t bh = b.v[1] & UINT64_C(0x7fffffffffffffff);
    const uint64_t infinity = UINT64_C(0x7fff000000000000);
    if (ah > infinity || (ah == infinity && a.v[0]) ||
        bh > infinity || (bh == infinity && b.v[0])) return 2;
    if (!(ah | bh | a.v[0] | b.v[0])) return 0;
    int an = (int)(a.v[1] >> 63), bn = (int)(b.v[1] >> 63);
    if (an != bn) return an ? -1 : 1;
    int order = ah < bh ? -1 : ah > bh ? 1 :
        a.v[0] < b.v[0] ? -1 : a.v[0] > b.v[0] ? 1 : 0;
    return an ? -order : order;
}
