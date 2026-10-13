/* Format-specific transcendental functions. Only the arithmetic templates are
 * instantiated: no streams, strings, heap allocation or C++ runtime is used. */
#define TLFLOAT_NO_LIBSTDCXX
#include <tlfloat/tlmath.hpp>

struct fwp_quad_bits { uint64_t words[2]; };
static_assert(sizeof(tlfloat::Quad) == 16 && alignof(tlfloat::Quad) == 8);
static_assert(sizeof(tlfloat::Half) == 2 && sizeof(tlfloat::BFloat16) == 2);

#define FWP_MATH_FORMAT(prefix, Float, Bits, nanbits) \
static Bits prefix##_bits(Float value) { \
    if (isnan(value)) return nanbits; \
    return std::bit_cast<Bits>(value); \
} \
extern "C" Bits prefix##_exp(Bits value) { return prefix##_bits(tlfloat::exp(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_ln(Bits value) { return prefix##_bits(tlfloat::log(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_sin(Bits value) { return prefix##_bits(tlfloat::sin(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_cos(Bits value) { return prefix##_bits(tlfloat::cos(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_tan(Bits value) { return prefix##_bits(tlfloat::tan(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_pow(Bits a, Bits b) { return prefix##_bits(tlfloat::pow(std::bit_cast<Float>(a), std::bit_cast<Float>(b))); }

FWP_MATH_FORMAT(fwp_f16, tlfloat::Half, uint16_t, UINT16_C(0x7e00))
FWP_MATH_FORMAT(fwp_bf16, tlfloat::BFloat16, uint16_t, UINT16_C(0x7fc0))
static constexpr fwp_quad_bits fwp_math_quad_nan = {{0, UINT64_C(0x7fff800000000000)}};
FWP_MATH_FORMAT(fwp_f128, tlfloat::Quad, fwp_quad_bits, fwp_math_quad_nan)
#undef FWP_MATH_FORMAT
