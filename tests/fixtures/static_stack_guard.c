/* Test the production initializer without replacing libc's allocator. */
#define _GNU_SOURCE
#include <errno.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/wait.h>
#include <unistd.h>

#define FWP_STATIC_HEAP ((size_t)1 << 16)
#define FWP_STATIC_POOL ((size_t)1 << 16)
#define FWP_STATIC_STACK ((size_t)1 << 16)
#define FWP_STATIC_TASKS 3
#define FWP_STATIC_TASK_STACK ((size_t)1 << 20)
#define FWP_STATIC_THREADS 1
static int mode, guards, mapped, releases;
static void *region;
static size_t region_size;
static void *checked_map(void *address, size_t size, int protection, int flags,
                         int fd, off_t offset) {
    if (mode == 3) { errno = ENOMEM; return MAP_FAILED; }
    region = mmap(address, size, protection, flags, fd, offset);
    region_size = size;
    mapped = region != MAP_FAILED;
    return region;
}
static int checked_guard(void *address, size_t size, int protection) {
    ++guards;
    if ((mode == 1 && guards == 1) || (mode == 2 && guards == FWP_STATIC_TASKS)) {
        errno = EACCES;
        return -1;
    }
    if (mode == 4) return 0; /* Deliberately omit protection. */
    return mprotect(address, size, protection);
}
static int checked_unmap(void *address, size_t size) {
    if (!mapped || address != region || size != region_size) _exit(213);
    int result = munmap(address, size);
    if (result) _exit(214);
    mapped = 0;
    ++releases;
    return result;
}
static void checked_exit(int status) {
    int expected_guards = mode == 1 ? 1 : mode == 2 ? FWP_STATIC_TASKS : 0;
    if (mapped || guards != expected_guards || releases != (mode != 3)) _exit(215);
    _exit(status);
}
#define mmap checked_map
#define mprotect checked_guard
#define munmap checked_unmap
#define _exit checked_exit
/* PRODUCTION_STATIC_INITIALIZER */
#undef mmap
#undef mprotect
#undef munmap
#undef _exit
/* Only metadata sizing is substituted: this fixture does not start a collector. */
static size_t fwp_static_meta_bytes(size_t heap) { return heap / 16; }

int main(int argc, char **argv) {
    if (argc != 2) return 216;
    if (!strcmp(argv[1], "ordinary")) mode = 0;
    else if (!strcmp(argv[1], "first-guard-error")) mode = 1;
    else if (!strcmp(argv[1], "last-guard-error")) mode = 2;
    else if (!strcmp(argv[1], "map-error")) mode = 3;
    else if (!strcmp(argv[1], "missing-guard")) mode = 4;
    else return 217;
    struct rlimit core = {0, 0};
    if (setrlimit(RLIMIT_CORE, &core)) return 218;
    fwp_static_init();
    if (mode >= 1 && mode <= 3) return 219;
    if (guards != FWP_STATIC_TASKS || !mapped || releases) return 220;
    fwp_static_init(); /* Re-entry must retain the same protected region. */
    if (guards != FWP_STATIC_TASKS || fwp_static.ntask_free != FWP_STATIC_TASKS) return 221;
    size_t page = (size_t)sysconf(_SC_PAGESIZE);
    for (int i = 0; i < FWP_STATIC_TASKS; ++i) {
        volatile char *stack = fwp_static.task_stack[i];
        stack[page] = 42;
        stack[FWP_STATIC_TASK_STACK - 1] = 43;
        if (stack[page] != 42 || stack[FWP_STATIC_TASK_STACK - 1] != 43) return 222;
        pid_t child = fork();
        if (child < 0) return 223;
        if (!child) { stack[0] = 1; _exit(0); }
        int status;
        if (waitpid(child, &status, 0) != child) return 224;
        if (!WIFSIGNALED(status) || (WTERMSIG(status) != SIGSEGV && WTERMSIG(status) != SIGBUS)) {
            checked_unmap(region, region_size);
            return 211;
        }
    }
    checked_unmap(region, region_size);
    puts("three guarded stacks, writable bodies, one mapping released");
    return 0;
}
