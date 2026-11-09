/* Verify actual reservation, page touching and unmapping before observing a parser. */
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include <unistd.h>

void parser_memory_checkpoint(unsigned phase);

int main(int argc, char **argv) {
    if (argc != 2) return 90;
    int omitted_touch = !strcmp(argv[1], "omit-touch");
    int omitted_unmap = !strcmp(argv[1], "omit-unmap");
    if (!omitted_touch && !omitted_unmap && strcmp(argv[1], "ordinary")) return 90;
    long page = sysconf(_SC_PAGESIZE);
    const size_t bytes = 16 * 1024 * 1024;
    if (page <= 0 || bytes % (size_t)page) return 90;
    parser_memory_checkpoint(0);
    void *memory = mmap(NULL, bytes, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (memory == MAP_FAILED) return 91;
    if (prctl(PR_SET_VMA, (unsigned long)PR_SET_VMA_ANON_NAME,
              (unsigned long)(uintptr_t)memory, (unsigned long)bytes,
              (unsigned long)(uintptr_t)"fwp-parser-control")) return 91;
    parser_memory_checkpoint(1);
    if (mprotect(memory, bytes, PROT_READ | PROT_WRITE)) return 91;
    parser_memory_checkpoint(2);
    if (!omitted_touch) {
        volatile unsigned char *pages = memory;
        for (size_t offset = 0; offset < bytes; offset += (size_t)page) pages[offset] = 1;
    }
    parser_memory_checkpoint(3);
    if (!omitted_unmap && munmap(memory, bytes)) return 91;
    parser_memory_checkpoint(4);
    puts("{\"control\":1}");
    return 0;
}
