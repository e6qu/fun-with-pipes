#include <stdio.h>
#include <stdint.h>
#include <string.h>
int main(void) {
    int64_t total = 0;
    char buf[64];
    for (int64_t i = 0; i < 2000000; i++) {
        snprintf(buf, sizeof buf, "#%lld%lld", (long long)i, (long long)(i * 3));
        total += (int64_t)strlen(buf);
    }
    printf("%lld\n", (long long)total);
    return 0;
}
