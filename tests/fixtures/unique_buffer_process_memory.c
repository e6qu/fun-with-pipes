/* Linux-only checkpoints in separate diagnostic programs, never timed peers. */
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static void buffer_memory_error(void) {
    fputs("invalid process memory observation\n", stderr);
    exit(94);
}

static void buffer_memory_read(const char *path, char *bytes, size_t capacity) {
    int fd = open(path, O_RDONLY | O_CLOEXEC);
    if (fd < 0) buffer_memory_error();
    ssize_t size;
    do { size = read(fd, bytes, capacity - 1); } while (size < 0 && errno == EINTR);
    if (size <= 0 || (size_t)size >= capacity - 1) buffer_memory_error();
    char extra;
    ssize_t trailing;
    do { trailing = read(fd, &extra, 1); } while (trailing < 0 && errno == EINTR);
    if (trailing != 0 || close(fd) != 0) buffer_memory_error();
    bytes[size] = 0;
}

static uint64_t buffer_memory_field(const char *bytes, const char *key) {
    size_t length = strlen(key);
    unsigned found = 0;
    uint64_t result = 0;
    for (const char *line = bytes; *line;) {
        const char *end = strchr(line, '\n');
        if (!end) buffer_memory_error();
        if ((size_t)(end - line) > length && !strncmp(line, key, length) && line[length] == ':') {
            if (found++) buffer_memory_error();
            const char *value = line + length + 1;
            while (value < end && (*value == ' ' || *value == '\t')) value++;
            if (value == end || *value < '0' || *value > '9') buffer_memory_error();
            errno = 0;
            char *tail;
            uintmax_t number = strtoumax(value, &tail, 10);
            if (errno || number > UINT64_MAX || end - tail != 3 || strncmp(tail, " kB", 3))
                buffer_memory_error();
            result = (uint64_t)number;
        }
        line = end + 1;
    }
    if (found != 1) buffer_memory_error();
    return result;
}

void buffer_memory_checkpoint(const char *stage) {
    /* One complete read per kernel file; the two files are not one atomic snapshot. */
    char bytes[8192];
    buffer_memory_read("/proc/self/status", bytes, sizeof bytes);
    uint64_t virtual_kib = buffer_memory_field(bytes, "VmSize");
    buffer_memory_read("/proc/self/smaps_rollup", bytes, sizeof bytes);
    uint64_t resident_kib = buffer_memory_field(bytes, "Rss");
    uint64_t proportional_kib = buffer_memory_field(bytes, "Pss");
    uint64_t anonymous_kib = buffer_memory_field(bytes, "Anonymous");
    uint64_t swap_kib = buffer_memory_field(bytes, "Swap");
    uint64_t shared_hugetlb_kib = buffer_memory_field(bytes, "Shared_Hugetlb");
    uint64_t private_hugetlb_kib = buffer_memory_field(bytes, "Private_Hugetlb");
    fprintf(stderr, "{\"stage\":\"%s\",\"virtualKiB\":%" PRIu64 ",\"residentKiB\":%" PRIu64
            ",\"proportionalKiB\":%" PRIu64 ",\"anonymousKiB\":%" PRIu64 ",\"swapKiB\":%" PRIu64 ",\"sharedHugeTlbKiB\":%" PRIu64 ",\"privateHugeTlbKiB\":%" PRIu64 "}\n",
            stage, virtual_kib, resident_kib, proportional_kib, anonymous_kib, swap_kib,
            shared_hugetlb_kib, private_hugetlb_kib);
}
