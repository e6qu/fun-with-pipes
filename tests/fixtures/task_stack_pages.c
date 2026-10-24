/* The test inserts the production allocation block below. Exercise real Linux
   mappings, pool reuse and each setup failure without compiling a large app. */
#include <errno.h>
#include <setjmp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

#define FWP_NATIVE_TASK_STACK ((size_t)256 << 20)
static struct { char *stack; size_t stack_size; } task, *t = &task;
static char *fwp_stack_pool[64];
static int fwp_stack_pool_n;
static jmp_buf trapped;
static const char *mode, *message;
static unsigned advice_calls, protect_calls, unmap_calls;
static int advice_supported;

static void fwp_trap(const char *text) {
    message = text;
    longjmp(trapped, 1);
}
static void *probe_mmap(void *p, size_t n, int protection, int flags, int fd, off_t offset) {
    if (!strcmp(mode, "map-error")) { errno = ENOMEM; return MAP_FAILED; }
    return mmap(p, n, protection, flags, fd, offset);
}
static int probe_advice(void *p, size_t n, int advice) {
    advice_calls++;
    if (advice != MADV_NOHUGEPAGE) exit(210);
    if (!strcmp(mode, "no-thp")) { errno = EINVAL; return -1; }
    if (!strcmp(mode, "advice-error")) { errno = EACCES; return -1; }
    if (!strcmp(mode, "missing-advice")) { advice_supported = 1; return 0; }
    int result = madvise(p, n, advice);
    advice_supported = result == 0;
    return result;
}
static int probe_protect(void *p, size_t n, int protection) {
    protect_calls++;
    if (!strcmp(mode, "guard-error")) { errno = EACCES; return -1; }
    if (!strcmp(mode, "missing-guard")) return 0;
    return mprotect(p, n, protection);
}
static int probe_unmap(void *p, size_t n) {
    unmap_calls++;
    return munmap(p, n);
}
static void allocate(void) {
#define mmap probe_mmap
#define madvise probe_advice
#define mprotect probe_protect
#define munmap probe_unmap
    /* PRODUCTION_STACK_ALLOCATION */
#undef mmap
#undef madvise
#undef mprotect
#undef munmap
}
static void check_mapping(void) {
    long page = sysconf(_SC_PAGESIZE);
    t->stack[page] = 1;
    t->stack[t->stack_size - 1] = 2;
    FILE *file = fopen("/proc/self/smaps", "r");
    if (!file) exit(209);
    char line[1024], permission[5];
    uintptr_t begin, end, address = (uintptr_t)t->stack;
    int guard = 0, body = 0, current_body = 0, ordinary = 0;
    size_t huge_kib = 0;
    while (fgets(line, sizeof line, file)) {
        if (sscanf(line, "%lx-%lx %4s", &begin, &end, permission) == 3) {
            current_body = begin <= address + page && address + page < end;
            if (begin == address && end == address + page && !strcmp(permission, "---p")) guard++;
            if (current_body && !strcmp(permission, "rw-p") && end == address + t->stack_size) body++;
        } else if (current_body) {
            size_t kib;
            if (sscanf(line, "AnonHugePages: %zu kB", &kib) == 1) huge_kib += kib;
            if (!strncmp(line, "VmFlags:", 8) && strstr(line, " nh ")) ordinary++;
        }
    }
    fclose(file);
    if (guard != 1 || body != 1) { fprintf(stderr, "missing stack guard\n"); exit(212); }
    if (advice_supported && (ordinary != 1 || huge_kib)) {
        fprintf(stderr, "missing ordinary-page policy\n"); exit(211);
    }
    printf("stack-pages\tguard=%d\tordinary=%d\thuge_kib=%zu\n", guard, ordinary, huge_kib);
}
int main(int argc, char **argv) {
    if (argc != 2) return 208;
    mode = argv[1];
    if (setjmp(trapped)) {
        int map_error = !strcmp(mode, "map-error");
        int advice_error = !strcmp(mode, "advice-error");
        int guard_error = !strcmp(mode, "guard-error");
        if (!map_error && !advice_error && !guard_error) return 207;
        if (unmap_calls != (unsigned)!map_error || protect_calls != (unsigned)guard_error) return 206;
        const char *expected = map_error ? "cannot allocate a task stack" :
            advice_error ? "cannot set task stack page policy" : "cannot protect task stack guard page";
        if (strcmp(message, expected)) return 205;
        printf("stack-error\t%s\tunmaps=%u\n", mode, unmap_calls);
        return 0;
    }
    allocate();
    check_mapping();
    char *original = t->stack;
    fwp_stack_pool[fwp_stack_pool_n++] = original;
    t->stack = NULL;
    allocate();
    if (t->stack != original || fwp_stack_pool_n || advice_calls != 1 || protect_calls != 1) return 204;
    check_mapping();
    if (munmap(t->stack, t->stack_size)) return 203;
    return 0;
}
