
#include <stdlib.h>
#include <stdint.h>
static volatile int hash_tracking;
static volatile uint64_t hash_requests;
static void *hash_malloc(size_t n){if(hash_tracking)hash_requests++;return malloc(n);}
static void *hash_calloc(size_t n,size_t s){if(hash_tracking)hash_requests++;return calloc(n,s);}
static void *hash_realloc(void *p,size_t n){if(hash_tracking)hash_requests++;return realloc(p,n);}
#define malloc hash_malloc
#define calloc hash_calloc
#define realloc hash_realloc
