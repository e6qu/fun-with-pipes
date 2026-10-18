/* A C program using the fwp-built shared library and its generated header. */
#include <stdio.h>
#include "libgeom.h"

int main(void) {
    Point p = {3.0, 4.0};
    printf("norm = %g\n", norm(p));
    Point q = scale(2.0, (Point){1.5, -2.0});
    printf("scale = (%g, %g)\n", q.x, q.y);
    printf("add_ints = %lld\n", (long long)add_ints(40, 2));
    const char *greeting = greet("c");
    printf("%s\n", greeting);
    fwp_release_greet(greeting);
    printf("word_count = %lld\n", (long long)word_count("the quick brown fox"));
    return 0;
}
