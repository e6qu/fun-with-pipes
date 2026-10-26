int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const V counts[] = {0, 1, 7, 257, 4096};
    for (size_t c=0; c<sizeof(counts)/sizeof(counts[0]); c++) {
        V n = counts[c];
        size_t before = fwp_heap.live;
        range_requests = range_bytes = 0;
        V result = BUILD_SET(n);
        size_t requests = range_requests, bytes = range_bytes;
        size_t expected_requests = n ? (DIRECT ? 1 : n + 3) : 0;
        size_t expected_bytes = n ? (DIRECT ? 8 + 8*n : 16 + 48*n) : 0;
        if (requests != expected_requests || bytes != expected_bytes) return 246;
        if (MAP(result)->len != n) return 247;
        for (V i=0; i<n; i++) if (MAP(result)->d[i] != i) return 247;
        fwp_rc_free_obj(result);
#ifdef FWP_ARC_ONLY
        if (fwp_heap.live != before) return 248;
#else
        (void)before;
#endif
        printf("keys=%llu requests=%zu requested_bytes=%zu\n", (unsigned long long)n, requests, bytes);
    }
    return 0;
}
