/* fwp runtime: the protobuf wire format for code generated from .proto
 * files (`fwp proto --import`, lib/grpc.fwp): messages as lists of
 * fields, packed repeated fields, zigzag and float bits. The interpreter's
 * side is in src/grpc.rs. */

/* PbField = { bits: U64, data: Bytes, num: I64, wire: I64 } */

static int fwp_pb_varint(const unsigned char *b, size_t n, size_t *i, uint64_t *x) {
    *x = 0;
    for (int k = 0; k < 10; k++) {
        if (*i >= n) return 0;
        unsigned char c = b[(*i)++];
        *x |= (uint64_t)(c & 0x7f) << (7 * k);
        if (!(c & 0x80)) return 1;
    }
    return 0;
}

static void fwp_pb_put_varint(fwp_buf *b, uint64_t x) {
    while (x >= 0x80) { buf_putc(b, (char)((x & 0x7f) | 0x80)); x >>= 7; }
    buf_putc(b, (char)x);
}

static V fwp_p_pb_parse(V bytes) {
    const unsigned char *b = (const unsigned char *)STR(bytes)->d;
    size_t n = STR(bytes)->len, i = 0, cap = 16, k = 0;
    V *items = (V *)malloc(cap * sizeof(V));
    while (i < n) {
        uint64_t key, bits = 0;
        V data = fwp_str_new("", 0);
        if (!fwp_pb_varint(b, n, &i, &key) || (key >> 3) == 0 || (key >> 3) > 0x7fffffffu) { free(items); return FWP_NONE; }
        int wire = (int)(key & 7);
        if (wire == 0) {
            if (!fwp_pb_varint(b, n, &i, &bits)) { free(items); return FWP_NONE; }
        } else if (wire == 1 || wire == 5) {
            size_t w = wire == 1 ? 8 : 4;
            if (n - i < w) { free(items); return FWP_NONE; }
            for (size_t j = 0; j < w; j++) bits |= (uint64_t)b[i + j] << (8 * j);
            i += w;
        } else if (wire == 2) {
            uint64_t len;
            if (!fwp_pb_varint(b, n, &i, &len) || len > n - i) { free(items); return FWP_NONE; }
            bits = len;
            data = fwp_str_new((const char *)b + i, (size_t)len);
            i += (size_t)len;
        } else {
            free(items);
            return FWP_NONE;
        }
        if (k == cap) { cap *= 2; items = (V *)realloc(items, cap * sizeof(V)); }
        V f[4] = {(V)bits, data, (V)(int64_t)(key >> 3), (V)(int64_t)wire};
        items[k++] = fwp_record(4, f);
    }
    V r = fwp_some(fwp_list_from(items, k));
    free(items);
    return r;
}

static V fwp_p_pb_write(V fields) {
    fwp_buf b = {0};
    for (V xs = fields; xs != 0; xs = OBJ(xs)->f[1]) {
        V f = OBJ(xs)->f[0];
        uint64_t bits = (uint64_t)OBJ(f)->f[0];
        fwp_str *data = STR(OBJ(f)->f[1]);
        uint64_t num = (uint64_t)OBJ(f)->f[2], wire = (uint64_t)OBJ(f)->f[3];
        fwp_pb_put_varint(&b, num << 3 | (wire & 7));
        if (wire == 0) fwp_pb_put_varint(&b, bits);
        else if (wire == 1) for (int j = 0; j < 8; j++) buf_putc(&b, (char)(bits >> (8 * j)));
        else if (wire == 5) for (int j = 0; j < 4; j++) buf_putc(&b, (char)(bits >> (8 * j)));
        else {
            fwp_pb_put_varint(&b, data->len);
            buf_put(&b, data->d, data->len);
        }
    }
    V r = fwp_str_new(b.d ? b.d : "", b.len);
    free(b.d);
    return r;
}

static V fwp_p_pb_zigzag(V v) {
    int64_t n = (int64_t)v;
    return (V)(((uint64_t)n << 1) ^ (uint64_t)(n >> 63));
}

static V fwp_p_pb_unzigzag(V v) {
    uint64_t n = (uint64_t)v;
    return (V)(int64_t)((n >> 1) ^ (uint64_t)(-(int64_t)(n & 1)));
}

static V fwp_p_pb_f32_bits(V v) { return (V)(uint32_t)v; }
static V fwp_p_pb_f32_from_bits(V v) { return (V)(uint32_t)v; }

static V fwp_p_pb_unpack(V wirev, V bytes) {
    int64_t wire = (int64_t)wirev;
    const unsigned char *b = (const unsigned char *)STR(bytes)->d;
    size_t n = STR(bytes)->len, i = 0, cap = 16, k = 0;
    V *items = (V *)malloc(cap * sizeof(V));
    while (i < n) {
        uint64_t x = 0;
        if (wire == 1 || wire == 5) {
            size_t w = wire == 1 ? 8 : 4;
            if (n - i < w) { free(items); return FWP_NONE; }
            for (size_t j = 0; j < w; j++) x |= (uint64_t)b[i + j] << (8 * j);
            i += w;
        } else if (!fwp_pb_varint(b, n, &i, &x)) {
            free(items);
            return FWP_NONE;
        }
        if (k == cap) { cap *= 2; items = (V *)realloc(items, cap * sizeof(V)); }
        items[k++] = (V)x;
    }
    V r = fwp_some(fwp_list_from(items, k));
    free(items);
    return r;
}

static V fwp_p_pb_pack(V wirev, V xs) {
    int64_t wire = (int64_t)wirev;
    fwp_buf b = {0};
    for (; xs != 0; xs = OBJ(xs)->f[1]) {
        uint64_t x = (uint64_t)OBJ(xs)->f[0];
        if (wire == 1) for (int j = 0; j < 8; j++) buf_putc(&b, (char)(x >> (8 * j)));
        else if (wire == 5) for (int j = 0; j < 4; j++) buf_putc(&b, (char)(x >> (8 * j)));
        else fwp_pb_put_varint(&b, x);
    }
    V r = fwp_str_new(b.d ? b.d : "", b.len);
    free(b.d);
    return r;
}
