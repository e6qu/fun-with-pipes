#define _POSIX_C_SOURCE 200809L
#include "callable_phase_clock.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static uint64_t callable_now(void) {
    struct timespec now;
    if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
        fputs("clock_gettime failed\n", stderr);
        exit(1);
    }
    return (uint64_t)now.tv_sec * UINT64_C(1000000000) + (uint64_t)now.tv_nsec;
}

uint64_t callable_phase_clock(void) { return callable_now(); }
