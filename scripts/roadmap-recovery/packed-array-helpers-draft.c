/* Array descriptors stay outside the payload header. Views retain only
 * pointer-free numeric backing stores; pointer-bearing slices stay copies. */
#define FWP_ARRAY_VIEW_FLAG (UINT64_C(1) << 63)
typedef struct { uint64_t len; V owner; const unsigned char *data; } fwp_array_view;
static inline uint64_t fwp_array_header(V a) {
    uint64_t header; memcpy(&header, (const void *)(uintptr_t)a, sizeof header); return header;
}
static inline size_t fwp_array_len(V a) { return (size_t)(fwp_array_header(a) & ~FWP_ARRAY_VIEW_FLAG); }
static inline int fwp_array_is_view(V a) { return (fwp_array_header(a) & FWP_ARRAY_VIEW_FLAG) != 0; }
static inline const unsigned char *fwp_array_data(V a) {
    if (fwp_array_is_view(a)) {
        const unsigned char *data;
        memcpy(&data, (const unsigned char *)(uintptr_t)a + offsetof(fwp_array_view, data), sizeof data);
        return data;
    }
    return (const unsigned char *)(uintptr_t)a + sizeof(fwp_arr);
}
static inline V fwp_array_owner(V a) {
    if (!fwp_array_is_view(a)) return a;
    V owner; memcpy(&owner, (const unsigned char *)(uintptr_t)a + offsetof(fwp_array_view, owner), sizeof owner); return owner;
}
static inline void fwp_array_set_len(V a, size_t n) {
    if (fwp_array_is_view(a)) fwp_trap("internal: mutating an array view");
    uint64_t len = n; memcpy((void *)(uintptr_t)a, &len, sizeof len);
}
static inline int fwp_array_numeric(const fwp_desc *elem) {
    if (!elem) return 0;
    switch (elem->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64:
    case K_U8: case K_U16: case K_U32: case K_U64:
    case K_F32: case K_F64: return 1;
    default: return 0;
    }
}
static inline size_t fwp_array_stride(const fwp_desc *elem) {
#if FWP_PACKED_ARRAYS
    if (elem) switch (elem->kind) {
    case K_I8: case K_U8: return 1;
    case K_I16: case K_U16: return 2;
    case K_I32: case K_U32: case K_F32: return 4;
    default: break;
    }
#else
    (void)elem;
#endif
    return sizeof(V);
}
static inline int fwp_array_should_view(V a, size_t count, const fwp_desc *elem) {
    if (!count || !fwp_array_numeric(elem)) return 0;
    size_t stride = fwp_array_stride(elem), backing = fwp_array_len(fwp_array_owner(a));
    /* Copy tiny slices and slices retaining more than four times their payload.
     * Division keeps this decision independent of byte-count overflow. */
    return count > sizeof(fwp_array_view) / stride
        && count >= backing / 4 + (backing % 4 != 0);
}
static inline V fwp_array_load(V a, size_t i, const fwp_desc *elem) {
    size_t stride = fwp_array_stride(elem);
    const unsigned char *p = fwp_array_data(a) + i * stride;
    if (stride == sizeof(V)) { V word; memcpy(&word, p, sizeof word); return word; }
    if (stride == 1) {
        uint8_t word; memcpy(&word, p, sizeof word);
        return elem->kind == K_I8 ? (V)(int64_t)(int8_t)word : (V)word;
    }
    if (stride == 2) {
        uint16_t word; memcpy(&word, p, sizeof word);
        return elem->kind == K_I16 ? (V)(int64_t)(int16_t)word : (V)word;
    }
    uint32_t word; memcpy(&word, p, sizeof word);
    return elem->kind == K_I32 ? (V)(int64_t)(int32_t)word : (V)word;
}
static inline void fwp_array_store(V a, size_t i, V value, const fwp_desc *elem) {
    if (fwp_array_is_view(a)) fwp_trap("internal: mutating an array view");
    size_t stride = fwp_array_stride(elem);
    unsigned char *p = (unsigned char *)(uintptr_t)a + sizeof(fwp_arr) + i * stride;
    if (stride == sizeof(V)) { memcpy(p, &value, sizeof value); return; }
    if (stride == 1) { uint8_t word = (uint8_t)value; memcpy(p, &word, sizeof word); return; }
    if (stride == 2) { uint16_t word = (uint16_t)value; memcpy(p, &word, sizeof word); return; }
    uint32_t word = (uint32_t)value; memcpy(p, &word, sizeof word);
}
static V fwp_array_new_packed(size_t n, const fwp_desc *elem) {
    /* Preserve the established count/trap boundary in every layout mode. */
    if (n > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap("array too large");
    size_t bytes = sizeof(fwp_arr) + n * fwp_array_stride(elem);
    void *storage = fwp_array_numeric(elem) ? fwp_alloc_leaf(bytes) : fwp_alloc(bytes);
    V result = PTR(storage); uint64_t len = n; memcpy(storage, &len, sizeof len); return result;
}
