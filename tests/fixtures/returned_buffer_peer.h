#ifndef RETURNED_BUFFER_PEER_H
#define RETURNED_BUFFER_PEER_H
#include <stddef.h>
#include <stdint.h>
#if !defined(RETURNED_FWP) || !defined(BUFFER_SHARED) || !defined(BUFFER_DIAGNOSTIC)
#error "Select RETURNED_FWP, BUFFER_SHARED and BUFFER_DIAGNOSTIC explicitly"
#endif
#if RETURNED_FWP == 1
typedef uint64_t ReturnedBuffer;
#elif RETURNED_FWP == 0
typedef struct {
    int64_t *data;
    size_t length;
#if BUFFER_SHARED == 1
    size_t *owners;
#endif
} ReturnedBuffer;
#else
#error "RETURNED_FWP must be 0 or 1"
#endif
#if BUFFER_SHARED != 0 && BUFFER_SHARED != 1
#error "BUFFER_SHARED must be 0 or 1"
#endif
#if BUFFER_DIAGNOSTIC != 0 && BUFFER_DIAGNOSTIC != 1
#error "BUFFER_DIAGNOSTIC must be 0 or 1"
#endif
ReturnedBuffer returned_buffer_make(int64_t length);
int64_t returned_buffer_scan(ReturnedBuffer value);
void returned_buffer_release(ReturnedBuffer value);
#if BUFFER_SHARED == 1
ReturnedBuffer returned_buffer_alias(ReturnedBuffer value);
#endif
/* Diagnostic ledger only; not an ordinary allocation or ARC count. */
#if BUFFER_DIAGNOSTIC == 1
int returned_buffer_clean(void);
#endif
int returned_buffer_observe(int argc, char **argv);
#endif
