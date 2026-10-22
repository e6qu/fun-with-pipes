/* Coordinate-wise Rosenbrock derivative, matching descent_packed.fwp's formula.
 * Supply DIMENSIONS and UPDATES explicitly. Two buffers are reused; unlike fwp,
 * this program does not allocate a new immutable array for each update. */
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
    double *next = malloc(DIMENSIONS * sizeof(double));
    if (!x || !next) { free(x); free(next); return 2; }
    for (size_t i = 0; i < DIMENSIONS; ++i) x[i] = i % 2 ? 1.0 : -1.2;
    for (size_t remaining = UPDATES; remaining > 0; --remaining) {
        for (size_t i = 0; i < DIMENSIONS; ++i) {
            double previous = i == 0 ? 0.0 : 200.0 * (x[i] - x[i - 1] * x[i - 1]);
            double following = i + 1 == DIMENSIONS ? 0.0
                : -400.0 * x[i] * (x[i + 1] - x[i] * x[i]) - 2.0 * (1.0 - x[i]);
            next[i] = x[i] - 0.001 * (previous + following);
        }
        double *old = x; x = next; next = old;
    }
    for (size_t i = 0; i < DIMENSIONS; ++i)
        if (!isfinite(x[i])) { free(x); free(next); return 3; }
    putchar('[');
    for (size_t i = 0; i < DIMENSIONS; ++i)
        printf(i ? ", %.17g" : "%.17g", x[i]);
    puts("]");
    free(x);
    free(next);
    return ferror(stdout) ? 4 : 0;
}
