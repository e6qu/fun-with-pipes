/* Drives runtime/fwp_rt_h2.c on its own for tests/services.rs. Commands
 * on stdin, one per line; results on stdout:
 *
 *   reset <table-size>                 a new HPACK decoder
 *   hpack <hex>                        decode a header block: "name: value"
 *                                      lines, then "size N" (dynamic table)
 *   enc <schema> <node> <hex>          canonical -> protobuf (hex)
 *   dec <schema> <node> <hex>          protobuf -> canonical (hex)
 *
 * <schema> is a comma-separated list of integers (Schema::flatten). */

#include "../../runtime/fwp_rt_h2.c"

static size_t unhex(const char *s, unsigned char *out) {
    size_t n = 0;
    while (s[0] && s[1] && s[0] != '\n') {
        out[n++] = (unsigned char)(h2_hexval(s[0]) * 16 + h2_hexval(s[1]));
        s += 2;
    }
    return n;
}

static void hex(const h2_buf *b) {
    for (size_t i = 0; i < b->len; i++) printf("%02x", b->d[i]);
    printf("\n");
}

int main(void) {
    static char line[1 << 16];
    static unsigned char bytes[1 << 15];
    static int schema[4096];
    h2_hpack dec;
    h2_hpack_init(&dec);
    while (fgets(line, sizeof line, stdin)) {
        if (strncmp(line, "reset ", 6) == 0) {
            h2_hpack_free(&dec);
            h2_hpack_init(&dec);
            dec.max = dec.limit = (size_t)atoi(line + 6);
        } else if (strncmp(line, "hpack ", 6) == 0) {
            size_t n = unhex(line + 6, bytes);
            h2_hdrs hs = {0};
            if (!h2_hpack_decode(&dec, bytes, n, &hs)) printf("error: %s\n", h2_err);
            for (size_t i = 0; i < hs.n; i++) printf("%s: %s\n", hs.v[i].name, hs.v[i].value);
            printf("size %zu\n", dec.size);
            h2_hdrs_free(&hs);
        } else if (strncmp(line, "enc ", 4) == 0 || strncmp(line, "dec ", 4) == 0) {
            char *p = line + 4;
            int ns = 0;
            for (;;) {
                schema[ns++] = (int)strtol(p, &p, 10);
                if (*p != ',') break;
                p++;
            }
            int node = (int)strtol(p, &p, 10);
            while (*p == ' ') p++;
            size_t n = unhex(p, bytes);
            h2_buf out = {0};
            int ok = line[0] == 'e' ? pb_encode(schema, node, bytes, n, &out) : pb_decode(schema, node, bytes, n, &out);
            if (ok) hex(&out);
            else printf("error: %s\n", h2_err);
            h2b_free(&out);
        }
        fflush(stdout);
    }
    return 0;
}
