#include <fenv.h>
#include <float.h>

#ifndef FORMAT_CONTROL
#error FORMAT_CONTROL must be supplied
#endif
#ifndef FORMAT_SAMPLES
#error FORMAT_SAMPLES must be supplied
#endif
_Static_assert(FORMAT_CONTROL >= 0 && FORMAT_CONTROL <= 2, "unknown control");
_Static_assert(FORMAT_SAMPLES > 0, "sample count must be explicit and positive");

static size_t format_values, format_precisions, format_errors, format_bounds;
typedef struct { unsigned char before[8]; char text[400]; unsigned char after[8]; } text_guard;

static void text_compare(text_guard *actual, const char *expected, uint64_t bits, int precision) {
    if (FORMAT_CONTROL == 1) actual->text[0] = '?';
    if (FORMAT_CONTROL == 2) actual->after[0] = 0;
    for (size_t i = 0; i < 8; i++)
        if (actual->before[i] != 0xa5 || actual->after[i] != 0xa5) format_bounds++;
    if (strcmp(actual->text, expected)) {
        if (format_errors < 8)
            fprintf(stderr, "float text %016llx p=%d: <%s> != <%s>\n",
                    (unsigned long long)bits, precision, actual->text, expected);
        format_errors++;
    }
}

static void check_float_text(uint64_t bits) {
    double value;
    memcpy(&value, &bits, sizeof value);
    char expected[400];
    text_guard actual;
    memset(&actual, 0xa5, sizeof actual);
    fwp_fmt_f64(actual.text, value);
    baseline_fmt_f64(expected, value);
    text_compare(&actual, expected, bits, 0);
    format_values++;
    if (isfinite(value)) {
        for (int precision = 1; precision <= 17; precision++) {
            memset(&actual, 0xa5, sizeof actual);
            fwp_format_g(actual.text, sizeof actual.text, value, precision);
            baseline_format_g(expected, sizeof expected, value, precision);
            text_compare(&actual, expected, bits, precision);
            format_precisions++;
        }
    }
    uint32_t narrow = (uint32_t)bits;
    float single;
    memcpy(&single, &narrow, sizeof single);
    memset(&actual, 0xa5, sizeof actual);
    fwp_fmt_f32(actual.text, single);
    baseline_fmt_f32(expected, single);
    text_compare(&actual, expected, narrow, -1);
    format_values++;
}

static void check_float_neighbors(double value) {
    double values[] = {value, -value, nextafter(value, INFINITY), nextafter(value, -INFINITY)};
    for (size_t i = 0; i < sizeof values / sizeof values[0]; i++) {
        uint64_t bits;
        memcpy(&bits, &values[i], sizeof bits);
        check_float_text(bits);
    }
}

int main(void) {
    const uint64_t special[] = {
        UINT64_C(0), UINT64_C(0x8000000000000000), UINT64_C(1), UINT64_C(0x8000000000000001),
        UINT64_C(0x0010000000000000), UINT64_C(0x7fefffffffffffff),
        UINT64_C(0x7ff0000000000000), UINT64_C(0xfff0000000000000),
        UINT64_C(0x7ff8000000000001), UINT64_C(0xfff8000000000001),
        UINT64_C(0x3fb999999999999a), UINT64_C(0x3fd3333333333334),
        UINT64_C(0x4340000000000000), UINT64_C(0x4340000000000001),
        UINT64_C(0x4376345785d89fff)
    };
    const int rounding[] = {FE_TONEAREST, FE_DOWNWARD, FE_UPWARD, FE_TOWARDZERO};
    for (size_t mode = 0; mode < sizeof rounding / sizeof rounding[0]; mode++) {
        if (fesetround(rounding[mode])) return 79;
        for (size_t i = 0; i < sizeof special / sizeof special[0]; i++) check_float_text(special[i]);
        for (int exponent = -1074; exponent <= 1023; exponent++)
            check_float_neighbors(ldexp(1.0, exponent));
        for (int exponent = -308; exponent <= 308; exponent++) {
            char text[32];
            snprintf(text, sizeof text, "1e%d", exponent);
            check_float_neighbors(strtod(text, NULL));
        }
        uint64_t state = UINT64_C(0x6a09e667f3bcc909);
        for (size_t i = 0; i < FORMAT_SAMPLES; i++) {
            state ^= state << 13; state ^= state >> 7; state ^= state << 17;
            check_float_text(state);
        }
    }
    if (fesetround(FE_TONEAREST)) return 79;
    printf("float-text values=%zu precisions=%zu mismatches=%zu bounds=%zu\n",
           format_values, format_precisions, format_errors, format_bounds);
    if (format_bounds) return 78;
    return format_errors ? 77 : 0;
}
