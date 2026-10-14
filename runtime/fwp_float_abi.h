/* fwp extensions to the selected SoftFloat ABI. All structs contain raw bits;
 * these are not the platform's _Float16, __float128 or long-double ABI. */
uint16_t fwp_f128_to_bf16(float128_t);
float128_t fwp_bf16_to_f128(uint16_t);
uint16_t fwp_bf16_add(uint16_t, uint16_t);
uint16_t fwp_bf16_sub(uint16_t, uint16_t);
uint16_t fwp_bf16_mul(uint16_t, uint16_t);
uint16_t fwp_bf16_div(uint16_t, uint16_t);
uint16_t fwp_bf16_sqrt(uint16_t);
float128_t fwp_u128_to_f128(uint64_t, uint64_t);
uint16_t fwp_u128_to_f16(uint64_t, uint64_t);
uint16_t fwp_u128_to_bf16(uint64_t, uint64_t);
int fwp_f128_to_integer(float128_t, uint64_t *, uint64_t *, int *);
int fwp_f128_compare(float128_t, float128_t);
int fwp_decimal_parse(const char *, int, uint64_t *, uint64_t *);
int fwp_decimal_show(uint64_t, uint64_t, int, char *, size_t);
/* Configure overflow scratch before starting runtime threads/conversions. */
void fwp_decimal_set_allocator(void *(*)(size_t), void (*)(void *));
#define FWP_DECLARE_MATH(prefix, Bits) \
Bits prefix##_exp(Bits); Bits prefix##_ln(Bits); Bits prefix##_sin(Bits); \
Bits prefix##_cos(Bits); Bits prefix##_tan(Bits); \
Bits prefix##_pow(Bits, Bits); Bits prefix##_rem(Bits, Bits);
FWP_DECLARE_MATH(fwp_f16, uint16_t)
FWP_DECLARE_MATH(fwp_bf16, uint16_t)
FWP_DECLARE_MATH(fwp_f128, float128_t)
#undef FWP_DECLARE_MATH
