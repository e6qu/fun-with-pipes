/* Input construction is outside the timer. Each timed call calculates keys,
 * sorts, constructs its result list and releases that list. */
typedef struct { V pair; int64_t count; const char *word; } timing_item;
static int timing_compare(const void *a, const void *b) {
    const timing_item *x = a, *y = b;
    if (x->count != y->count) return x->count > y->count ? -1 : 1;
    return strcmp(x->word, y->word);
}
static uint64_t timing_now(void) {
    struct timespec t;
    if (clock_gettime(CLOCK_MONOTONIC, &t)) exit(231);
    return (uint64_t)t.tv_sec * 1000000000 + (uint64_t)t.tv_nsec;
}
int main(int argc, char **argv) {
    if (argc != 3) return 232;
    size_t n = (size_t)strtoull(argv[1], NULL, 10);
    size_t rounds = (size_t)strtoull(argv[2], NULL, 10);
    if ((n != 256 && n != 4096) || !rounds || rounds > 65536) return 233;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t empty = fwp_heap.live;
    timing_item *expected = malloc(n * sizeof(*expected));
    if (!expected) return 234;
    V xs = 0;
    for (size_t i = n; i; i--) {
        size_t j = i - 1;
        char word[32]; snprintf(word, sizeof(word), "word%06zu", (j * 73) % n);
        V text = fwp_rc_fresh(fwp_cstr(word));
        int64_t count = (int64_t)((j * 17) % 101) + 1;
        V pair = fwp_rc_fresh(fwp_record(2, (V[]){text, (V)count}));
        expected[j] = (timing_item){pair, count, STR(text)->d};
        xs = fwp_rc_fresh(fwp_cons(pair, xs));
    }
    qsort(expected, n, sizeof(*expected), timing_compare);
    size_t input_live = fwp_heap.live;
    /* Validate exact object order against an independent C sort before timing. */
    V checked = @sort@;
    size_t index = 0;
    for (V node = checked; node; node = OBJ(node)->f[1]) {
        if (index >= n || OBJ(node)->f[0] != expected[index++].pair) return 235;
    }
    if (index != n) return 236;
    (@list@)->drop(checked);
    if (fwp_heap.live != input_live) return 237;
    uint64_t start = timing_now();
    for (size_t i = 0; i < rounds; i++) {
        V result = @sort@;
        (@list@)->drop(result);
    }
    uint64_t elapsed = timing_now() - start;
    if (fwp_heap.live != input_live) return 238;
    (@list@)->drop(xs);
    free(expected);
    if (fwp_heap.live != empty) return 239;
    printf("{\"elements\":%zu,\"rounds\":%zu,\"nanoseconds\":%llu}\n",
           n, rounds, (unsigned long long)elapsed);
    return 0;
}
