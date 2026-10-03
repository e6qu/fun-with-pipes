#include <stdio.h>
#include <stdint.h>
int main(void) {
    int64_t i = 100000000, acc = 0;
    while (i != 0) { acc += i * 3 % 7; i--; }
    printf("%lld\n", (long long)acc);
    return 0;
}
