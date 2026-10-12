#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
/* FLOAT_BITS */
/* KERNEL */
int main(void) {
    double input[FWP_KCHUNK + 2], stack[2 * FWP_KCHUNK + 2];
    double output[FWP_KCHUNK + 2], expected[FWP_KCHUNK];
    for (size_t i = 0; i < FWP_KCHUNK + 2; i++) input[i] = (double)i / 17.0 + 1.0;
    const double *inputs[] = {input};
    const double reference_constants[] = {2.5, -0.75};
    V constants[] = {fwp_from_f64(reference_constants[0]), fwp_from_f64(reference_constants[1])};
    const int64_t leaf[] = {FWP_K_LEAF, FWP_K_CONST, FWP_K_ADD, FWP_K_SQRT, FWP_K_SIN};
    const int64_t constant[] = {FWP_K_CONST, FWP_K_CONST, FWP_K_SUB, FWP_K_NEG};
    const size_t lengths[] = {0, 1, 7, 127, FWP_KCHUNK};
    for (unsigned mode = 0; mode < 4; mode++) {
        fwp_kernel kernel = {(mode & 1) ? constant : leaf, (mode & 1) ? 4 : 5, (mode & 2) ? (const V *)reference_constants : constants, inputs, 2};
        for (size_t k = 0; k < sizeof lengths / sizeof lengths[0]; k++) {
            size_t length = lengths[k];
            for (size_t i = 0; i < FWP_KCHUNK + 2; i++) output[i] = -5432.0;
            for (size_t i = 0; i < 2 * FWP_KCHUNK + 2; i++) stack[i] = -5432.0;
            for (size_t i = 0; i < length; i++)
                expected[i] = (mode & 1) ? -(reference_constants[0] - reference_constants[1]) : sin(sqrt(input[2 + i] + reference_constants[0]));
            fwp_kernel_eval(&kernel, 2, length, output, stack);
            if (memcmp(output, expected, length * sizeof(double))) return 121;
            if (output[length] != -5432.0 || stack[2 * FWP_KCHUNK] != -5432.0) return 122;
        }
    }
    puts("kernel stack controls passed");
    return 0;
}
