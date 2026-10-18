/* Format-specific transcendental functions. Only the arithmetic templates are
 * instantiated: no streams, strings, heap allocation or C++ runtime is used. */
#define TLFLOAT_NO_LIBSTDCXX
#include <type_traits>
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
extern "C" Bits prefix##_asin(Bits value) { return prefix##_bits(tlfloat::asin(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_acos(Bits value) { return prefix##_bits(tlfloat::acos(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_atan(Bits value) { return prefix##_bits(tlfloat::atan(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_sinh(Bits value) { return prefix##_bits(tlfloat::sinh(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_cosh(Bits value) { return prefix##_bits(tlfloat::cosh(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_tanh(Bits value) { return prefix##_bits(tlfloat::tanh(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_asinh(Bits value) { return prefix##_bits(tlfloat::asinh(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_acosh(Bits value) { return prefix##_bits(tlfloat::acosh(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_atanh(Bits value) { return prefix##_bits(tlfloat::atanh(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_log2(Bits value) { return prefix##_bits(tlfloat::log2(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_log10(Bits value) { return prefix##_bits(tlfloat::log10(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_log1p(Bits value) { return prefix##_bits(tlfloat::log1p(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_exp2(Bits value) { return prefix##_bits(tlfloat::exp2(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_expm1(Bits value) { return prefix##_bits(tlfloat::expm1(std::bit_cast<Float>(value))); } \
extern "C" Bits prefix##_atan2(Bits a, Bits b) { return prefix##_bits(tlfloat::atan2(std::bit_cast<Float>(a), std::bit_cast<Float>(b))); } \
extern "C" Bits prefix##_hypot(Bits a, Bits b) { return prefix##_bits(hypot(std::bit_cast<Float>(a), std::bit_cast<Float>(b))); } \
extern "C" Bits prefix##_pow(Bits a, Bits b) { return prefix##_bits(tlfloat::pow(std::bit_cast<Float>(a), std::bit_cast<Float>(b))); } \
extern "C" Bits prefix##_rem(Bits a, Bits b) { return prefix##_bits(tlfloat::fmod(std::bit_cast<Float>(a), std::bit_cast<Float>(b))); }

FWP_MATH_FORMAT(fwp_f16, tlfloat::Half, uint16_t, UINT16_C(0x7e00))
FWP_MATH_FORMAT(fwp_bf16, tlfloat::BFloat16, uint16_t, UINT16_C(0x7fc0))
static constexpr fwp_quad_bits fwp_math_quad_nan = {{0, UINT64_C(0x7fff800000000000)}};
FWP_MATH_FORMAT(fwp_f128, tlfloat::Quad, fwp_quad_bits, fwp_math_quad_nan)
#undef FWP_MATH_FORMAT
