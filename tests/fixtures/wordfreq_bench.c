/* ASCII input comparison for examples/wordfreq.fwp. Sorted pairs, not hashing. */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct { char *word; int64_t count; } Entry;

static void *resize(void *p, size_t bytes) {
    void *next = realloc(p, bytes);
    if (!next) { fputs("out of memory\n", stderr); exit(1); }
    return next;
}

static int whitespace(unsigned char c) {
    return c == ' ' || c == '\t' || c == '\n' || c == '\r';
}

static int rank(const void *left, const void *right) {
    const Entry *a = left, *b = right;
    if (a->count != b->count) return a->count > b->count ? -1 : 1;
    return strcmp(a->word, b->word);
}

int main(void) {
    size_t bytes = 0, capacity = 4096;
    char *input = resize(NULL, capacity);
    for (;;) {
        if (bytes == capacity) {
            if (capacity > SIZE_MAX / 2) return 1;
            input = resize(input, capacity *= 2);
        }
        size_t n = fread(input + bytes, 1, capacity - bytes, stdin);
        bytes += n;
        if (!n) { if (ferror(stdin)) return 1; break; }
    }
    /* Materialize normalized words before counting, as the fwp pipeline does. */
    size_t used = 0, slots = 16;
    char **words = resize(NULL, slots * sizeof *words);
    for (size_t i = 0; i < bytes;) {
        if ((unsigned char)input[i] > 127 || input[i] == 0) return 2;
        if (whitespace((unsigned char)input[i])) { i++; continue; }
        size_t end = i;
        while (end < bytes && !whitespace((unsigned char)input[end])) {
            if ((unsigned char)input[end] > 127 || input[end] == 0) return 2;
            end++;
        }
        char *word = resize(NULL, end - i + 1);
        size_t length = 0;
        while (i < end) {
            unsigned char c = (unsigned char)input[i++];
            if (c == ',' || c == '.') continue;
            word[length++] = (char)(c >= 'A' && c <= 'Z' ? c + 'a' - 'A' : c);
        }
        word[length] = 0;
        if (used == slots) {
            if (slots > SIZE_MAX / 2 / sizeof *words) return 1;
            words = resize(words, (slots *= 2) * sizeof *words);
        }
        words[used++] = word;
    }
    free(input);
    size_t distinct = 0, table_capacity = 16;
    Entry *table = resize(NULL, table_capacity * sizeof *table);
    for (size_t i = 0; i < used; i++) {
        size_t lo = 0, hi = distinct;
        while (lo < hi) {
            size_t mid = lo + (hi - lo) / 2;
            if (strcmp(table[mid].word, words[i]) < 0) lo = mid + 1;
            else hi = mid;
        }
        if (lo < distinct && !strcmp(table[lo].word, words[i])) {
            if (table[lo].count == INT64_MAX) return 3;
            table[lo].count++;
            free(words[i]);
        } else {
            if (distinct == table_capacity) {
                if (table_capacity > SIZE_MAX / 2 / sizeof *table) return 1;
                table = resize(table, (table_capacity *= 2) * sizeof *table);
            }
            memmove(table + lo + 1, table + lo, (distinct - lo) * sizeof *table);
            table[lo] = (Entry){words[i], 1};
            distinct++;
        }
    }
    free(words);
    qsort(table, distinct, sizeof *table, rank);
    for (size_t i = 0; i < distinct && i < 5; i++)
        printf("%s: %lld\n", table[i].word, (long long)table[i].count);
    for (size_t i = 0; i < distinct; i++) free(table[i].word);
    free(table);
    return ferror(stdout) ? 1 : 0;
}
