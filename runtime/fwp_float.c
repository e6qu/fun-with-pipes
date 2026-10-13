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
