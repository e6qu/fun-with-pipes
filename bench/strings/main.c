#include <stdio.h>
#include <stdint.h>
#include <string.h>
int main(void) {
    int64_t total = 0;
    char buf[64];
    for (int64_t i = 0; i < 2000000; i++) {
        int64_t product;
        if (__builtin_mul_overflow(i, INT64_C(3), &product)) return 1;
        snprintf(buf, sizeof buf, "#%lld%lld", (long long)i, (long long)product);
        if (__builtin_add_overflow(total, (int64_t)strlen(buf), &total)) return 1;
    }
    printf("%lld\n", (long long)total);
    return 0;
}
