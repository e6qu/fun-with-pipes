/* Explicit C arena peer. Input loading and result checks are outside timers.
 * Views borrow the input; unlike fwp, tokens have no independently owned strings. */
#include <ctype.h>
#include <errno.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct { const char *start; size_t len; } Token;
typedef struct { int64_t value_or_left; size_t right; uint64_t tag; } Node;
typedef struct { Node *nodes; size_t len, cap, allocations; } Arena;
static uint64_t now(void) {
    struct timespec t;
    if (clock_gettime(CLOCK_MONOTONIC, &t)) exit(90);
    return (uint64_t)t.tv_sec * 1000000000 + (uint64_t)t.tv_nsec;
}
static void *resize(void *p, size_t n) {
    void *q = realloc(p, n);
    if (!q) exit(91);
    return q;
}
static int64_t integer(Token t) {
    size_t i = 0;
    int negative = t.len && t.start[0] == '-';
    if (negative || (t.len && t.start[0] == '+')) i++;
    if (i == t.len) exit(92);
    int64_t value = 0;
    for (; i < t.len; i++) {
        int digit = t.start[i] - '0';
        if (digit < 0 || digit > 9 || __builtin_mul_overflow(value, (int64_t)10, &value) ||
            (negative ? __builtin_sub_overflow(value, (int64_t)digit, &value) :
                        __builtin_add_overflow(value, (int64_t)digit, &value))) exit(92);
    }
    return value;
}
static size_t parse(Arena *a, const Token *tokens, size_t count, size_t *position) {
    if (*position == count) exit(92);
    Token t = tokens[(*position)++];
    Node n = {0};
    if (t.len == 1 && (t.start[0] == '+' || t.start[0] == '*')) {
        n.tag = t.start[0] == '+' ? 1 : 2;
        n.value_or_left = (int64_t)parse(a, tokens, count, position);
        n.right = parse(a, tokens, count, position);
    } else n.value_or_left = integer(t);
    if (a->len == a->cap) {
        a->cap = a->cap ? a->cap * 2 : 8;
        a->nodes = resize(a->nodes, a->cap * sizeof(Node));
        a->allocations++;
    }
    a->nodes[a->len] = n;
    return a->len++;
}
static int64_t evaluate(const Arena *a, size_t index) {
    Node n = a->nodes[index];
    if (!n.tag) return n.value_or_left;
    int64_t left = evaluate(a, (size_t)n.value_or_left), right = evaluate(a, n.right), value;
    if (n.tag == 1 ? __builtin_add_overflow(left, right, &value) :
                     __builtin_mul_overflow(left, right, &value)) exit(101);
    return value;
}
static size_t positive_argument(const char *text) {
    const char *digits = text + (*text == '+');
    if (*digits < '0' || *digits > '9') exit(90);
    char *end;
    errno = 0;
    unsigned long long value = strtoull(text, &end, 10);
    if (errno || *end || !value || (unsigned long long)(size_t)value != value) exit(90);
    return (size_t)value;
}
int main(int argc, char **argv) {
    if (argc != 5) return 90;
    size_t rounds = positive_argument(argv[2]), expected_nodes = positive_argument(argv[4]);
    const char *digits = argv[3] + (argv[3][0] == '+' || argv[3][0] == '-');
    if (*digits < '0' || *digits > '9') return 90;
    char *end;
    errno = 0;
    int64_t expected = strtoll(argv[3], &end, 10);
    if (errno || *end) return 90;
    FILE *file = fopen(argv[1], "rb");
    if (!file || fseek(file, 0, SEEK_END)) return 90;
    long size = ftell(file);
    if (size < 1 || size > 65536 || fseek(file, 0, SEEK_SET)) return 90;
    char *text = resize(NULL, (size_t)size + 1);
    if (fread(text, 1, (size_t)size, file) != (size_t)size || fclose(file)) return 90;
    text[size] = 0;
    uint64_t tokenize_ns = 0, construct_ns = 0, walk_ns = 0, release_ns = 0;
    size_t node_bytes = 0, token_bytes = 0, allocations = 0;
    for (size_t repeat = 0; repeat < rounds; repeat++) {
        Token *tokens = NULL;
        size_t count = 0, capacity = 0, token_allocations = 0;
        uint64_t begin = now();
        for (size_t i = 0; i < (size_t)size;) {
            if (isspace((unsigned char)text[i])) { i++; continue; }
            size_t start = i;
            while (i < (size_t)size && !isspace((unsigned char)text[i])) i++;
            if (count == capacity) {
                capacity = capacity ? capacity * 2 : 8;
                tokens = resize(tokens, capacity * sizeof(Token)); token_allocations++;
            }
            tokens[count++] = (Token){text + start, i - start};
        }
        uint64_t split = now();
        Arena arena = {0}; size_t position = 0;
        size_t root = parse(&arena, tokens, count, &position);
        uint64_t built = now();
        if (position != count) return 92;
        int64_t result = evaluate(&arena, root);
        uint64_t walked = now();
        node_bytes = arena.cap * sizeof(Node); token_bytes = capacity * sizeof(Token);
        allocations = arena.allocations + token_allocations;
        size_t nodes = arena.len;
        free(arena.nodes); free(tokens);
        uint64_t released = now();
        if (nodes != expected_nodes || result != expected) return 93;
        tokenize_ns += split - begin; construct_ns += built - split;
        walk_ns += walked - built; release_ns += released - walked;
    }
    free(text);
    printf("{\"rounds\":%zu,\"result\":%" PRId64 ",\"nodes\":%zu,\"tokenizeNs\":%" PRIu64
        ",\"constructNs\":%" PRIu64 ",\"walkAndReleaseNs\":%" PRIu64 ",\"releaseNs\":%" PRIu64
        ",\"totalNs\":%" PRIu64 ",\"nodeCapacityBytes\":%zu,\"tokenCapacityBytes\":%zu,\"allocations\":%zu,\"nodeSize\":%zu}\n",
        rounds, expected, expected_nodes, tokenize_ns, construct_ns, walk_ns + release_ns, release_ns,
        tokenize_ns + construct_ns + walk_ns + release_ns, node_bytes, token_bytes, allocations, sizeof(Node));
    return 0;
}
