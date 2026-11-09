/* Native controls for allocator paths absent from the fixed parser inputs.
 * Only public allocator/resource APIs are used. The observer never modifies
 * allocator state, return values or memory. */
#define _GNU_SOURCE
#include <malloc.h>
#include <pthread.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <unistd.h>

void parser_memory_checkpoint(unsigned phase);
static volatile uintptr_t warmup_address;

static void fill(unsigned char *p, size_t bytes) {
    if (!p) exit(91);
    for (size_t i = 0; i < bytes; i++) p[i] = (unsigned char)(i % 251);
}

static void check(const unsigned char *p, size_t bytes) {
    if (!p) exit(92);
    for (size_t i = 0; i < bytes; i++) if (p[i] != (unsigned char)(i % 251)) exit(93);
}

static int mapped(void) {
    if (!mallopt(M_MMAP_THRESHOLD, 131072) || !mallopt(M_MMAP_MAX, 65536)) return 94;
    /* Initialize libc's thread cache before the observation, as the real parser
     * does while reading its input. Its metadata is not parser-owned storage. */
    unsigned char *warmup = malloc(16);
    warmup_address = (uintptr_t)warmup;
    fill(warmup, 16);
    free(warmup);
    parser_memory_checkpoint(0);
    unsigned char *old = malloc(1 << 20);
    fill(old, 1 << 20);
    parser_memory_checkpoint(1);
    unsigned char *fresh = realloc(old, 4 << 20);
    check(fresh, 1 << 20);
    parser_memory_checkpoint(2);
    parser_memory_checkpoint(3);
    free(fresh);
    parser_memory_checkpoint(4);
    puts("mapped bytes preserved and released");
    return 0;
}

static atomic_int stage;
static unsigned char *old, *main_barrier;
static volatile uintptr_t spare_address;

static void *other_arena(void *unused) {
    (void)unused;
    /* Keep a reusable allocation in this worker's arena, with a live successor
     * preventing it from being trimmed as unused top storage. */
    unsigned char *spare = malloc(2 << 20);
    spare_address = (uintptr_t)spare; /* Keep the control allocation observable. */
    unsigned char *barrier = malloc(128);
    fill(spare, 2 << 20);
    fill(barrier, 128);
    free(spare);
    atomic_store_explicit(&stage, 1, memory_order_release);
    while (atomic_load_explicit(&stage, memory_order_acquire) != 2) { }
    parser_memory_checkpoint(2);
    unsigned char *fresh = realloc(old, 1 << 20);
    check(fresh, 128);
    parser_memory_checkpoint(3);
    free(fresh);
    free(main_barrier);
    parser_memory_checkpoint(4);
    check(barrier, 128);
    free(barrier);
    return NULL;
}

static int retry(void) {
    if (!mallopt(M_MMAP_MAX, 0) || !mallopt(M_TRIM_THRESHOLD, -1) || !mallopt(M_ARENA_MAX, 2)) return 94;
    pthread_t worker;
    if (pthread_create(&worker, NULL, other_arena, NULL)) return 95;
    while (atomic_load_explicit(&stage, memory_order_acquire) != 1) { }
    /* Stop only this process from obtaining additional virtual address space.
     * Existing worker-arena storage remains usable. Preserve the hard limit. */
    struct rlimit limit;
    if (getrlimit(RLIMIT_AS, &limit)) return 96;
    FILE *statm = fopen("/proc/self/statm", "r");
    unsigned long pages;
    if (!statm || fscanf(statm, "%lu", &pages) != 1 || fclose(statm)) return 96;
    long page_size = sysconf(_SC_PAGESIZE);
    if (page_size <= 0 || pages > UINT64_MAX / (uint64_t)page_size) return 96;
    rlim_t bytes = (rlim_t)pages * (rlim_t)page_size;
    if (limit.rlim_cur != RLIM_INFINITY && bytes > limit.rlim_cur) return 96;
    limit.rlim_cur = bytes;
    if (setrlimit(RLIMIT_AS, &limit)) return 96;
    parser_memory_checkpoint(0);
    old = malloc(128);
    main_barrier = malloc(128);
    fill(old, 128);
    fill(main_barrier, 128);
    parser_memory_checkpoint(1);
    atomic_store_explicit(&stage, 2, memory_order_release);
    if (pthread_join(worker, NULL)) return 95;
    puts("arena retry bytes preserved and released");
    return 0;
}

int main(int argc, char **argv) {
    if (argc != 2) return 90;
    if (!strcmp(argv[1], "mapped")) return mapped();
    if (!strcmp(argv[1], "retry")) return retry();
    return 90;
}
