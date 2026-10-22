/* Explicit Rosenbrock derivative, same updates and complete output as fwp.
 * Compile with DIMENSIONS and UPDATES; input/gradient buffers are reused.
 * This does not implement automatic differentiation or fwp's list operations. */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef DIMENSIONS
#error DIMENSIONS must be supplied
#endif
#ifndef UPDATES
#error UPDATES must be supplied
#endif
_Static_assert(DIMENSIONS >= 2 && DIMENSIONS <= 4096, "invalid dimension count");
_Static_assert(UPDATES >= 0 && UPDATES <= 4091, "invalid update count");

int main(void) {
    double *x = malloc(DIMENSIONS * sizeof(double));
    double *gradient = malloc(DIMENSIONS * sizeof(double));
    if (!x || !gradient) { free(x); free(gradient); return 2; }
    for (size_t i = 0; i < DIMENSIONS; ++i) x[i] = i % 2 ? 1.0 : -1.2;
    for (size_t remaining = UPDATES; remaining > 0; --remaining) {
        for (size_t i = 0; i < DIMENSIONS; ++i) gradient[i] = 0.0;
        for (size_t i = 0; i + 1 < DIMENSIONS; ++i) {
            double residual = x[i + 1] - x[i] * x[i];
            gradient[i] += -400.0 * x[i] * residual - 2.0 * (1.0 - x[i]);
            gradient[i + 1] += 200.0 * residual;
        }
        for (size_t i = 0; i < DIMENSIONS; ++i) x[i] -= 0.001 * gradient[i];
    }
    for (size_t i = 0; i < DIMENSIONS; ++i)
        if (!isfinite(x[i])) { free(x); free(gradient); return 3; }
    putchar('[');
    for (size_t i = 0; i < DIMENSIONS; ++i)
        printf(i ? ", %.17g" : "%.17g", x[i]);
    puts("]");
    free(x);
    free(gradient);
    return ferror(stdout) ? 4 : 0;
}
