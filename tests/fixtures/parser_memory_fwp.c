/* Runs inside the emitted program's ordinary runtime/thread setup. */
#include <errno.h>
#include <inttypes.h>

int parser_memory_main(int argc, char **argv) {
    if (argc != 5) return 90;
    for (int field = 2; field < 5; field++) {
        const char *digits = argv[field];
        if (*digits == '+' || (field == 3 && *digits == '-')) digits++;
        if (*digits < '0' || *digits > '9') return 90;
    }
    char *end;
    errno = 0;
    unsigned long long rounds = strtoull(argv[2], &end, 10);
    if (errno || !*argv[2] || *end || rounds != 1) return 90;
    errno = 0;
    int64_t expected = strtoll(argv[3], &end, 10);
    if (errno || !*argv[3] || *end) return 90;
    errno = 0;
    unsigned long long nodes = strtoull(argv[4], &end, 10);
    if (errno || !*argv[4] || *end || !nodes || nodes > 65536) return 90;
    FILE *file = fopen(argv[1], "rb");
    if (!file || fseek(file, 0, SEEK_END)) return 90;
    long size = ftell(file);
    if (size < 1 || size > 65536 || fseek(file, 0, SEEK_SET)) return 90;
    char *text = malloc((size_t)size + 1);
    if (!text || fread(text, 1, (size_t)size, file) != (size_t)size || fclose(file)) return 90;
    text[size] = 0;
    size_t baseline = fwp_heap.live;
    V input = fwp_rc_fresh(fwp_cstr(text));
    free(text);
    size_t input_live = fwp_heap.live;
    @ready@
    fwp_rc_dup(input);
    V argument = input;
    V result = fwp_owned_entry@entry@(&argument);
    @released@
    if (fwp_heap.live != input_live || fwp_cleanups) {
        fprintf(stderr, "parser entry cleanup failed: live=%zu expected=%zu cleanup=%d\n",
                fwp_heap.live, input_live, fwp_cleanups != NULL);
        return 94;
    }
    @nodes@
    if (!fwp_rc_release_last(input)) return 95;
    fwp_rc_free_obj(input);
    if (fwp_heap.live != baseline) return 95;
    if ((int64_t)result != expected) return 93;
    @output@
    return 0;
}
