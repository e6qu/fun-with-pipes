#include <stdio.h>
#include <limits.h>
/* Explicit scratch context: small conversions stay on the caller's stack;
 * overflow blocks are released after success, parse error or allocation failure. */
typedef union fwp_decimal_block {
    struct { union fwp_decimal_block *next; } link;
    max_align_t alignment;
} fwp_decimal_block;
static void *fwp_decimal_allocate(ThInfo *context, size_t bytes) {
    size_t align = _Alignof(max_align_t);
    if (bytes > SIZE_MAX - align - sizeof(fwp_decimal_block)) longjmp(context->failure, 1);
    bytes = (bytes + align - 1) & ~(align - 1);
    if ((size_t)(context->end - context->next) >= bytes) {
        void *result = context->next;
        context->next += bytes;
        return result;
    }
    fwp_decimal_block *block = malloc(sizeof *block + bytes);
    if (!block) longjmp(context->failure, 1);
    block->link.next = (fwp_decimal_block *)context->blocks;
    context->blocks = block;
    return block + 1;
}
static void fwp_decimal_release(ThInfo *context) {
    fwp_decimal_block *block = (fwp_decimal_block *)context->blocks;
    while (block) { fwp_decimal_block *next = block->link.next; free(block); block = next; }
}
static int fwp_decimal_format(int format, FPI *fpi, unsigned *fraction, unsigned *exponent) {
    unsigned precision, bias;
    int fast_digits; // exact small-integer decimal digits in the F64 estimate
    switch (format) {
        case 16: precision = 11; *exponent = 5; fast_digits = 2; break;
        case 17: precision = 8; *exponent = 8; fast_digits = 1; break;
        case 32: precision = 24; *exponent = 8; fast_digits = 6; break;
        case 64: precision = 53; *exponent = 11; fast_digits = Int_max; break;
        case 128: precision = 113; *exponent = 15; fast_digits = Int_max; break;
        default: return 0;
    }
    bias = (1u << (*exponent - 1)) - 1;
    *fraction = precision - 1;
    *fpi = (FPI){(int)precision, 1 - (int)bias - (int)*fraction,
                 (int)bias - (int)*fraction, FPI_Round_near, 0, fast_digits};
    return 1;
}
static int fwp_decimal_parse_scoped(ThInfo *context, const char *text, int format,
                                  uint64_t *low, uint64_t *high) {
    if (setjmp(context->failure)) return -1;
    FPI specification;
    unsigned fraction, exponent;
    if (!fwp_decimal_format(format, &specification, &fraction, &exponent)) return 0;
    uint32_t words[4] = {0};
    int power = 0;
    char *end;
    unsigned char first = (unsigned char)*text;
    if (first == ' ' || (first >= '\t' && first <= '\r')) return 0;
    int kind = strtodg(text, &end, &specification, &power, words, context);
    if (end == text || *end || (kind & STRTOG_Retmask) == STRTOG_NoNumber) return 0;
    unsigned __int128 significand = (unsigned __int128)words[0] |
        (unsigned __int128)words[1] << 32 | (unsigned __int128)words[2] << 64 |
        (unsigned __int128)words[3] << 96;
    unsigned __int128 bits = 0;
    unsigned bias = (1u << (exponent - 1)) - 1;
    unsigned all_exponents = (1u << exponent) - 1;
    switch (kind & STRTOG_Retmask) {
        case STRTOG_Normal:
            bits = (significand & (((unsigned __int128)1 << fraction) - 1)) |
                (unsigned __int128)(power + (int)bias + (int)fraction) << fraction;
            break;
        case STRTOG_Denormal: bits = significand; break;
        case STRTOG_Infinite: bits = (unsigned __int128)all_exponents << fraction; break;
        case STRTOG_NaN:
        case STRTOG_NaNbits:
            bits = (unsigned __int128)all_exponents << fraction | (unsigned __int128)1 << (fraction - 1);
            kind &= ~STRTOG_Neg;
            break;
        case STRTOG_Zero: break;
        default: return 0;
    }
    if (kind & STRTOG_Neg) bits |= (unsigned __int128)1 << (fraction + exponent);
    *low = (uint64_t)bits; *high = (uint64_t)(bits >> 64);
    return 1;
}
int fwp_decimal_parse(const char *text, int format, uint64_t *low, uint64_t *high) {
    union { max_align_t align; unsigned char bytes[4096]; } local;
    ThInfo context = {0};
    context.next = local.bytes; context.end = local.bytes + sizeof local.bytes;
    int result = fwp_decimal_parse_scoped(&context, text, format, low, high);
    fwp_decimal_release(&context);
    return result;
}
static int fwp_decimal_show_scoped(ThInfo *context, uint64_t low, uint64_t high,
                                 int format, char *buffer, size_t capacity) {
    if (setjmp(context->failure)) return -1;
    FPI specification;
    unsigned fraction, exponent;
    if (!fwp_decimal_format(format, &specification, &fraction, &exponent) || capacity < 64) return -1;
    unsigned __int128 raw = (unsigned __int128)high << 64 | low;
    int sign = (raw >> (fraction + exponent)) & 1;
    int field = (int)(raw >> fraction) & ((1 << exponent) - 1);
    unsigned __int128 mantissa = raw & (((unsigned __int128)1 << fraction) - 1);
    if (field == (1 << exponent) - 1) {
        const char *special = mantissa ? "NaN" : sign ? "-inf" : "inf";
        strcpy(buffer, special); return (int)strlen(special);
    }
    if (!field && !mantissa) { strcpy(buffer, sign ? "-0" : "0"); return sign ? 2 : 1; }
    int kind = field ? STRTOG_Normal : STRTOG_Denormal;
    if (field) mantissa |= (unsigned __int128)1 << fraction;
    int power = (field ? field : 1) - ((1 << (exponent - 1)) - 1) - (int)fraction;
    uint32_t words[4] = {(uint32_t)mantissa, (uint32_t)(mantissa >> 32),
                         (uint32_t)(mantissa >> 64), (uint32_t)(mantissa >> 96)};
    int point;
    char *end;
    char *digits = gdtoa(&specification, power, words, &kind, 0, 0, &point, &end, context);
    // Canonical scientific text; language rendering can select fixed notation
    // from these exact shortest digits without another numeric conversion.
    char *out = buffer;
    if (sign) *out++ = '-';
    *out++ = digits[0];
    if (end - digits > 1) {
        *out++ = '.';
        memcpy(out, digits + 1, (size_t)(end - digits - 1));
        out += end - digits - 1;
    }
    if (point != 1) out += snprintf(out, capacity - (size_t)(out - buffer), "e%d", point - 1);
    *out = 0;
    return (int)(out - buffer);
}
int fwp_decimal_show(uint64_t low, uint64_t high, int format, char *buffer, size_t capacity) {
    union { max_align_t align; unsigned char bytes[4096]; } local;
    ThInfo context = {0};
    context.next = local.bytes; context.end = local.bytes + sizeof local.bytes;
    int result = fwp_decimal_show_scoped(&context, low, high, format, buffer, capacity);
    fwp_decimal_release(&context);
    return result;
}
