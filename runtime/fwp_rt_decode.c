/* Partial decoder values are typed owners. Small field vectors stay on the
 * C stack; larger vectors use scanned scratch so tracing sees pending values.
 * The same cleanup record handles ordinary parse failure and nonlocal exit. */
typedef struct {
    V local[8], *values;
    size_t count, types;
    const fwp_desc *const *descs;
    const fwp_desc *element;
    const fwp_desc *local_types[2];
    int active;
    void *scratch;
    int transferred;
    fwp_cleanup cleanup;
} fwp_decode_fields;

static const fwp_desc *fwp_decode_field_type(const fwp_decode_fields *f, size_t i) {
    return f->element ? f->element : f->descs[i % f->types];
}
static void fwp_decode_fields_release(void *arg) {
    fwp_decode_fields *f = arg;
    if (!f->transferred) for (size_t i = 0; i < f->count; i++) {
        const fwp_desc *d = fwp_decode_field_type(f, i);
        if (d && d->drop) d->drop(f->values[i]);
    }
    if (f->values != f->local) fwp_mem_free(f->values);
    fwp_mem_free(f->scratch);
    f->scratch = NULL;
    f->values = f->local;
    f->count = 0;
}
static void fwp_decode_fields_begin(fwp_decode_fields *f, size_t n,
        const fwp_desc *const *ds, size_t types, const fwp_desc *element) {
    const fwp_desc *t0 = ds == f->local_types ? ds[0] : NULL;
    const fwp_desc *t1 = ds == f->local_types ? ds[1] : NULL;
    memset(f, 0, sizeof *f);
    f->local_types[0] = t0; f->local_types[1] = t1;
    f->active = 1;
    if (n > SIZE_MAX / sizeof(V)) fwp_trap("decoded value too large");
    f->values = f->local;
    f->descs = ds; f->types = types; f->element = element;
    fwp_cleanup_push(&f->cleanup, fwp_decode_fields_release, f);
    if (n > 8) f->values = fwp_mem_alloc(n * sizeof(V));
    f->count = n;
}
static void fwp_decode_fields_resize(fwp_decode_fields *f, size_t count) {
    if (count > SIZE_MAX / sizeof(V)) fwp_trap("decoded value too large");
    V *values = fwp_mem_alloc(count * sizeof(V));
    if (f->count) memcpy(values, f->values, f->count * sizeof(V));
    if (f->values != f->local) fwp_mem_free(f->values);
    f->values = values; f->count = count;
}
static void fwp_decode_fields_end(fwp_decode_fields *f, int transferred) {
    f->transferred = transferred;
    fwp_cleanup_pop(&f->cleanup);
    fwp_decode_fields_release(f);
    f->active = 0;
}

/* Transfer a completed field vector into one fresh aggregate. */
static V fwp_decode_record(fwp_decode_fields *f) {
    V result = fwp_rc_fresh(fwp_record((uint32_t)f->count, f->values));
    fwp_decode_fields_end(f, 1);
    return result;
}
static V fwp_decode_variant(fwp_decode_fields *f, uint32_t tag) {
    V result = fwp_rc_fresh(fwp_data(tag, (uint32_t)f->count, f->values));
    fwp_decode_fields_end(f, 1);
    return result;
}

static V fwp_decode_sequence(fwp_decode_fields *f, const fwp_desc *d) {
    fwp_value_owner owner = {0, d->drop};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    if (d->kind == K_ARRAY) {
        owner.value = fwp_rc_fresh(fwp_array_new_packed(f->count, d->elem));
        fwp_array_set_len(owner.value, 0);
        for (size_t i = 0; i < f->count; i++) {
            fwp_array_store(owner.value, i, f->values[i], d->elem);
            fwp_array_set_len(owner.value, i + 1);
            f->values[i] = 0;
        }
    } else {
        for (size_t i = f->count; i > 0; i--) {
            owner.value = fwp_rc_fresh(fwp_cons(f->values[i - 1], owner.value));
            f->values[i - 1] = 0;
        }
    }
    V result = fwp_value_finish(&owner, &cleanup);
    fwp_decode_fields_end(f, 1);
    return result;
}

/* A decoder owns its map exclusively. Insertion retains borrowed fields and
 * consumes the previous map; the field vector drops discarded duplicate keys. */
static V fwp_decode_map(fwp_decode_fields *f, const fwp_desc *d) {
    fwp_map_ops ops = {d->elem->dup, d->elem2 ? d->elem2->dup : NULL,
        d->elem->drop, d->elem2 ? d->elem2->drop : NULL, d->drop ? d->drop : fwp_rc_drop};
    fwp_value_owner owner = {FWP_EMPTY_MAP, d->drop};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    size_t stride = d->kind == K_SET ? 1 : 2;
    for (size_t i = 0; i < f->count; i += stride) {
        owner.value = fwp_p_map_insert_typed(f->values[i], stride == 1 ? 0 : f->values[i + 1], owner.value, &ops, d->elem);
    }
    V result = fwp_value_finish(&owner, &cleanup);
    fwp_decode_fields_end(f, 0);
    return result;
}
