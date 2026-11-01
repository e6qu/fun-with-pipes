static V zip_record_input(size_t n, int64_t offset) {
    V result = 0;
    for (size_t i = n; i; i--) {
        int64_t index = offset + (int64_t)i - 1;
        V point = fwp_rc_fresh(fwp_record(2, (V[]){(V)index, fwp_from_f64((double)index + 0.5)}));
        result = fwp_rc_fresh(fwp_cons(point, result));
    }
    return result;
}
static int zip_record_alias(V xs, size_t length, int64_t offset) {
    size_t count = 0;
    for (V at = xs; at; at = OBJ(at)->f[1]) {
        V point = OBJ(at)->f[0];
        int64_t expected = offset + (int64_t)count;
        if ((int64_t)OBJ(point)->f[0] != expected ||
            fwp_f64(OBJ(point)->f[1]) != (double)expected + 0.5) return 0;
        count++;
    }
    return count == length;
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const size_t sizes[][2] = {{0,0}, {0,7}, {7,0}, {1,1}, {7,3}, {3,7}, {129,129}};
    for (size_t test = 0; test < 7; test++) for (unsigned aliases = 0; aliases < 4; aliases++) {
        size_t n = sizes[test][0], m = sizes[test][1], length = n < m ? n : m;
        double before = fwp_heap.live;
        V ys = zip_record_input(n, 100), xs = zip_record_input(m, 10);
        if (aliases & 1) fwp_rc_dup(xs);
        if (aliases & 2) fwp_rc_dup(ys);
        uint64_t requests = zip_calls, bytes = zip_bytes, retains = zip_retains;
        V result = fTRANSFORM(ys, xs);
        requests = zip_calls - requests; bytes = zip_bytes - bytes; retains = zip_retains - retains;
        size_t count = 0;
        for (V at = result; at; at = OBJ(at)->f[1]) {
            if ((int64_t)OBJ(at)->f[0] != 90) return 239;
            count++;
        }
        if (count != length) return 240;
        /* negative control: remove the result's last-owner destruction */
        fDROP_RESULT(result);
        if (aliases & 1) {
            if (!zip_record_alias(xs, m, 10)) return 241;
            fDROP_INPUT(xs);
        }
        if (aliases & 2) {
            if (!zip_record_alias(ys, n, 100)) return 242;
            fDROP_INPUT(ys);
        }
        if (fwp_heap.live != before) return 238;
        printf("%zu %llu %llu %llu\n", length, (unsigned long long)requests,
               (unsigned long long)bytes, (unsigned long long)retains);
    }
    return 0;
}
