#ifndef RETURNED_CALLABLE_PEER_H
#define RETURNED_CALLABLE_PEER_H

#include <stdint.h>
#include <stddef.h>

/* The capture belongs to this returned value. Invocation borrows its fields;
 * there is no pointer into the factory's stack and no allocated payload. */
typedef struct {
    int64_t (*invoke)(int64_t capture, int64_t input);
    int64_t capture;
} returned_callable;

/* kind 0: capture + input; kind 1: 2 * (capture + input).
 * Invalid kinds exit 71; addition/multiplication overflow exits 70.
 * The caller and this implementation are compiled separately, without LTO. */
returned_callable returned_make(int32_t kind, int64_t capture);
int64_t returned_direct(int32_t kind, int64_t capture, int64_t input);

/* The shared observer reports failures outside successful arithmetic work. */
_Noreturn void returned_failure(const unsigned char *message, size_t length, int status);

#endif
