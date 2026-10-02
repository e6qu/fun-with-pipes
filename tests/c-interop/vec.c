/* C code called from tests/ffi/vec.fwp. */
#include <stddef.h>
#include <stdint.h>

typedef struct { double x; double y; } Vec2;

Vec2 vec2_add(Vec2 a, Vec2 b) {
    Vec2 r = {a.x + b.x, a.y + b.y};
    return r;
}

double vec2_dot(Vec2 a, Vec2 b) { return a.x * b.x + a.y * b.y; }

int64_t apply_twice(int64_t (*f)(int64_t), int64_t x) { return f(f(x)); }

double fold_range(int64_t n, double (*f)(double, int64_t), double init) {
    double acc = init;
    for (int64_t i = 0; i < n; i++) acc = f(acc, i);
    return acc;
}

const char *describe(int32_t code) { return code == 0 ? "ok" : "error"; }

void *maybe_null(_Bool give) {
    static int32_t x = 7;
    return give ? &x : NULL;
}
