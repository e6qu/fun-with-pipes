/* Primitives of the standard library (C implementations, mirroring
 * src/interp.rs and src/prims_std.rs). */

static int fwp_argc;
static char **fwp_argv;

/* ------------------------------------------------------------------ lists */

/* Private list cells own their element and tail; reversal transfers those
 * owners in place without acquiring aliases. */
static V fwp_private_cons_owned(V field, V tail) {
    fwp_obj *cell = (fwp_obj *)fwp_alloc(sizeof(fwp_obj) + 2 * sizeof(V));
    cell->tag = 1; cell->n = 2;
    cell->f[0] = field; cell->f[1] = tail;


    return fwp_rc_fresh(PTR(cell));
}
static V fwp_private_reverse_owned(V xs) {
    V result = 0;
    while (xs) {
        V next = OBJ(xs)->f[1];
        OBJ(xs)->f[1] = result;
        result = xs;
        xs = next;
    }
    return result;
}
static V fwp_p_map(V f, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++) a[i] = fwp_apply1(f, a[i]);
    return fwp_list_from(a, n);
}

/* Scratch items borrow the source list. Callback results acquire their own
 * owners before transfer into fresh nodes; never reset their counts. */
static V *fwp_map_items(V xs, size_t *n) {
    V source = xs;
    *n = fwp_list_len(xs);
    if (*n >= SIZE_MAX / sizeof(V)) fwp_trap("map too large");
    V *a = (V *)fwp_mem_alloc((*n + 1) * sizeof(V));
    for (size_t i = 0; xs; i++, xs = OBJ(xs)->f[1]) a[i] = OBJ(xs)->f[0];

    return a;
}
/* The completed prefix owns results; the remaining scratch words borrow the
 * source. During spine construction, each last prefix element transfers into
 * the typed partial list, so an allocation failure has exactly one owner. */
typedef struct {
    V *items;
    size_t count;
    V built;
    void (*element_drop)(V), (*list_drop)(V);
} fwp_map_owner;
static void fwp_map_release(void *arg) {
    fwp_map_owner *owner = arg;
    V *items = owner->items;
    size_t count = owner->count;
    V built = owner->built;
    owner->items = NULL; owner->count = 0; owner->built = 0;
    if (owner->element_drop)
        for (size_t i = 0; i < count; i++) owner->element_drop(items[i]);
    if (built && owner->list_drop) owner->list_drop(built);
    if (items) fwp_mem_free(items);
}
static void fwp_map_protect(fwp_map_owner *owner, fwp_cleanup *cleanup) {
#if FWP_UNWIND
    fwp_cleanup_push(cleanup, fwp_map_release, owner);
#else
    (void)owner; (void)cleanup;
#endif
}
/* Borrowed scratch words carry no child ownership. Protect the first buffer
 * before allocating a second, then free the second before spine construction. */
static void fwp_scratch_release(void *arg) {
    V **slot = arg;
    V *items = *slot;
    *slot = NULL;
    if (items) fwp_mem_free(items);
}
static void fwp_scratch_protect(V **items, fwp_cleanup *cleanup) {
#if FWP_UNWIND
    fwp_cleanup_push(cleanup, fwp_scratch_release, items);
#else
    (void)items; (void)cleanup;
#endif
}
static void fwp_scratch_finish(V **items, fwp_cleanup *cleanup) {
#if FWP_UNWIND
    fwp_cleanup_pop(cleanup);
#else
    (void)cleanup;
#endif

    fwp_scratch_release(items);
}
static V fwp_map_finish_protected(fwp_map_owner *owner, fwp_cleanup *cleanup) {
    while (owner->count) {
        V fields[] = {owner->items[owner->count - 1], owner->built};
        V node = fwp_rc_fresh(fwp_data(1, 2, fields));
        owner->count--;
        owner->built = node;
    }
    V result = owner->built;
#if FWP_UNWIND
    fwp_cleanup_pop(cleanup);
#else
    (void)cleanup;
#endif

    fwp_mem_free(owner->items);
    return result;
}
static V fwp_p_map_owned(V f, V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    for (size_t i = 0; i < n; i++) {
        a[i] = fwp_apply_borrowed(f, 1, &a[i]);
        owner.count++;
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);


    return result;
}

static V fwp_p_filter(V f, V xs) {
    size_t n, k = 0;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++)
        if (fwp_apply1(f, a[i]) == FWP_TRUE) a[k++] = a[i];
    return fwp_list_from(a, k);
}

/* An output alias needs its own reference independently of the
 * temporary owned copy consumed by a callback. Its monomorphic parameter
 * metadata distinguishes pointers from scalar words. */
static void fwp_callback_argument_dup(V f, V element) {
    fwp_clo *c = CLO(f);
    const fwp_fninfo *fi = &fwp_fns[c->fn];
    if (fi->owned) fi->owned->arguments(&element, c->n, 1);
    else fwp_rc_share(element);
}
static V fwp_p_filter_owned(V f, V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    for (size_t i = 0; i < n; i++) {
        if (fwp_apply_borrowed(f, 1, &a[i]) == FWP_TRUE) {
            fwp_callback_argument_dup(f, a[i]);
            a[k++] = a[i];
            owner.count = k;
        }
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);


    return result;
}

/* Prefix selection stops at the first rejected element. The input owner
 * remains live across predicate calls and result-node allocation. */
static V fwp_p_take_while_owned(V f, V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    while (k < n && fwp_apply_borrowed(f, 1, &a[k]) == FWP_TRUE) {
        fwp_callback_argument_dup(f, a[k]);
        k++;
        owner.count = k;
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);


    return result;
}
static V fwp_p_drop_while_owned(V f, V xs) {
    V source = xs;
    while (xs && fwp_apply_borrowed(f, 1, &OBJ(xs)->f[0]) == FWP_TRUE)
        xs = OBJ(xs)->f[1];
    fwp_rc_dup(xs);


    return xs;
}

/* A consumed accumulator stays here while preparing scratch or borrowed
 * callback arguments, and moves to the callback before its entry can tick. */
typedef struct { V value; void (*drop)(V); } fwp_value_owner;
static void fwp_value_release(void *arg) {
    fwp_value_owner *owner = arg;
    V value = owner->value;
    owner->value = 0;
    if (owner->drop && value) owner->drop(value);
}
static void fwp_value_protect(fwp_value_owner *owner, fwp_cleanup *cleanup) {
#if FWP_UNWIND
    if (owner->drop) fwp_cleanup_push(cleanup, fwp_value_release, owner);
#else
    (void)owner; (void)cleanup;
#endif
}
static V fwp_value_finish(fwp_value_owner *owner, fwp_cleanup *cleanup) {
#if FWP_UNWIND
    if (owner->drop) fwp_cleanup_pop(cleanup);
#else
    (void)cleanup;
#endif
    V value = owner->value;
    owner->value = 0;
    return value;
}
/* Move uniquely owned String-list heads into the callback and build an owned
 * result. String leaves have no resource-close effects; other element types
 * do not use this path. */
static V fwp_p_map_strings_owned(V f, V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    fwp_value_owner source = {xs, list_drop}; fwp_cleanup source_cleanup;
    fwp_value_protect(&source, &source_cleanup);
    size_t n;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    V cursor = xs;
    int borrowed_tail = 0;
    for (size_t i = 0; i < n; i++) {
        V node = cursor, tail = OBJ(node)->f[1];
        if (!borrowed_tail && fwp_rc_unique(node) == 1) {
            source.value = tail;
            fwp_rc_free_obj(node);
        } else {
            /* Keep the first shared tail owned through all remaining calls.
             * Only callback arguments need additional references. */
            borrowed_tail = 1;
            fwp_rc_dup(a[i]);
        }
        cursor = tail;
        a[i] = fwp_apply_borrowed_span(f, 1, &a[i], 0, 1);
        owner.count++;
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);
    fwp_value_release(&source);
    fwp_value_finish(&source, &source_cleanup);

    return result;
}

/* Ternary conversion traverses borrowed input directly. List results own their
 * completed prefix, so allocation failure releases it without retaining temporary storage. */
static V fwp_p_tint_trits(V v, int w, void (*drop_list)(V)) {
    int64_t x = (int64_t)v;
    fwp_value_owner owner = {0, drop_list};
    fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);
    for (int i = 0; i < w; i++) {
        int64_t r = ((x % 3) + 3) % 3;
        int64_t digit = r == 2 ? -1 : r;
        owner.value = fwp_rc_fresh(fwp_cons((V)digit, owner.value));
        x = (x - digit) / 3;
    }
    return fwp_value_finish(&owner, &cleanup);
}

static V fwp_p_tint_from_trits(V xs, int w) {
    V source = xs;
    int count = 0;
    i128 acc = 0;
    for (; xs; xs = OBJ(xs)->f[1]) {
        if (count++ == w) return FWP_NONE;
        acc = acc * 3 + (int64_t)OBJ(xs)->f[0];
    }
    V out;
    V result = fwp_int_fits(acc, K_TINT, w, &out) ? fwp_some(out) : FWP_NONE;
    return result;
}

static V fwp_p_tint_of_int(V x, int w) {
    V out;
    return fwp_int_fits((int64_t)x, K_TINT, w, &out) ? fwp_some(out) : FWP_NONE;
}

static V fwp_p_trits_pack(V xs) {
    V source = xs;
    size_t n = fwp_list_len(xs), nb = n / 5 + (n % 5 != 0);
    if (nb > SIZE_MAX - sizeof(fwp_str) - 1) fwp_trap("packed trits too large");
    fwp_str *result = fwp_alloc_leaf(sizeof(fwp_str) + nb + 1);
    result->len = nb; result->d[nb] = 0;
    for (size_t c = 0; c < nb; c++) {
        uint32_t byte = 0, power = 1;
        for (size_t k = 0; k < 5 && xs; k++, power *= 3, xs = OBJ(xs)->f[1])
            byte += (uint32_t)((int64_t)OBJ(xs)->f[0] + 1) * power;
        result->d[c] = (char)(uint8_t)byte;
    }
    return PTR(result);
}

static V fwp_p_trits_unpack(V nv, V bs, void (*drop_list)(V)) {
    uint64_t n = (int64_t)nv < 0 ? 0 : (uint64_t)nv;
    /* Compare before multiplying so even a wide byte length cannot overflow. */
    if (STR(bs)->len <= n / 5) n = STR(bs)->len * 5;
    static const uint32_t power[5] = {1, 3, 9, 27, 81};
    fwp_value_owner owner = {0, drop_list};
    fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);
    for (uint64_t i = n; i > 0; i--) {
        uint32_t byte = (uint8_t)STR(bs)->d[(i - 1) / 5];
        V digit = (V)((int64_t)((byte / power[(i - 1) % 5]) % 3) - 1);
        owner.value = fwp_rc_fresh(fwp_cons(digit, owner.value));
    }
    return fwp_value_finish(&owner, &cleanup);
}

static V fwp_p_fold(V f, V z, V xs) {
    while (xs != 0) { z = fwp_apply2(f, z, OBJ(xs)->f[0]); xs = OBJ(xs)->f[1]; }
    return z;
}

static V fwp_p_fold_own(V f, V z, V xs) {
    V source = xs;
    while (xs != 0) {
        V args[] = {z, OBJ(xs)->f[0]};
        z = fwp_apply_borrowed_prefix(f, 2, args, 1);
        xs = OBJ(xs)->f[1];
    }


    return z;
}

static V fwp_p_fold_right(V f, V z, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = n; i > 0; i--) z = fwp_apply2(f, a[i - 1], z);

    return z;
}

static V fwp_p_fold_right_own(V f, V z, V xs, void (*accumulator_drop)(V)) {
    fwp_value_owner owner = {z, accumulator_drop};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    size_t n;
    V *a = fwp_map_items(xs, &n);
    fwp_cleanup scratch_cleanup;
    fwp_scratch_protect(&a, &scratch_cleanup);
    for (size_t i = n; i > 0; i--) {
        V args[] = {a[i - 1], owner.value};
        owner.value = 0;
        owner.value = fwp_apply_borrowed_span(f, 2, args, 1, 1);
    }
    fwp_scratch_finish(&a, &scratch_cleanup);


    return fwp_value_finish(&owner, &cleanup);
}

/* stable merge sort of (key, value) pairs */
static void fwp_msort(V *keys, V *vals, size_t n, const fwp_desc *d, V *tk, V *tv) {
    if (n < 2) return;
    size_t m = n / 2;
    fwp_msort(keys, vals, m, d, tk, tv);
    fwp_msort(keys + m, vals + m, n - m, d, tk, tv);
    size_t i = 0, j = m, k = 0;
    while (i < m && j < n) {
        if (fwp_cmp(keys[j], keys[i], d) < 0) { tk[k] = keys[j]; tv[k++] = vals[j++]; }
        else { tk[k] = keys[i]; tv[k++] = vals[i++]; }
    }
    while (i < m) { tk[k] = keys[i]; tv[k++] = vals[i++]; }
    while (j < n) { tk[k] = keys[j]; tv[k++] = vals[j++]; }
    memcpy(keys, tk, n * sizeof(V));
    /* Keys-only callers share lanes; copying the same output twice is wasteful. */
    if (vals != keys) memcpy(vals, tv, n * sizeof(V));
}

static void fwp_sort_array(V *a, size_t n, const fwp_desc *d) {
    V *tk = (V *)fwp_alloc((n + 1) * sizeof(V));
    V *tv = (V *)fwp_alloc((n + 1) * sizeof(V));
    V *vals = (V *)fwp_alloc((n + 1) * sizeof(V));
    memcpy(vals, a, n * sizeof(V));
    fwp_msort(a, vals, n, d, tk, tv);
}

static V fwp_p_sort(V xs, const fwp_desc *elem) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    fwp_sort_array(a, n, elem);
    return fwp_list_from(a, n);
}

static V fwp_p_sort_by(V f, V xs, const fwp_desc *key) {
    size_t n;
    V *vals = fwp_list_items(xs, &n);
    V *keys = (V *)fwp_alloc((n + 1) * sizeof(V));
    for (size_t i = 0; i < n; i++) keys[i] = fwp_apply1(f, vals[i]);
    V *tk = (V *)fwp_alloc((n + 1) * sizeof(V));
    V *tv = (V *)fwp_alloc((n + 1) * sizeof(V));
    fwp_msort(keys, vals, n, key, tk, tv);
    return fwp_list_from(vals, n);
}

static V fwp_p_length(V xs) { return (V)(int64_t)fwp_list_len(xs); }

static V fwp_p_reverse(V xs) {
    V r = 0;
    while (xs != 0) { r = fwp_cons(OBJ(xs)->f[0], r); xs = OBJ(xs)->f[1]; }
    return r;
}

static V fwp_p_append(V ys, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    V r = ys;
    for (size_t i = n; i > 0; i--) r = fwp_cons(a[i - 1], r);

    return r;
}

static V fwp_p_flatten(V xss) {
    size_t n;
    V *a = fwp_list_items(xss, &n);
    V r = 0;
    for (size_t i = n; i > 0; i--) r = fwp_p_append(r, a[i - 1]);

    return r;
}

/* Borrow input lanes, consume the owned suffix and construct counted nodes.
 * Each copied element is protected before allocating its node. A failed retain
 * or allocation releases the partial list without touching borrowed inputs. */
static V fwp_copy_finish(V *a, size_t n, V owned_tail, const fwp_desc *list) {
    fwp_value_owner result = {owned_tail, list->drop};
    fwp_cleanup cleanup; fwp_value_protect(&result, &cleanup);
    for (size_t i = n; i; i--) {
        V value = a[i - 1];
        if (list->elem->dup) list->elem->dup(value);
        fwp_value_owner pending = {value, list->elem->drop};
        fwp_cleanup pending_cleanup; fwp_value_protect(&pending, &pending_cleanup);
        result.value = fwp_rc_fresh(fwp_cons(value, result.value));
        (void)fwp_value_finish(&pending, &pending_cleanup);
    }

    return fwp_value_finish(&result, &cleanup);
}
/* Inline keys own their String field, without an object header or count per key.
 * Merge scratch holds borrowed copies; comparisons cannot call user code or
 * suspend, so cleanup sees the fully restored main buffer after each merge. */
typedef struct { int64_t number; V text; } fwp_i64_string_key;
typedef struct {
    fwp_i64_string_key *keys;
    size_t count;
    void (*drop_text)(V);
} fwp_i64_string_keys;
static void fwp_i64_string_keys_release(void *arg) {
    fwp_i64_string_keys *owner = arg;
    fwp_i64_string_key *keys = owner->keys;
    size_t count = owner->count;
    owner->keys = NULL; owner->count = 0;
    for (size_t i = 0; i < count; i++) owner->drop_text(keys[i].text);
    if (keys) fwp_mem_free(keys);
}
static void fwp_i64_string_msort(fwp_i64_string_key *keys, V *vals, size_t n,
                                const fwp_desc *text, fwp_i64_string_key *tk, V *tv) {
    if (n < 2) return;
    size_t m = n / 2;
    fwp_i64_string_msort(keys, vals, m, text, tk, tv);
    fwp_i64_string_msort(keys + m, vals + m, n - m, text, tk, tv);
    size_t i = 0, j = m, k = 0;
    while (i < m && j < n) {
        int less = keys[j].number < keys[i].number ||
            (keys[j].number == keys[i].number && fwp_cmp(keys[j].text, keys[i].text, text) < 0);
        if (less) { tk[k] = keys[j]; tv[k++] = vals[j++]; }
        else { tk[k] = keys[i]; tv[k++] = vals[i++]; }
    }
    while (i < m) { tk[k] = keys[i]; tv[k++] = vals[i++]; }
    while (j < n) { tk[k] = keys[j]; tv[k++] = vals[j++]; }
    memcpy(keys, tk, n * sizeof(fwp_i64_string_key));
    memcpy(vals, tv, n * sizeof(V));
}

/* Plain sorting uses the same words as keys and values; one merge buffer is
 * sufficient. The source list keeps every borrowed element alive. */
static V fwp_p_sort_copied(V xs, const fwp_desc *elem, const fwp_desc *list) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&a, &scratch_cleanup);
    if (n > 1) {
        V *tk = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        fwp_cleanup tk_cleanup; fwp_scratch_protect(&tk, &tk_cleanup);
        fwp_msort(a, a, n, elem, tk, tk);
        fwp_scratch_finish(&tk, &tk_cleanup);
    }
    V result = fwp_copy_finish(a, n, 0, list);
    fwp_scratch_finish(&a, &scratch_cleanup);

    return result;
}
/* Own each completed callback key while output values borrow the source.
 * Failure/cancellation releases keys already returned and every scratch lane. */
static V fwp_p_sort_by_copied(V f, V xs, const fwp_desc *key,
                             void (*drop_key)(V), const fwp_desc *list) {
    size_t n;
    V *vals = fwp_map_items(xs, &n);
    fwp_cleanup vals_cleanup; fwp_scratch_protect(&vals, &vals_cleanup);
    V *keys = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    fwp_map_owner owner = {keys, 0, 0, drop_key, NULL};
    fwp_cleanup keys_cleanup; fwp_map_protect(&owner, &keys_cleanup);
    for (size_t i = 0; i < n; i++) {
        keys[i] = fwp_apply_borrowed(f, 1, &vals[i]);
        owner.count++;
    }
    if (n > 1) {
        V *tk = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        fwp_cleanup tk_cleanup; fwp_scratch_protect(&tk, &tk_cleanup);
        V *tv = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        fwp_cleanup tv_cleanup; fwp_scratch_protect(&tv, &tv_cleanup);
        fwp_msort(keys, vals, n, key, tk, tv);
        fwp_scratch_finish(&tv, &tv_cleanup);
        fwp_scratch_finish(&tk, &tk_cleanup);
    }
#if FWP_UNWIND
    fwp_cleanup_pop(&keys_cleanup);
#endif
    fwp_map_release(&owner);
    V result = fwp_copy_finish(vals, n, 0, list);
    fwp_scratch_finish(&vals, &vals_cleanup);


    return result;
}
static V fwp_p_reverse_copied(V xs, const fwp_desc *list) {
    V source = xs;
    fwp_value_owner result = {0, list->drop};
    fwp_cleanup cleanup; fwp_value_protect(&result, &cleanup);
    while (xs) {
        V value = OBJ(xs)->f[0];
        if (list->elem->dup) list->elem->dup(value);
        fwp_value_owner pending = {value, list->elem->drop};
        fwp_cleanup pending_cleanup; fwp_value_protect(&pending, &pending_cleanup);
        result.value = fwp_rc_fresh(fwp_cons(value, result.value));
        (void)fwp_value_finish(&pending, &pending_cleanup);
        xs = OBJ(xs)->f[1];
    }

    return fwp_value_finish(&result, &cleanup);
}
static V fwp_p_append_copied(V ys, V xs, const fwp_desc *list) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    fwp_cleanup cleanup; fwp_scratch_protect(&a, &cleanup);
    fwp_rc_dup(ys);
    V result = fwp_copy_finish(a, n, ys, list);
    fwp_scratch_finish(&a, &cleanup);


    return result;
}
static V fwp_p_flatten_copied(V xss, const fwp_desc *list) {
    size_t n;
    V *a = fwp_map_items(xss, &n);
    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&a, &scratch_cleanup);
    fwp_value_owner result = {0, list->drop};
    fwp_cleanup cleanup; fwp_value_protect(&result, &cleanup);
    for (size_t i = n; i; i--) {
        size_t count;
        V *items = fwp_map_items(a[i - 1], &count);
        fwp_cleanup items_cleanup; fwp_scratch_protect(&items, &items_cleanup);
        V tail = result.value;
        result.value = 0;
        result.value = fwp_copy_finish(items, count, tail, list);
        fwp_scratch_finish(&items, &items_cleanup);
    }
    V value = fwp_value_finish(&result, &cleanup);
    fwp_scratch_finish(&a, &scratch_cleanup);

    return value;
}

static size_t fwp_count_arg(V n) { uint64_t count = (int64_t)n < 0 ? 0 : n; return count > SIZE_MAX ? SIZE_MAX : (size_t)count; }

static V fwp_p_take(V n, V xs) {
    size_t k = fwp_count_arg(n), len;
    V *a = fwp_list_items(xs, &len);
    return fwp_list_from(a, k < len ? k : len);
}

static V fwp_p_drop(V n, V xs) {
    size_t k = fwp_count_arg(n);
    while (k-- > 0 && xs != 0) xs = OBJ(xs)->f[1];
    return xs;
}

static V fwp_p_take_copied(V n, V xs, const fwp_desc *list) {
    size_t len;
    V *a = fwp_map_items(xs, &len);
    fwp_cleanup cleanup; fwp_scratch_protect(&a, &cleanup);
    size_t k = fwp_count_arg(n);
    V result = fwp_copy_finish(a, k < len ? k : len, 0, list);
    fwp_scratch_finish(&a, &cleanup);

    return result;
}
static V fwp_p_drop_owned(V n, V xs) {
    V result = fwp_p_drop(n, xs);
    fwp_rc_dup(result);
    return result;
}

static V fwp_p_take_while(V f, V xs) {
    size_t n, k = 0;
    V *a = fwp_list_items(xs, &n);
    while (k < n && fwp_apply1(f, a[k]) == FWP_TRUE) k++;
    return fwp_list_from(a, k);
}

static V fwp_p_drop_while(V f, V xs) {
    while (xs != 0 && fwp_apply1(f, OBJ(xs)->f[0]) == FWP_TRUE) xs = OBJ(xs)->f[1];
    return xs;
}

/* `loop`: iterate a step function in constant stack space (pure, so also
 * available on WebAssembly) */
static V fwp_p_loop(V f, V s) {
    for (;;) {
        FWP_TICK();
        V r = fwp_apply1(f, s);
        if (fwp_tag(r) != 0) return OBJ(r)->f[0];
        s = OBJ(r)->f[0];
    }
}

/* A Step owns its selected payload. Take a typed extra reference before
 * releasing the Step, so shared/aliased boxes are safe as well as unique ones. */
static V fwp_loop_payload(V step, int stop, void (*dup_state)(V),
                          void (*dup_result)(V), void (*drop_step)(V)) {
    fwp_value_owner owner = {step, drop_step};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    V value = OBJ(step)->f[0];
    void (*duplicate)(V) = stop ? dup_result : dup_state;
    if (duplicate) duplicate(value);
    fwp_value_finish(&owner, &cleanup);
    if (drop_step) drop_step(step);
    return value;
}
static V fwp_p_loop_own(V f, V s, void (*dup_state)(V),
                         void (*dup_result)(V), void (*drop_step)(V), void (*drop_state)(V)) {
    fwp_value_owner owner = {s, drop_state};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    for (;;) {
        FWP_TICK();
        s = owner.value;
        owner.value = 0;
        V step = fwp_apply_borrowed_prefix(f, 1, &s, 1);
        int stop = fwp_tag(step) != 0;
        s = fwp_loop_payload(step, stop, dup_state, dup_result, drop_step);
        if (stop) { fwp_value_finish(&owner, &cleanup); return s; }
        owner.value = s;
    }
}
static V fwp_k_loop_owned(V (*entry)(V *), V s, void (*dup_state)(V),
                           void (*dup_result)(V), void (*drop_step)(V), void (*drop_state)(V)) {
    fwp_value_owner owner = {s, drop_state};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    for (;;) {
        FWP_TICK();
        s = owner.value;
        owner.value = 0;
        V step = entry(&s);
        int stop = fwp_tag(step) != 0;
        s = fwp_loop_payload(step, stop, dup_state, dup_result, drop_step);
        if (stop) { fwp_value_finish(&owner, &cleanup); return s; }
        owner.value = s;
    }
}

/* The higher-order primitives above for a known function with nothing
 * captured (src/cgen.rs, `known_hof`): the C compiler inlines them at the
 * call, so the function is called directly instead of through
 * fwp_apply. Same order of calls and the same results. */
typedef V (*fwp_fn1)(V);
typedef V (*fwp_fn2)(V, V);
#define FWP_K static inline __attribute__((always_inline))

FWP_K V fwp_k_map(fwp_fn1 f, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++) a[i] = f(a[i]);
    return fwp_list_from(a, n);
}

FWP_K V fwp_k_map_owned(fwp_fn1 f, V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    for (size_t i = 0; i < n; i++) {
        a[i] = f(a[i]);
        owner.count++;
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);

    return result;
}
FWP_K V fwp_k_map_strings_owned(V (*f)(V *), V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    fwp_value_owner source = {xs, list_drop}; fwp_cleanup source_cleanup;
    fwp_value_protect(&source, &source_cleanup);
    size_t n;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    V cursor = xs;
    int borrowed_tail = 0;
    for (size_t i = 0; i < n; i++) {
        V node = cursor, tail = OBJ(node)->f[1];
        if (!borrowed_tail && fwp_rc_unique(node) == 1) {
            source.value = tail;
            fwp_rc_free_obj(node);
        } else {
            /* Keep the first shared tail owned through all remaining calls.
             * Only callback arguments need additional references. */
            borrowed_tail = 1;
            fwp_rc_dup(a[i]);
        }
        cursor = tail;
        a[i] = f(&a[i]);
        owner.count++;
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);
    fwp_value_release(&source);
    fwp_value_finish(&source, &source_cleanup);
    return result;
}


FWP_K V fwp_k_filter(fwp_fn1 f, V xs) {
    size_t n, k = 0;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++)
        if (f(a[i]) == FWP_TRUE) a[k++] = a[i];
    return fwp_list_from(a, k);
}

FWP_K V fwp_k_filter_owned(fwp_fn1 f, void (*element_dup)(V *, uint32_t, uint32_t), V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    for (size_t i = 0; i < n; i++) {
        if (f(a[i]) == FWP_TRUE) {
            element_dup(&a[i], 0, 1);
            a[k++] = a[i];
            owner.count = k;
        }
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);

    return result;
}

FWP_K V fwp_k_take_while_owned(fwp_fn1 f, void (*element_dup)(V *, uint32_t, uint32_t), V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    while (k < n && f(a[k]) == FWP_TRUE) {
        element_dup(&a[k], 0, 1);
        k++;
        owner.count = k;
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);

    return result;
}
FWP_K V fwp_k_drop_while_owned(fwp_fn1 f, V xs) {
    V source = xs;
    while (xs && f(OBJ(xs)->f[0]) == FWP_TRUE) xs = OBJ(xs)->f[1];
    fwp_rc_dup(xs);

    return xs;
}

FWP_K V fwp_k_fold(fwp_fn2 f, V z, V xs) {
    while (xs != 0) { z = f(z, OBJ(xs)->f[0]); xs = OBJ(xs)->f[1]; }
    return z;
}

FWP_K V fwp_k_fold_owned(fwp_fn2 f, V z, V xs) {
    V source = xs;
    while (xs != 0) {
        z = f(z, OBJ(xs)->f[0]);
        xs = OBJ(xs)->f[1];
    }

    return z;
}

FWP_K V fwp_k_fold_right(fwp_fn2 f, V z, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = n; i > 0; i--) z = f(a[i - 1], z);

    return z;
}

FWP_K V fwp_k_fold_right_owned(fwp_fn2 f, V z, V xs, void (*accumulator_drop)(V)) {
    fwp_value_owner owner = {z, accumulator_drop};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    size_t n;
    V *a = fwp_map_items(xs, &n);
    fwp_cleanup scratch_cleanup;
    fwp_scratch_protect(&a, &scratch_cleanup);
    for (size_t i = n; i > 0; i--) {
        V next = owner.value;
        owner.value = 0;
        owner.value = f(a[i - 1], next);
    }
    fwp_scratch_finish(&a, &scratch_cleanup);

    return fwp_value_finish(&owner, &cleanup);
}

FWP_K V fwp_k_take_while(fwp_fn1 f, V xs) {
    size_t n, k = 0;
    V *a = fwp_list_items(xs, &n);
    while (k < n && f(a[k]) == FWP_TRUE) k++;
    return fwp_list_from(a, k);
}

FWP_K V fwp_k_drop_while(fwp_fn1 f, V xs) {
    while (xs != 0 && f(OBJ(xs)->f[0]) == FWP_TRUE) xs = OBJ(xs)->f[1];
    return xs;
}

FWP_K V fwp_k_loop(fwp_fn1 f, V s) {
    for (;;) {
        FWP_TICK();
        V r = f(s);
        if (fwp_tag(r) != 0) return OBJ(r)->f[0];
        s = OBJ(r)->f[0];
    }
}

FWP_K V fwp_k_zip_with(fwp_fn2 f, V ys, V xs) {
    size_t n, m;
    V *a = fwp_list_items(xs, &n);
    V *b = fwp_list_items(ys, &m);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) a[i] = f(b[i], a[i]);
    return fwp_list_from(a, k);
}

FWP_K V fwp_k_zip_with_owned(fwp_fn2 f, V ys, V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t n, m;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    V *b = fwp_map_items(ys, &m);
    fwp_cleanup scratch_cleanup;
    fwp_scratch_protect(&b, &scratch_cleanup);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) {
        a[i] = f(b[i], a[i]);
        owner.count++;
    }
    fwp_scratch_finish(&b, &scratch_cleanup);
    V result = fwp_map_finish_protected(&owner, &cleanup);


    return result;
}

static V fwp_p_zip(V ys, V xs) {
    size_t n, m;
    V *a = fwp_list_items(xs, &n);
    V *b = fwp_list_items(ys, &m);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) a[i] = fwp_tuple2(a[i], b[i]);
    return fwp_list_from(a, k);
}

/* Duplicate only statically reference-bearing fields, never scalar bits. */
static V fwp_p_zip_owned(V ys, V xs, void (*dup_x)(V), void (*dup_y)(V),
        void (*drop_x)(V), void (*drop_y)(V), void (*drop_pair)(V), void (*drop_list)(V)) {
    size_t n, m;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, drop_pair, drop_list};
    fwp_cleanup cleanup; fwp_map_protect(&owner, &cleanup);
    V *b = fwp_map_items(ys, &m);
    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&b, &scratch_cleanup);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) {
        if (dup_x) dup_x(a[i]);
        fwp_value_owner left = {a[i], drop_x}; fwp_cleanup left_cleanup;
        fwp_value_protect(&left, &left_cleanup);
        if (dup_y) dup_y(b[i]);
        fwp_value_owner right = {b[i], drop_y}; fwp_cleanup right_cleanup;
        fwp_value_protect(&right, &right_cleanup);
        a[i] = fwp_rc_fresh(fwp_tuple2(left.value, right.value));
        owner.count++;
        (void)fwp_value_finish(&right, &right_cleanup);
        (void)fwp_value_finish(&left, &left_cleanup);
    }
    fwp_scratch_finish(&b, &scratch_cleanup);
    V result = fwp_map_finish_protected(&owner, &cleanup);


    return result;
}

/* data-last: the subject's element is the last argument (f y x) */
static V fwp_p_zip_with(V f, V ys, V xs) {
    size_t n, m;
    V *a = fwp_list_items(xs, &n);
    V *b = fwp_list_items(ys, &m);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) a[i] = fwp_apply2(f, b[i], a[i]);
    return fwp_list_from(a, k);
}

static V fwp_p_zip_with_owned(V f, V ys, V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t n, m;
    V *a = fwp_map_items(xs, &n);
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    V *b = fwp_map_items(ys, &m);
    fwp_cleanup scratch_cleanup;
    fwp_scratch_protect(&b, &scratch_cleanup);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) {
        V args[] = {b[i], a[i]};
        a[i] = fwp_apply_borrowed(f, 2, args);
        owner.count++;
    }
    fwp_scratch_finish(&b, &scratch_cleanup);
    V result = fwp_map_finish_protected(&owner, &cleanup);



    return result;
}

static V fwp_p_unzip(V ps) {
    size_t n;
    V *a = fwp_list_items(ps, &n);
    V *l = (V *)fwp_alloc((n + 1) * sizeof(V));
    V *r = (V *)fwp_alloc((n + 1) * sizeof(V));
    for (size_t i = 0; i < n; i++) { l[i] = OBJ(a[i])->f[0]; r[i] = OBJ(a[i])->f[1]; }
    return fwp_tuple2(fwp_list_from(l, n), fwp_list_from(r, n));
}

static V fwp_p_unzip_owned(V ps, void (*dup_x)(V), void (*dup_y)(V),
        void (*drop_x)(V), void (*drop_y)(V), void (*drop_left)(V), void (*drop_right)(V)) {
    size_t n;
    V *a = fwp_map_items(ps, &n);
    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&a, &scratch_cleanup);
    V *l = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    fwp_map_owner left = {l, 0, 0, drop_x, drop_left};
    fwp_cleanup left_cleanup; fwp_map_protect(&left, &left_cleanup);
    V *r = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    fwp_map_owner right = {r, 0, 0, drop_y, drop_right};
    fwp_cleanup right_cleanup; fwp_map_protect(&right, &right_cleanup);
    for (size_t i = 0; i < n; i++) {
        l[i] = OBJ(a[i])->f[0]; r[i] = OBJ(a[i])->f[1];
        if (dup_x) dup_x(l[i]);
        left.count++;
        if (dup_y) dup_y(r[i]);
        right.count++;
    }
    /* Both result owners must remain protected until the outer pair exists.
     * Build the left spine first, preserving the ordinary construction order. */
    for (int side = 0; side < 2; side++) {
        fwp_map_owner *owner = side ? &right : &left;
        while (owner->count) {
            V fields[] = {owner->items[owner->count - 1], owner->built};
            V node = fwp_rc_fresh(fwp_data(1, 2, fields));
            owner->count--;
            owner->built = node;
        }
    }
    V result = fwp_rc_fresh(fwp_tuple2(left.built, right.built));
    left.built = right.built = 0;
#if FWP_UNWIND
    fwp_cleanup_pop(&right_cleanup);
#endif
    fwp_map_release(&right);
#if FWP_UNWIND
    fwp_cleanup_pop(&left_cleanup);
#endif
    fwp_map_release(&left);
    fwp_scratch_finish(&a, &scratch_cleanup);

    return result;
}

static V fwp_p_repeat(V n, V x) {
    size_t k = fwp_count_arg(n);
    V r = 0;
    for (size_t i = 0; i < k; i++) r = fwp_cons(x, r);
    return r;
}

static V fwp_p_repeat_owned(V n, V x, void (*dup_element)(V),
        void (*drop_element)(V), void (*drop_list)(V)) {
    size_t k = fwp_count_arg(n);
    fwp_value_owner result = {0, drop_list}, pending = {0, drop_element};
    fwp_cleanup result_cleanup, pending_cleanup;
    fwp_value_protect(&result, &result_cleanup);
    fwp_value_protect(&pending, &pending_cleanup);
    for (size_t i = 0; i < k; i++) {
        if (dup_element) dup_element(x);
        pending.value = x;
        V fields[] = {x, result.value};
        result.value = fwp_rc_fresh(fwp_data(1, 2, fields));
        pending.value = 0;
    }
    (void)fwp_value_finish(&pending, &pending_cleanup);

    return fwp_value_finish(&result, &result_cleanup);
}

static V fwp_p_nth(V n, V xs) {
    if ((int64_t)n < 0) return FWP_NONE;
    for (int64_t i = 0; xs != 0; i++, xs = OBJ(xs)->f[1])
        if (i == (int64_t)n) return fwp_some(OBJ(xs)->f[0]);
    return FWP_NONE;
}

static V fwp_p_find(V f, V xs) {
    for (; xs != 0; xs = OBJ(xs)->f[1])
        if (fwp_apply1(f, OBJ(xs)->f[0]) == FWP_TRUE) return fwp_some(OBJ(xs)->f[0]);
    return FWP_NONE;
}

/* The wrapper owns the new Option node and duplicates its typed field.
 * The predicate consumes only temporary argument copies, never the source. */
static V fwp_p_find_borrowed(V f, V xs) {
    V source = xs, result = FWP_NONE;
    while (xs) {
        V element = OBJ(xs)->f[0];
        if (fwp_apply_borrowed(f, 1, &element) == FWP_TRUE) {
            result = fwp_some(element);
            break;
        }
        xs = OBJ(xs)->f[1];
    }


    return result;
}
FWP_K V fwp_k_find_owned(fwp_fn1 f, void (*element_dup)(V *, uint32_t, uint32_t), V xs) {
    V source = xs, result = FWP_NONE;
    while (xs) {
        V element = OBJ(xs)->f[0];
        if (f(element) == FWP_TRUE) {
            element_dup(&element, 0, 1);
            result = fwp_rc_fresh(fwp_some(element));
            break;
        }
        xs = OBJ(xs)->f[1];
    }

    return result;
}

static V fwp_p_index_of(V x, V xs, const fwp_desc *d) {
    for (int64_t i = 0; xs != 0; i++, xs = OBJ(xs)->f[1])
        if (fwp_eq(OBJ(xs)->f[0], x, d)) return fwp_some((V)i);
    return FWP_NONE;
}

static V fwp_p_unique(V xs, const fwp_desc *d) {
    size_t n, k = 0;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++) {
        int seen = 0;
        for (size_t j = 0; j < k && !seen; j++) seen = fwp_cmp(a[j], a[i], d) == 0;
        if (!seen) a[k++] = a[i];
    }
    return fwp_list_from(a, k);
}

static V fwp_p_unique_copied(V xs, const fwp_desc *d, const fwp_desc *list) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    fwp_cleanup cleanup; fwp_scratch_protect(&a, &cleanup);
    for (size_t i = 0; i < n; i++) {
        int seen = 0;
        for (size_t j = 0; j < k && !seen; j++) seen = fwp_cmp(a[j], a[i], d) == 0;
        if (!seen) a[k++] = a[i];
    }
    V result = fwp_copy_finish(a, k, 0, list);
    fwp_scratch_finish(&a, &cleanup);

    return result;
}

static V fwp_p_scan(V f, V z, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    V *out = (V *)fwp_alloc((n + 2) * sizeof(V));
    out[0] = z;
    for (size_t i = 0; i < n; i++) { z = fwp_apply2(f, z, a[i]); out[i + 1] = z; }
    return fwp_list_from(out, n + 1);
}

/* Each stored state keeps its output reference while the callback borrows
 * it for the next step. Only the initial state comes from a borrowed input. */
static V fwp_p_scan_owned(V f, V z, V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    V initial = z;
    size_t n;
    V *a = fwp_map_items(xs, &n);
    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&a, &scratch_cleanup);
    if (n > SIZE_MAX / sizeof(V) - 2) fwp_trap("scan too large");
    V *out = (V *)fwp_mem_alloc((n + 2) * sizeof(V));
    fwp_map_owner owner = {out, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup; fwp_map_protect(&owner, &cleanup);
    fwp_callback_argument_dup(f, z);
    out[0] = z;
    owner.count++;
    for (size_t i = 0; i < n; i++) {
        V args[] = {z, a[i]};
        z = fwp_apply_borrowed(f, 2, args);
        out[i + 1] = z;
        owner.count++;
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);
    fwp_scratch_finish(&a, &scratch_cleanup);



    return result;
}

static V fwp_p_chunks(V n, V xs) {
    if ((int64_t)n <= 0) fwp_trap("chunks: size must be positive");
    size_t k = fwp_count_arg(n), len;
    V *a = fwp_list_items(xs, &len);
    size_t nc = len / k + (len % k != 0);
    V *cs = (V *)fwp_alloc((nc + 1) * sizeof(V));
    for (size_t c = 0; c < nc; c++) {
        size_t s = c * k, count = len - s < k ? len - s : k;
        cs[c] = fwp_list_from(a + s, count);
    }
    return fwp_list_from(cs, nc);
}

static V fwp_p_chunks_owned(V n, V xs, void (*dup_element)(V),
        void (*drop_element)(V), void (*drop_chunk)(V), void (*drop_result)(V)) {
    if ((int64_t)n <= 0) fwp_trap("chunks: size must be positive");
    size_t k = fwp_count_arg(n), len;
    V *a = fwp_map_items(xs, &len);
    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&a, &scratch_cleanup);
    /* Avoid overflowing len + k - 1, including very large valid sizes. */
    size_t nc = len / k + (len % k != 0);
    V *cs = (V *)fwp_mem_alloc((nc + 1) * sizeof(V));
    fwp_map_owner chunks = {cs, 0, 0, drop_chunk, drop_result};
    fwp_cleanup chunks_cleanup; fwp_map_protect(&chunks, &chunks_cleanup);
    fwp_value_owner chunk = {0, drop_chunk}, pending = {0, drop_element};
    fwp_cleanup chunk_cleanup, pending_cleanup;
    fwp_value_protect(&chunk, &chunk_cleanup);
    fwp_value_protect(&pending, &pending_cleanup);
    for (size_t c = 0, start = 0; c < nc; c++) {
        size_t count = len - start < k ? len - start : k;
        for (size_t j = count; j; j--) {
            V value = a[start + j - 1];
            if (dup_element) dup_element(value);
            pending.value = value;
            V fields[] = {value, chunk.value};
            chunk.value = fwp_rc_fresh(fwp_data(1, 2, fields));
            pending.value = 0;
        }
        cs[c] = chunk.value;
        chunks.count++;
        chunk.value = 0;
        start += count;
    }
    (void)fwp_value_finish(&pending, &pending_cleanup);
    (void)fwp_value_finish(&chunk, &chunk_cleanup);
    V result = fwp_map_finish_protected(&chunks, &chunks_cleanup);
    fwp_scratch_finish(&a, &scratch_cleanup);

    return result;
}

static V fwp_p_iterate(V n, V f, V x) {
    size_t k = fwp_count_arg(n);
    V *a = (V *)fwp_alloc((k + 1) * sizeof(V));
    for (size_t i = 0; i < k; i++) {
        a[i] = x;
        if (i + 1 < k) x = fwp_apply1(f, x);
    }
    return fwp_list_from(a, k);
}

static V fwp_p_iterate_owned(V n, V f, V x, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t k = fwp_count_arg(n);
    if (!k) return 0;
    V initial = x;
    if (k >= SIZE_MAX / sizeof(V)) fwp_trap("iterate too large");
    V *a = (V *)fwp_mem_alloc((k + 1) * sizeof(V));
    fwp_map_owner owner = {a, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup; fwp_map_protect(&owner, &cleanup);
    fwp_callback_argument_dup(f, x);
    a[0] = x;
    owner.count++;
    for (size_t i = 1; i < k; i++) {
        x = fwp_apply_borrowed(f, 1, &x);
        a[i] = x;
        owner.count++;
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);


    return result;
}

static V fwp_p_flat_map(V f, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++) a[i] = fwp_apply1(f, a[i]);
    V r = 0;
    for (size_t i = n; i > 0; i--) r = fwp_p_append(r, a[i - 1]);

    return r;
}

static V fwp_p_list_ap(V fs, V xs) {
    size_t nf, nx;
    V *f = fwp_list_items(fs, &nf);
    V *x = fwp_list_items(xs, &nx);
    V *out = (V *)fwp_alloc((nf * nx + 1) * sizeof(V));
    size_t k = 0;
    for (size_t i = 0; i < nf; i++)
        for (size_t j = 0; j < nx; j++) out[k++] = fwp_apply1(f[i], x[j]);
    return fwp_list_from(out, k);
}

/* Call every callback before rebuilding the flattened output, preserving
 * function/input trap order. Returned chunks and copied aliases have distinct
 * owners until each counted output node takes its element. */
static V fwp_p_flat_map_owned(V f, V xs, void (*element_dup)(V), void (*element_drop)(V), void (*list_drop)(V)) {
    size_t n;
    V *items = fwp_map_items(xs, &n);
    fwp_map_owner chunks = {items, 0, 0, list_drop, NULL};
    fwp_cleanup chunks_cleanup;
    fwp_map_protect(&chunks, &chunks_cleanup);
    for (size_t i = 0; i < n; i++) {
        items[i] = fwp_apply_borrowed(f, 1, &items[i]);
        chunks.count++;
    }
    fwp_value_owner result = {0, list_drop};
    fwp_cleanup result_cleanup;
    fwp_value_protect(&result, &result_cleanup);
    for (size_t i = n; i; i--) {
        size_t count;
        V *aliases = fwp_map_items(items[i - 1], &count);
        fwp_map_owner copy = {aliases, 0, result.value, element_drop, list_drop};
        fwp_cleanup copy_cleanup;
        fwp_map_protect(&copy, &copy_cleanup);
        result.value = 0;
        for (size_t j = 0; j < count; j++) {
            if (element_dup) element_dup(aliases[j]);
            copy.count++;
        }
        result.value = fwp_map_finish_protected(&copy, &copy_cleanup);
    }
    /* The completed output stays protected while owned chunks are destroyed.
     * The emptied chunk owner remains safe if destruction itself unwinds. */
    fwp_map_release(&chunks);
    V output = fwp_value_finish(&result, &result_cleanup);
#if FWP_UNWIND
    fwp_cleanup_pop(&chunks_cleanup);
#endif


    return output;
}

/* Own every completed Cartesian-product callback result until its list node
 * takes it. Borrowed function/input scratch remains rooted and unwinds separately. */
static size_t fwp_list_ap_count(size_t nf, size_t nx) {
    size_t maximum = SIZE_MAX / sizeof(V) - 1;
    if (nf && nx > maximum / nf) fwp_trap("list.ap too large");
    return nf * nx;
}
static V fwp_p_list_ap_owned(V fs, V xs, void (*element_drop)(V), void (*list_drop)(V)) {
    size_t nf, nx;
    V *functions = fwp_map_items(fs, &nf);
    fwp_cleanup functions_cleanup;
    fwp_scratch_protect(&functions, &functions_cleanup);
    V *inputs = fwp_map_items(xs, &nx);
    fwp_cleanup inputs_cleanup;
    fwp_scratch_protect(&inputs, &inputs_cleanup);
    size_t count = fwp_list_ap_count(nf, nx);
    V *out = (V *)fwp_mem_alloc((count + 1) * sizeof(V));
    fwp_map_owner owner = {out, 0, 0, element_drop, list_drop};
    fwp_cleanup cleanup;
    fwp_map_protect(&owner, &cleanup);
    for (size_t i = 0; i < nf; i++) {
        for (size_t j = 0; j < nx; j++) {
            out[owner.count] = fwp_apply_borrowed(functions[i], 1, &inputs[j]);
            owner.count++;
        }
    }
    V result = fwp_map_finish_protected(&owner, &cleanup);
    fwp_scratch_finish(&inputs, &inputs_cleanup);
    fwp_scratch_finish(&functions, &functions_cleanup);


    return result;
}

/* ---------------------------------------------------------------- strings */

static int fwp_is_space(char c) { return c == ' ' || c == '\t' || c == '\n' || c == '\r'; }
static int fwp_is_cont(unsigned char c) { return (c & 0xC0) == 0x80; }

static V fwp_p_trim_impl(V s, int start, int end) {
    const char *d = STR(s)->d;
    size_t a = 0, b = STR(s)->len;
    if (start) while (a < b && fwp_is_space(d[a])) a++;
    if (end) while (b > a && fwp_is_space(d[b - 1])) b--;
    if (!a && b == STR(s)->len) return s;
    return fwp_str_new(d + a, b - a);
}

static V fwp_p_case(V s, int upper) {
    size_t first = 0, length = STR(s)->len;
    char low = upper ? 'a' : 'A', high = upper ? 'z' : 'Z';
    while (first < length && (STR(s)->d[first] < low || STR(s)->d[first] > high)) first++;
    if (first == length) return s;
    V r = fwp_rc_unique(s) == 1 ? s : fwp_str_new(STR(s)->d, STR(s)->len);
    char *d = STR(r)->d;
    for (size_t i = first; i < length; i++) {
        if (upper && d[i] >= 'a' && d[i] <= 'z') d[i] -= 32;
        if (!upper && d[i] >= 'A' && d[i] <= 'Z') d[i] += 32;
    }
    return r;
}

static V fwp_p_concat(V t, V s) {
    const size_t limit = SIZE_MAX - sizeof(fwp_str) - 1;
    if (STR(s)->len > limit || STR(t)->len > limit - STR(s)->len) fwp_trap("string too large");
    fwp_str *r = (fwp_str *)fwp_alloc_leaf(sizeof(fwp_str) + STR(s)->len + STR(t)->len + 1);
    r->len = STR(s)->len + STR(t)->len;
    memcpy(r->d, STR(s)->d, STR(s)->len);
    memcpy(r->d + STR(s)->len, STR(t)->d, STR(t)->len);
    r->d[r->len] = 0;
    return PTR(r);
}

static size_t fwp_utf8_count(const char *d, size_t n) {
    size_t c = 0;
    for (size_t i = 0; i < n; i++) c += !fwp_is_cont((unsigned char)d[i]);
    return c;
}

/* byte offset of the k-th character (or n) */
static size_t fwp_utf8_offset(const char *d, size_t n, size_t k) {
    size_t i = 0;
    while (i < n && k > 0) {
        i++;
        while (i < n && fwp_is_cont((unsigned char)d[i])) i++;
        k--;
    }
    return i;
}

static V fwp_p_chars(V s) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len, cnt = fwp_utf8_count(d, n), k = 0, i = 0;
    V *a = (V *)fwp_mem_alloc((cnt + 1) * sizeof(V));
    while (i < n) {
        size_t j = i + 1;
        while (j < n && fwp_is_cont((unsigned char)d[j])) j++;
        a[k++] = fwp_str_new(d + i, j - i);
        i = j;
    }
    V result = fwp_list_from(a, k);
    fwp_mem_free(a);
    return result;
}

static const char *fwp_memmem(const char *h, size_t hn, const char *nd, size_t nn) {
    if (nn == 0) return h;
    if (nn > hn) return 0;
    for (size_t i = 0; i + nn <= hn; i++)
        if (memcmp(h + i, nd, nn) == 0) return h + i;
    return 0;
}

static V fwp_p_split(V sep, V s) {
    if (STR(sep)->len == 0) return fwp_p_chars(s);
    const char *d = STR(s)->d, *end = d + STR(s)->len;
    size_t cap = 8, k = 0;
    V *a = (V *)fwp_mem_alloc(cap * sizeof(V));
    for (;;) {
        const char *p = fwp_memmem(d, (size_t)(end - d), STR(sep)->d, STR(sep)->len);
        if (k == cap) { cap *= 2; a = (V *)fwp_mem_realloc(a, cap / 2 * sizeof(V), cap * sizeof(V)); }
        if (!p) { a[k++] = fwp_str_new(d, (size_t)(end - d)); break; }
        a[k++] = fwp_str_new(d, (size_t)(p - d));
        d = p + STR(sep)->len;
    }
    V r = fwp_list_from(a, k);
    fwp_mem_free(a);
    return r;
}

static V fwp_p_join(V sep, V xs) {
    fwp_buf b = {0};
    int first = 1;
    for (; xs != 0; xs = OBJ(xs)->f[1]) {
        if (!first) buf_put(&b, STR(sep)->d, STR(sep)->len);
        first = 0;
        V p = OBJ(xs)->f[0];
        buf_put(&b, STR(p)->d, STR(p)->len);
    }
    return buf_to_str(&b);
}

static V fwp_lines_of(const char *d, size_t n, void (*drop_list)(V)) {
    size_t cap = 8, i = 0;
    fwp_map_owner owner = {(V *)fwp_mem_alloc(cap * sizeof(V)), 0, 0,
                           fwp_rc_free_obj, drop_list};
    fwp_cleanup cleanup; fwp_map_protect(&owner, &cleanup);
    while (i < n) {
        size_t j = i;
        while (j < n && d[j] != '\n') j++;
        size_t e = j;
        if (j < n && e > i && d[e - 1] == '\r') e--;
        if (owner.count == cap) {
            if (cap > SIZE_MAX / sizeof(V) / 2) fwp_trap("too many lines");
            owner.items = (V *)fwp_mem_realloc(owner.items, cap * sizeof(V), cap * 2 * sizeof(V));
            cap *= 2;
        }
        owner.items[owner.count] = fwp_rc_fresh(fwp_str_new(d + i, e - i));
        owner.count++;
        i = j + 1;
    }
    return fwp_map_finish_protected(&owner, &cleanup);
}

static V fwp_p_lines(V s, void (*drop_list)(V)) {
    V result = fwp_lines_of(STR(s)->d, STR(s)->len, drop_list);
    return result;
}

static V fwp_p_words(V s) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len, i = 0, cap = 8, k = 0;
    V *a = (V *)fwp_mem_alloc(cap * sizeof(V));
    while (i < n) {
        while (i < n && fwp_is_space(d[i])) i++;
        size_t j = i;
        while (j < n && !fwp_is_space(d[j])) j++;
        if (j > i) {
            if (k == cap) { cap *= 2; a = (V *)fwp_mem_realloc(a, cap / 2 * sizeof(V), cap * sizeof(V)); }
            a[k++] = fwp_str_new(d + i, j - i);
        }
        i = j;
    }
    V r = fwp_list_from(a, k);
    fwp_mem_free(a);
    return r;
}

static V fwp_p_str_contains(V nd, V s) {
    return fwp_memmem(STR(s)->d, STR(s)->len, STR(nd)->d, STR(nd)->len) != 0;
}

static V fwp_p_starts_with(V p, V s) {
    return STR(p)->len <= STR(s)->len && memcmp(STR(s)->d, STR(p)->d, STR(p)->len) == 0;
}

static V fwp_p_ends_with(V p, V s) {
    return STR(p)->len <= STR(s)->len &&
           memcmp(STR(s)->d + STR(s)->len - STR(p)->len, STR(p)->d, STR(p)->len) == 0;
}

static V fwp_p_replace(V from, V to, V s) {
    size_t from_len = STR(from)->len, to_len = STR(to)->len;
    if (!from_len) return s;
    if (from_len == to_len && !memcmp(STR(from)->d, STR(to)->d, from_len)) return s;
    const char *d = STR(s)->d, *end = d + STR(s)->len;
    const char *first = fwp_memmem(d, (size_t)(end - d), STR(from)->d, from_len);
    if (!first) return s;
    fwp_str *result;
    if (to_len <= from_len && fwp_rc_unique(s) == 1) {
        result = STR(s);
    } else {
        size_t count = 0;
        const char *p = first;
        do {
            count++;
            const char *next = p + from_len;
            p = fwp_memmem(next, (size_t)(end - next), STR(from)->d, from_len);
        } while (p);
        size_t length = STR(s)->len;
        if (to_len > from_len) {
            size_t extra = to_len - from_len;
            /* Preserve buffer-size failure before the String size check. */
            if (length == SIZE_MAX || count > (SIZE_MAX - length - 1) / extra) {
                fprintf(stderr, "fwp: out of memory\n");
                fflush(NULL); _Exit(102);
            }
            length += count * extra;
        } else {
            /* Non-overlapping matches guarantee count * from_len <= input length. */
            length -= count * (from_len - to_len);
        }
        if (length > SIZE_MAX - sizeof(fwp_str) - 1) fwp_trap("string too large");
        result = (fwp_str *)fwp_alloc_leaf(sizeof(fwp_str) + length + 1);
    }
    char *out = result->d;
    const char *p = first;
    do {
        size_t prefix = (size_t)(p - d);
        /* With unique reuse, writes end before the next unread source byte.
         * A source-aliasing pattern matches the whole input once. A replacement
         * alias is either growing or handled by the unchanged-text shortcut. */
        memmove(out, d, prefix); out += prefix;
        memcpy(out, STR(to)->d, to_len); out += to_len;
        d = p + from_len;
        p = fwp_memmem(d, (size_t)(end - d), STR(from)->d, from_len);
    } while (p);
    size_t tail = (size_t)(end - d);
    memmove(out, d, tail); out += tail;
    result->len = (size_t)(out - result->d);
    *out = 0;
    return PTR(result);
}

static V fwp_p_str_repeat(V n, V s) {
    size_t k = fwp_count_arg(n);
    if (!k || !STR(s)->len) return fwp_str_new("", 0);
    size_t length = STR(s)->len;
    if (k > (SIZE_MAX - 1) / length) {
        fprintf(stderr, "fwp: out of memory\n");
        fflush(NULL); _Exit(102);
    }
    size_t total = k * length;
    if (total > SIZE_MAX - sizeof(fwp_str) - 1) fwp_trap("string too large");
    fwp_str *result = (fwp_str *)fwp_alloc_leaf(sizeof(fwp_str) + total + 1);
    result->len = total;
    memcpy(result->d, STR(s)->d, length);
    /* Each destination starts after the initialized prefix; memcpy never overlaps. */
    for (size_t filled = length; filled < total;) {
        size_t next = filled < total - filled ? filled : total - filled;
        memcpy(result->d + filled, result->d, next);
        filled += next;
    }
    result->d[total] = 0;
    return PTR(result);
}

static V fwp_p_str_reverse(V s) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len;
    fwp_str *r = (fwp_str *)fwp_alloc_leaf(sizeof(fwp_str) + n + 1);
    r->len = n;
    size_t i = 0;
    while (i < n) {
        size_t j = i + 1;
        while (j < n && fwp_is_cont((unsigned char)d[j])) j++;
        memcpy(r->d + (n - j), d + i, j - i);
        i = j;
    }
    r->d[n] = 0;
    return PTR(r);
}

static V fwp_p_str_slice(V start, V len, V s) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len;
    size_t cnt = fwp_utf8_count(d, n);
    size_t st = fwp_count_arg(start);
    if (st > cnt) st = cnt;
    size_t count = fwp_count_arg(len);
    if (count > cnt - st) count = cnt - st;
    size_t e = st + count;
    size_t a = fwp_utf8_offset(d, n, st), b = fwp_utf8_offset(d, n, e);
    return fwp_str_new(d + a, b - a);
}

static V fwp_p_str_find(V nd, V s) {
    const char *p = fwp_memmem(STR(s)->d, STR(s)->len, STR(nd)->d, STR(nd)->len);
    if (!p) return FWP_NONE;
    return fwp_some((V)(int64_t)fwp_utf8_count(STR(s)->d, (size_t)(p - STR(s)->d)));
}

static V fwp_p_pad(V n, V fill, V s, int left) {
    size_t want = fwp_count_arg(n);
    size_t len = fwp_utf8_count(STR(s)->d, STR(s)->len);
    if (STR(fill)->len == 0 || len >= want) return s;
    size_t fl = fwp_utf8_offset(STR(fill)->d, STR(fill)->len, 1);
    fwp_buf b = {0};
    if (!left) buf_put(&b, STR(s)->d, STR(s)->len);
    for (size_t i = len; i < want; i++) buf_put(&b, STR(fill)->d, fl);
    if (left) buf_put(&b, STR(s)->d, STR(s)->len);
    return buf_to_str(&b);
}

/* decode one UTF-8 scalar at d[*i] (input is valid UTF-8) */
static uint32_t fwp_utf8_next(const unsigned char *d, size_t *i) {
    uint32_t c = d[*i];
    int extra = c < 0x80 ? 0 : c < 0xE0 ? 1 : c < 0xF0 ? 2 : 3;
    c &= extra == 0 ? 0x7F : extra == 1 ? 0x1F : extra == 2 ? 0x0F : 0x07;
    (*i)++;
    for (int k = 0; k < extra; k++) c = (c << 6) | (d[(*i)++] & 0x3F);
    return c;
}

static void fwp_utf8_put(fwp_buf *b, uint32_t c) {
    char t[4];
    if (c < 0x80) { t[0] = (char)c; buf_put(b, t, 1); }
    else if (c < 0x800) { t[0] = (char)(0xC0 | (c >> 6)); t[1] = (char)(0x80 | (c & 0x3F)); buf_put(b, t, 2); }
    else if (c < 0x10000) {
        t[0] = (char)(0xE0 | (c >> 12)); t[1] = (char)(0x80 | ((c >> 6) & 0x3F));
        t[2] = (char)(0x80 | (c & 0x3F)); buf_put(b, t, 3);
    } else {
        t[0] = (char)(0xF0 | (c >> 18)); t[1] = (char)(0x80 | ((c >> 12) & 0x3F));
        t[2] = (char)(0x80 | ((c >> 6) & 0x3F)); t[3] = (char)(0x80 | (c & 0x3F)); buf_put(b, t, 4);
    }
}

static V fwp_p_codepoints(V s) {
    const unsigned char *d = (const unsigned char *)STR(s)->d;
    size_t n = STR(s)->len, i = 0, k = 0;
    V *a = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    while (i < n) a[k++] = fwp_utf8_next(d, &i);
    V result = fwp_list_from(a, k);
    fwp_mem_free(a);
    return result;
}

static V fwp_p_from_codepoints(V xs) {
    fwp_buf b = {0};
    for (; xs != 0; xs = OBJ(xs)->f[1]) {
        uint32_t c = (uint32_t)OBJ(xs)->f[0];
        if (c > 0x10FFFF || (c >= 0xD800 && c <= 0xDFFF)) { free(b.d); return FWP_NONE; }
        fwp_utf8_put(&b, c);
    }
    return fwp_some(buf_to_str(&b));
}

/* strict UTF-8 validation (as Rust's str::from_utf8) */
static int fwp_valid_utf8(const unsigned char *d, size_t n) {
    size_t i = 0;
    while (i < n) {
        unsigned char c = d[i];
        if (c < 0x80) { i++; continue; }
        int extra;
        uint32_t cp, min;
        if (c >= 0xC2 && c <= 0xDF) { extra = 1; cp = c & 0x1F; min = 0x80; }
        else if (c >= 0xE0 && c <= 0xEF) { extra = 2; cp = c & 0x0F; min = 0x800; }
        else if (c >= 0xF0 && c <= 0xF4) { extra = 3; cp = c & 0x07; min = 0x10000; }
        else return 0;
        if (i + extra >= n + 0 && i + extra > n - 1 + 1) return 0;
        if (i + (size_t)extra >= n) return 0;
        for (int k = 1; k <= extra; k++) {
            if ((d[i + k] & 0xC0) != 0x80) return 0;
            cp = (cp << 6) | (d[i + k] & 0x3F);
        }
        if (cp < min || cp > 0x10FFFF || (cp >= 0xD800 && cp <= 0xDFFF)) return 0;
        i += (size_t)extra + 1;
    }
    return 1;
}

/* text from outside the program (stdin, arguments, the environment):
 * each maximal invalid subsequence becomes U+FFFD, exactly as Rust's
 * String::from_utf8_lossy */
static void fwp_buf_release(void *arg) { free(((fwp_buf *)arg)->d); }
static V fwp_str_lossy(const char *s, size_t n) {
    const unsigned char *d = (const unsigned char *)s;
    if (fwp_valid_utf8(d, n)) return fwp_str_new(s, n);
    fwp_buf b = {0};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_buf_release, &b);
    size_t i = 0;
    while (i < n) {
        unsigned char c = d[i];
        if (c < 0x80) { buf_putc(&b, (char)c); i++; continue; }
        int need;
        unsigned char lo = 0x80, hi = 0xBF;
        if (c >= 0xC2 && c <= 0xDF) need = 1;
        else if (c >= 0xE0 && c <= 0xEF) { need = 2; if (c == 0xE0) lo = 0xA0; if (c == 0xED) hi = 0x9F; }
        else if (c >= 0xF0 && c <= 0xF4) { need = 3; if (c == 0xF0) lo = 0x90; if (c == 0xF4) hi = 0x8F; }
        else { buf_puts(&b, "\xEF\xBF\xBD"); i++; continue; }
        size_t j = i + 1;
        int k = 0;
        while (k < need && j < n) {
            unsigned char x = d[j];
            if (k == 0 ? (x < lo || x > hi) : (x & 0xC0) != 0x80) break;
            j++;
            k++;
        }
        if (k == need) buf_put(&b, s + i, j - i);
        else buf_puts(&b, "\xEF\xBF\xBD");
        i = j;
    }
    V result = buf_to_str(&b);
    fwp_cleanup_pop(&cleanup);
    return result;
}

static V fwp_p_from_bytes(V b) {
    if (!fwp_valid_utf8((const unsigned char *)STR(b)->d, STR(b)->len)) return FWP_NONE;
    return fwp_some(fwp_str_new(STR(b)->d, STR(b)->len));
}

static int fwp_valid_int(const char *s, size_t n) {
    size_t i = 0;
    if (i < n && (s[i] == '+' || s[i] == '-')) i++;
    if (i == n) return 0;
    for (; i < n; i++) if (s[i] < '0' || s[i] > '9') return 0;
    return 1;
}

static int fwp_valid_float(const char *s, size_t n) {
    size_t i = 0, a, idig, fdig = 0;
    if (i < n && (s[i] == '+' || s[i] == '-')) i++;
    a = i;
    while (i < n && s[i] >= '0' && s[i] <= '9') i++;
    idig = i - a;
    if (i < n && s[i] == '.') {
        i++;
        size_t f = i;
        while (i < n && s[i] >= '0' && s[i] <= '9') i++;
        fdig = i - f;
    }
    if (idig == 0 && fdig == 0) return 0;
    if (i < n && (s[i] == 'e' || s[i] == 'E')) {
        i++;
        if (i < n && (s[i] == '+' || s[i] == '-')) i++;
        size_t e = i;
        while (i < n && s[i] >= '0' && s[i] <= '9') i++;
        if (i == e) return 0;
    }
    return i == n;
}

/* Parse an integer literal into a value of numeric kind `k` (width w for
 * TInt); returns Option. */
static V fwp_int_in_range(int neg, u128 mag, int k, int w, V *out);

static int fwp_parse_integer_bytes(const char *d, size_t n, int kind, int w, V *out) {
    if (!fwp_valid_int(d, n)) return 0;
    int neg = d[0] == '-';
    size_t i = (d[0] == '-' || d[0] == '+') ? 1 : 0;
    u128 mag = 0;
    for (; i < n; i++) {
        u128 next = mag * 10 + (u128)(d[i] - '0');
        if (next / 10 != mag) return 0;
        mag = next;
    }
    return fwp_int_in_range(neg, mag, kind, w, out);
}

static V fwp_p_parse_int(V s, int kind, int w) {
    V out;
    if (!fwp_parse_integer_bytes(STR(s)->d, STR(s)->len, kind, w, &out)) return FWP_NONE;
    return fwp_some(out);
}

/* ASCII case-insensitive comparison of d[0..n) with a lower-case word */
static int fwp_word_ci(const char *d, size_t n, const char *w) {
    size_t i = 0;
    for (; i < n && w[i]; i++) {
        char c = d[i];
        if (c >= 'A' && c <= 'Z') c = (char)(c - 'A' + 'a');
        if (c != w[i]) return 0;
    }
    return i == n && w[i] == 0;
}

static V fwp_p_parse_float(V s, int kind) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len, o = (n > 0 && (d[0] == '-' || d[0] == '+')) ? 1 : 0;
    /* non-finite values, in any case: nan, and inf or infinity with an
     * optional sign */
    if (fwp_word_ci(d + o, n - o, "inf") || fwp_word_ci(d + o, n - o, "infinity")) {
        double x = d[0] == '-' ? -INFINITY : INFINITY;
        return fwp_some(fwp_float_of(kind, x));
    }
    if (fwp_word_ci(d, n, "nan"))
        return fwp_some(fwp_float_of(kind, NAN));
    if (!fwp_valid_float(STR(s)->d, STR(s)->len)) return FWP_NONE;
#ifdef FWP_EXACT_FLOAT
    if (kind == K_F16 || kind == K_BF16 || kind == K_F128) {
        V out; return fwp_parse_exact(d, kind, &out) ? fwp_some(out) : FWP_NONE;
    }
#endif
    if (kind == K_F32) return fwp_some(fwp_from_f32(strtof(STR(s)->d, 0)));
    return fwp_some(fwp_from_f64(strtod(STR(s)->d, 0)));
}

/* Formatting writes directly into one private buffer. The cleanup owns it
 * across recoverable traps; no managed strings or parts array are temporary. */
static V fwp_p_format(V tmpl, V v, const fwp_desc *d) {
    int tuple = d->kind == K_RECORD && !d->name && d->n > 0;
    int np = tuple ? d->n : 1;
    const char *t = STR(tmpl)->d;
    size_t n = STR(tmpl)->len, i = 0;
    int holes = 0;
    while (i < n) {
        if (i + 1 < n && ((t[i] == '{' && t[i + 1] == '{') || (t[i] == '}' && t[i + 1] == '}'))) i += 2;
        else if (i + 1 < n && t[i] == '{' && t[i + 1] == '}') { holes++; i += 2; }
        else i++;
    }
    fwp_buf b = {0};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_buf_release, &b);
    if (holes != np) {
        char num[128];
        snprintf(num, sizeof num, "format: placeholder count (%d) does not match value count (%d) in \"", holes, np);
        buf_puts(&b, num);
        buf_put(&b, t, n);
        buf_putc(&b, '"');
        fwp_trap(b.d);
    }
    i = 0;
    int next = 0;
    while (i < n) {
        if (t[i] == '{' && i + 1 < n && t[i + 1] == '{') { buf_putc(&b, '{'); i += 2; }
        else if (t[i] == '}' && i + 1 < n && t[i + 1] == '}') { buf_putc(&b, '}'); i += 2; }
        else if (t[i] == '{' && i + 1 < n && t[i + 1] == '}') {
            fwp_write(&b, tuple ? OBJ(v)->f[next] : v, tuple ? d->fields[next] : d, 1);
            next++;
            i += 2;
        } else { buf_putc(&b, t[i]); i++; }
    }
    V result = buf_to_str(&b);
    fwp_cleanup_pop(&cleanup);

    return result;
}

/* --------------------------------------------------------------- arrays */

static V fwp_p_array_from_list(V xs) {
    size_t n = fwp_list_len(xs);
    V a = fwp_arr_new(n);
    for (size_t i = 0; i < n; i++) { ARR(a)->d[i] = OBJ(xs)->f[0]; xs = OBJ(xs)->f[1]; }
    return a;
}

static V fwp_p_array_to_list(V a) { return fwp_list_from(ARR(a)->d, ARR(a)->len); }

static V fwp_p_array_get(V i, V a) {
    if ((int64_t)i < 0 || (uint64_t)(int64_t)i >= ARR(a)->len) return FWP_NONE;
    return fwp_some(ARR(a)->d[(int64_t)i]);
}

static V fwp_p_array_copy(V a, size_t extra) {
    V r = fwp_arr_new(ARR(a)->len + extra);
    memcpy(ARR(r)->d, ARR(a)->d, ARR(a)->len * sizeof(V));
    return r;
}

static V fwp_p_array_set(V i, V x, V a) {
    if ((int64_t)i < 0 || (uint64_t)(int64_t)i >= ARR(a)->len) return FWP_NONE;
    V r = fwp_p_array_copy(a, 0);
    ARR(r)->d[(int64_t)i] = x;
    return fwp_some(r);
}

static V fwp_p_array_push(V x, V a) {
    V r = fwp_p_array_copy(a, 1);
    ARR(r)->d[ARR(a)->len] = x;
    return r;
}

/* `array.set` and `array.push` given the only reference to the array
 * (src/rc.rs: compiled code passes it on): written in place when it is
 * unique, else copied (and the reference given up). The results are
 * counted (fwp_rc_fresh): compiled code owns them. */
static V fwp_p_array_set_own(V i, V x, V a) {
    if ((int64_t)i < 0 || (uint64_t)(int64_t)i >= ARR(a)->len) {
        fwp_rc_drop(a);
        return FWP_NONE;
    }
    int u = fwp_rc_unique_mut(a);
    V r = a;
    if (u != 1) {
        r = fwp_rc_fresh(fwp_p_array_copy(a, 0));
        fwp_rc_drop(a);
    }
    ARR(r)->d[(int64_t)i] = x;
    return fwp_rc_fresh(fwp_some(r));
}

static V fwp_p_array_push_own(V x, V a) {
    size_t n = ARR(a)->len;
    int u = fwp_rc_unique_mut(a);
    if (u == 1 && fwp_rc_capacity(a) >= sizeof(fwp_arr) + (n + 1) * sizeof(V)) {
        ARR(a)->d[n] = x;
        ARR(a)->len = n + 1;
        return a;
    }
    /* an array pushed to while unique grows by doubling */
    V r = fwp_arr_new(u ? (n < 4 ? 4 : 2 * n) : n + 1);
    memcpy(ARR(r)->d, ARR(a)->d, n * sizeof(V));
    ARR(r)->len = n + 1;
    ARR(r)->d[n] = x;
    fwp_rc_drop(a);
    return fwp_rc_fresh(r);
}

static V fwp_p_array_make(V n, V x) {
    size_t k = fwp_count_arg(n);
    V r = fwp_arr_new(k);
    for (size_t i = 0; i < k; i++) ARR(r)->d[i] = x;
    return r;
}

static V fwp_p_array_generate(V n, V f) {
    size_t k = fwp_count_arg(n);
    V r = fwp_arr_new(k);
    for (size_t i = 0; i < k; i++) ARR(r)->d[i] = fwp_apply1(f, (V)(int64_t)i);
    return r;
}

static V fwp_p_array_map(V f, V a) {
    V r = fwp_arr_new(ARR(a)->len);
    for (uint64_t i = 0; i < ARR(a)->len; i++) ARR(r)->d[i] = fwp_apply1(f, ARR(a)->d[i]);
    return r;
}

static V fwp_p_array_fold(V f, V z, V a) {
    for (uint64_t i = 0; i < ARR(a)->len; i++) z = fwp_apply2(f, z, ARR(a)->d[i]);
    return z;
}

static V fwp_p_array_slice(V start, V len, V a) {
    size_t n = ARR(a)->len, s = fwp_count_arg(start);
    if (s > n) s = n;
    size_t count = fwp_count_arg(len);
    if (count > n - s) count = n - s;
    size_t e = s + count;
    V r = fwp_arr_new(e - s);
    memcpy(ARR(r)->d, ARR(a)->d + s, (e - s) * sizeof(V));
    return r;
}

static V fwp_p_array_append(V b, V a) {
    V r = fwp_arr_new(ARR(a)->len + ARR(b)->len);
    memcpy(ARR(r)->d, ARR(a)->d, ARR(a)->len * sizeof(V));
    memcpy(ARR(r)->d + ARR(a)->len, ARR(b)->d, ARR(b)->len * sizeof(V));
    return r;
}

static V fwp_p_array_sort(V a, const fwp_desc *elem) {
    V r = fwp_p_array_copy(a, 0);
    fwp_sort_array(ARR(r)->d, ARR(r)->len, elem);
    return r;
}

/* Descriptor-directed immutable boundaries when counted reuse is disabled. */
static V fwp_array_from_words(const V *words, size_t n, const fwp_desc *elem) {
    V r = fwp_array_new_packed(n, elem);
    for (size_t i=0;i<n;i++) fwp_array_store(r,i,words[i],elem);
    return r;
}
static V fwp_p_array_from_list_with_elem(V xs, const fwp_desc *elem) {
    V source=xs, r=fwp_array_new_packed(fwp_list_len(xs),elem);
    for(size_t i=0;xs;i++,xs=OBJ(xs)->f[1]) fwp_array_store(r,i,OBJ(xs)->f[0],elem);
    return r;
}
static V fwp_p_array_to_list_with_elem(V a,const fwp_desc *elem) {
    V r=0;for(size_t i=fwp_array_len(a);i;i--)r=fwp_cons(fwp_array_escape(fwp_array_load(a,i-1,elem),elem),r);
    return r;
}
static V fwp_p_array_get_with_elem(V i,V a,const fwp_desc *elem) {
    if((int64_t)i<0 || (uint64_t)i>=fwp_array_len(a))return FWP_NONE;
    V r=fwp_some(fwp_array_escape(fwp_array_load(a,(size_t)i,elem),elem));return r;
}
static V fwp_array_copy_with_elem(V a,size_t extra,const fwp_desc *elem) {
    size_t n=fwp_array_len(a);if(extra>SIZE_MAX-n)fwp_trap("array too large");
    V r=fwp_array_new_packed(n+extra,elem);
    for(size_t i=0;i<n;i++)fwp_array_store(r,i,fwp_array_load(a,i,elem),elem);
    return r;
}
static V fwp_p_array_set_with_elem(V i,V x,V a,const fwp_desc *elem) {
    if((int64_t)i<0 || (uint64_t)i>=fwp_array_len(a))return FWP_NONE;
    V r=fwp_array_copy_with_elem(a,0,elem);fwp_array_store(r,(size_t)i,x,elem);
    V result=fwp_some(r);return result;
}
static V fwp_p_array_push_with_elem(V x,V a,const fwp_desc *elem) {
    size_t n=fwp_array_len(a);V r=fwp_array_copy_with_elem(a,1,elem);
    fwp_array_store(r,n,x,elem);return r;
}
static V fwp_p_array_make_with_elem(V n,V x,const fwp_desc *elem) {
    size_t k=fwp_count_arg(n);V r=fwp_array_new_packed(k,elem);
    for(size_t i=0;i<k;i++)fwp_array_store(r,i,x,elem);
    return r;
}
static V fwp_p_array_generate_with_elem(V n,V f,const fwp_desc *elem) {
    size_t k=fwp_count_arg(n);V r=fwp_array_new_packed(k,elem);
    for(size_t i=0;i<k;i++)fwp_array_store(r,i,fwp_apply1(f,(V)i),elem);
    return r;
}
static V fwp_p_array_map_with_elem(V f,V a,const fwp_desc *elem,const fwp_desc *input) {
    size_t n=fwp_array_len(a);V r=fwp_array_new_packed(n,elem);
    for(size_t i=0;i<n;i++)fwp_array_store(r,i,fwp_apply1(f,fwp_array_escape(fwp_array_load(a,i,input),input)),elem);
    return r;
}
static V fwp_p_array_fold_with_elem(V f,V z,V a,const fwp_desc *elem) {
    for(size_t i=0;i<fwp_array_len(a);i++)z=fwp_apply2(f,z,fwp_array_escape(fwp_array_load(a,i,elem),elem));
    return z;
}
static V fwp_p_array_slice_with_elem(V start,V len,V a,const fwp_desc *elem) {
    size_t n=fwp_array_len(a),first=fwp_count_arg(start);if(first>n)first=n;
    size_t count=fwp_count_arg(len);if(count>n-first)count=n-first;
#if FWP_PACKED_ARRAYS
    if(fwp_array_should_view(a,count,elem)) {
        V owner=fwp_array_owner(a);const unsigned char *data=fwp_array_data(a)+first*fwp_array_stride(elem);
        fwp_array_view *view=(fwp_array_view *)fwp_alloc_init(sizeof *view);
        view->len=FWP_ARRAY_VIEW_FLAG|count;view->owner=owner;view->data=data;
        fwp_rc_dup(owner);return PTR(view);
    }
#endif
    V r=fwp_array_new_packed(count,elem);
    for(size_t i=0;i<count;i++)fwp_array_store(r,i,fwp_array_load(a,first+i,elem),elem);
    return r;
}
static V fwp_p_array_append_with_elem(V b,V a,const fwp_desc *elem) {
    size_t n=fwp_array_len(a),m=fwp_array_len(b);if(m>SIZE_MAX-n)fwp_trap("array too large");
    V r=fwp_array_new_packed(n+m,elem);
    for(size_t i=0;i<n+m;i++)fwp_array_store(r,i,i<n?fwp_array_load(a,i,elem):fwp_array_load(b,i-n,elem),elem);
    return r;
}
static V fwp_p_array_sort_with_elem(V a,const fwp_desc *elem) {
    V r=fwp_array_copy_with_elem(a,0,elem);size_t n=fwp_array_len(a);
    if(n>1){V *keys=(V *)fwp_mem_alloc((n+1)*sizeof(V));V *tk=(V *)fwp_mem_alloc((n+1)*sizeof(V));V *tv=(V *)fwp_mem_alloc((n+1)*sizeof(V));
        for(size_t i=0;i<n;i++)keys[i]=fwp_array_load(a,i,elem);
        fwp_msort(keys,keys,n,elem,tk,tv);
        for(size_t i=0;i<n;i++)fwp_array_store(r,i,keys[i],elem);

        fwp_mem_free(tv);fwp_mem_free(tk);fwp_mem_free(keys);}
    return r;
}

/* Typed array boundaries: storage owns each reference-bearing element.
 * Duplicate/drop operations come from the monomorphic compiler wrapper. */
static V fwp_array_retain(V value, void (*dup)(V), const fwp_desc *elem) {
    if (elem->kind == K_F128) return fwp_rc_fresh(fwp_array_escape(value, elem));
    if (dup) dup(value);
    return value;
}
/* Inline quad payloads own bits, not the temporary scalar box that supplied
 * them. A consumed callback/decoder result releases that box after copying. */
static void fwp_array_store_owned(V a, size_t i, V value, const fwp_desc *elem) {
    fwp_array_store(a, i, value, elem);
    if (elem->kind == K_F128 && elem->drop) elem->drop(value);
}
/* A partially initialized array has one owner and exactly `filled` initialized
 * elements. Register it across callbacks and allocation/retain failures. */
typedef struct { V value; size_t filled; const fwp_desc *element; } fwp_array_builder;
static void fwp_array_builder_release(void *arg) {
    fwp_array_builder *owner = arg;
    V value = owner->value;
    owner->value = 0;
    if (!value) return;
    if (owner->element->kind != K_F128 && owner->element->drop)
        for (size_t i = 0; i < owner->filled; i++)
            owner->element->drop(fwp_array_load(value, i, owner->element));
    fwp_rc_resource_free_arr(value);
}
static void fwp_array_builder_protect(fwp_array_builder *owner, fwp_cleanup *cleanup) {
#if FWP_UNWIND
    fwp_cleanup_push(cleanup, fwp_array_builder_release, owner);
#else
    (void)owner; (void)cleanup;
#endif
}
static V fwp_array_builder_finish(fwp_array_builder *owner, fwp_cleanup *cleanup) {
#if FWP_UNWIND
    fwp_cleanup_pop(cleanup);
#else
    (void)cleanup;
#endif
    V result = owner->value; owner->value = 0; return result;
}
static V fwp_array_typed_new(size_t n, const fwp_desc *elem) {
    if (n > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap("array too large");
    return fwp_rc_fresh(fwp_array_new_packed(n, elem));
}
/* A proved local I64 array has neither counted elements nor a count slot. */
static V fwp_unique_i64_array_new(V count) {
    size_t n = fwp_count_arg(count);
    if (n > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap("array too large");
    fwp_arr *array = (fwp_arr *)fwp_alloc_unique(sizeof(fwp_arr) + n * sizeof(V));
    array->len = n;
    return PTR(array);
}
static void fwp_unique_array_cleanup(void *arg) {
    V *owner = arg;
    V value = *owner;
    *owner = 0;
    fwp_mem_free((void *)(uintptr_t)value);
}
/* Vector storage owns its array and each boxed lane. These are ordinary C
 * loops: a target compiler may vectorize eligible arithmetic, but ownership
 * does not depend on that decision. */
static V fwp_simd_finish(fwp_array_builder *owner, fwp_cleanup *cleanup) {
    V result = fwp_rc_fresh(fwp_record(1, &owner->value));
    fwp_array_builder_finish(owner, cleanup);
    return result;
}
#define LANES(v) ARR(OBJ(v)->f[0])

static V fwp_p_simd_splat(V x, uint64_t n, const fwp_desc *elem) {
    if (n > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V) ||
        n > (SIZE_MAX - sizeof(fwp_arr)) / fwp_array_stride(elem)) fwp_trap("array too large");
    fwp_array_builder result = {fwp_array_typed_new(n, elem), 0, elem};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    if (elem->kind == K_F64) {
        unsigned char *data = (unsigned char *)ARR(result.value)->d;
        for (size_t i = 0; i < n; i++) memcpy(data + i * sizeof(V), &x, sizeof x);
        result.filled = n;
    } else for (size_t i = 0; i < n; i++) {
        if (elem->kind != K_F128 && elem->dup) elem->dup(x);
        fwp_array_store(result.value, i, x, elem);
        result.filled++;
    }

    return fwp_simd_finish(&result, &cleanup);
}

static V fwp_p_simd_from_array(V a, uint64_t n, void (*drop_array)(V), void (*drop_vector)(V)) {
    if (fwp_array_len(a) != n) return FWP_NONE;
    fwp_rc_dup(a);
    fwp_value_owner owner = {a, drop_array};
    fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);
    V vector = fwp_rc_fresh(fwp_record(1, &a));
    fwp_value_finish(&owner, &cleanup);
    owner.value = vector; owner.drop = drop_vector;
    fwp_value_protect(&owner, &cleanup);
    V result = fwp_rc_fresh(fwp_some(vector));
    fwp_value_finish(&owner, &cleanup);

    return result;
}

static int fwp_num_lt(int k, V a, V b) {
#ifdef FWP_EXACT_FLOAT
    if (k == K_F16 || k == K_BF16 || k == K_F128) return fwp_f128_compare(fwp_float_quad(k, a), fwp_float_quad(k, b)) == -1;
#endif
    if (k == K_F32 || k == K_F64) return fwp_as_f64(k, a) < fwp_as_f64(k, b);
    if (k == K_U128) return fwp_u128(a) < fwp_u128(b);
    if (k == K_I128) return fwp_i128(a) < fwp_i128(b);
    return fwp_as_i128(k, a) < fwp_as_i128(k, b);
}

/* op: OP_ADD/OP_SUB/OP_MUL/OP_DIV, 5 = min, 6 = max; `subj` op `arg` */
static V fwp_p_simd_op(int k, int op, V subj, V arg, const char *name, int w, const fwp_desc *elem) {
    fwp_arr *xs = LANES(subj), *ys = LANES(arg);
    size_t n = fwp_array_len(PTR(xs)) < fwp_array_len(PTR(ys)) ? fwp_array_len(PTR(xs)) : fwp_array_len(PTR(ys));
    int fl = fwp_float_kind(k);
    fwp_array_builder result = {fwp_array_typed_new(n, elem), 0, elem};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    if (k == K_F64 && op <= OP_DIV) {
        /* A view and a flat F64 array both expose contiguous eight-byte lanes.
         * Resolve their addresses once. Byte copies respect C effective types;
         * casting the V storage to double pointers would not. The fresh result
         * is not a view and its lanes need no cleanup before wrapper allocation. */
        const unsigned char *left = fwp_array_data(PTR(xs)), *right = fwp_array_data(PTR(ys));
        unsigned char *data = (unsigned char *)ARR(result.value)->d;
        for (size_t i = 0; i < n; i++) {
            double x, y, z;
            memcpy(&x, left + i * sizeof x, sizeof x);
            memcpy(&y, right + i * sizeof y, sizeof y);
            switch (op) {
            case OP_ADD: z = x + y; break;
            case OP_SUB: z = x - y; break;
            case OP_MUL: z = x * y; break;
            default: z = x / y;
            }
            memcpy(data + i * sizeof z, &z, sizeof z);
        }
        result.filled = n;
    } else for (size_t i = 0; i < n; i++) {
        V x = fwp_array_load(PTR(xs), i, elem), y = fwp_array_load(PTR(ys), i, elem), value;
        if (op == 5 || op == 6) {
            value = op == 5 ? (fwp_num_lt(k, y, x) ? y : x) : (fwp_num_lt(k, x, y) ? y : x);
            // Quad arrays store bits directly; other boxed lanes need an alias.
            if (elem->kind != K_F128 && elem->dup) elem->dup(value);
            fwp_array_store(result.value, i, value, elem);
        } else {
            value = !fl && op != OP_DIV ? fwp_wrapping(k, op, x, y) : fwp_arith(k, op, x, y, name, w);
            if (elem->drop) value = fwp_rc_fresh(value);
            fwp_array_store_owned(result.value, i, value, elem);
        }
        result.filled++;
    }

    return fwp_simd_finish(&result, &cleanup);
}

/* Two proved equal-length splats need only their scalar lane values. Their
 * source expressions have already run in order, even when the lane count is 0. */
static V fwp_p_simd_splat_dot_f64(V count, V subj, V arg) {
    uint64_t n = count;
    if (!n) return fwp_from_f64(0.0);
    double product = fwp_f64(subj) * fwp_f64(arg), sum = product;
    for (uint64_t i = 1; i < n; i++) sum += product;
    return fwp_from_f64(sum);
}

/* Immediate F64 multiply then sum: each product rounds before its addition,
 * and additions retain left-to-right order. No product array is needed. */
static V fwp_p_simd_dot_f64(V subj, V arg) {
    V xs = OBJ(subj)->f[0], ys = OBJ(arg)->f[0];
    size_t nx = fwp_array_len(xs), ny = fwp_array_len(ys), n = nx < ny ? nx : ny;
    const unsigned char *left = fwp_array_data(xs), *right = fwp_array_data(ys);
    double sum = 0.0;
    for (size_t i = 0; i < n; i++) {
        double x, y;
        memcpy(&x, left + i * sizeof x, sizeof x);
        memcpy(&y, right + i * sizeof y, sizeof y);
        double product = x * y;
        if (i == 0) sum = product;
        else sum += product;
    }

    return fwp_from_f64(sum);
}

static V fwp_p_simd_sum(int k, V v, const char *name, int w, const fwp_desc *elem) {
    fwp_arr *xs = LANES(v);
    if (fwp_array_len(PTR(xs)) == 0) {
        V zero = fwp_from_i128(k, 0, name, w);
        return elem->drop ? fwp_rc_fresh(zero) : zero;
    }
    if (k == K_F64) {
        const unsigned char *data = fwp_array_data(PTR(xs));
        size_t n = fwp_array_len(PTR(xs));
        double sum; memcpy(&sum, data, sizeof sum);
        /* Start at the first lane and preserve order: no reassociation or
         * synthetic +0 which would change a singleton negative zero. */
        for (size_t i = 1; i < n; i++) {
            double lane; memcpy(&lane, data + i * sizeof lane, sizeof lane);
            sum += lane;
        }
        return fwp_from_f64(sum);
    }
#ifdef FWP_EXACT_FLOAT
    if (k == K_F128) {
        float128_t sum = fwp_f128(fwp_array_load(PTR(xs), 0, elem));
        for (size_t i = 1; i < fwp_array_len(PTR(xs)); i++)
            sum = f128_add(sum, fwp_f128(fwp_array_load(PTR(xs), i, elem)));
        V result = fwp_rc_fresh(fwp_box_f128(sum));
        return result;
    }
#endif
    int fl = fwp_float_kind(k);
    fwp_value_owner acc = {fwp_array_retain(fwp_array_load(PTR(xs), 0, elem), elem->dup, elem), elem->drop};
    fwp_cleanup cleanup; fwp_value_protect(&acc, &cleanup);
    for (size_t i = 1; i < fwp_array_len(PTR(xs)); i++) {
        V lane = fwp_array_load(PTR(xs), i, elem);
        V next = fl ? fwp_arith(k, OP_ADD, acc.value, lane, name, w) : fwp_wrapping(k, OP_ADD, acc.value, lane);
        if (elem->drop) next = fwp_rc_fresh(next);
        if (elem->drop) elem->drop(acc.value);
        acc.value = next;
    }

    return fwp_value_finish(&acc, &cleanup);
}

static V fwp_array_typed_copy(V a, size_t extra, void (*dup)(V), const fwp_desc *elem) {
    size_t n = fwp_array_len(a);
    if (extra > SIZE_MAX - n) fwp_trap("array too large");
    fwp_array_builder result = {fwp_array_typed_new(n + extra, elem), 0, elem};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    for (size_t i = 0; i < n; i++) {
        V value = fwp_array_load(a, i, elem);
        if (dup && elem->kind != K_F128) dup(value);
        fwp_array_store(result.value, i, value, elem);
        result.filled++;
    }

    return fwp_array_builder_finish(&result, &cleanup);
}
static V fwp_p_array_from_list_typed(V xs, void (*dup)(V),
                                    void (*drop_list)(V), const fwp_desc *elem) {
    fwp_value_owner input = {xs, drop_list};
    fwp_cleanup input_cleanup; fwp_value_protect(&input, &input_cleanup);
    fwp_array_builder result = {fwp_array_typed_new(fwp_list_len(xs), elem), 0, elem};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    int move_prefix = 1;
    for (size_t i = 0; xs; i++) {
        V node = xs, value = OBJ(node)->f[0], tail = OBJ(node)->f[1];
        if (move_prefix && fwp_rc_last(node)) {
            /* Transfer both children before freeing only this list node.
             * Wide scalars are copied into inline array slots and released. */
            input.value = tail;
            fwp_array_store_owned(result.value, i, value, elem);
            result.filled++;
            fwp_rc_free_obj(node);
        } else {
            /* A shared node also shares access to its descendants, even when
             * their own counts are one. Keep this whole tail owned. */
            move_prefix = 0;
            if (dup && elem->kind != K_F128) dup(value);
            fwp_array_store(result.value, i, value, elem);
            result.filled++;
        }
        xs = tail;
    }
    V array = fwp_array_builder_finish(&result, &cleanup);
    drop_list(fwp_value_finish(&input, &input_cleanup));
    return array;
}
/* Compiler-only inline integer range immediately consumed as an array. Wide
 * arithmetic computes the distance without signed overflow or WASI truncation.
 * No callbacks or boxed elements can interrupt initialization after allocation. */
static V fwp_p_array_range(V lo, V hi, const fwp_desc *elem) {
    i128 a = fwp_as_i128(elem->kind, lo), b = fwp_as_i128(elem->kind, hi);
    u128 count = b > a ? (u128)(b - a) : 0;
    if (count > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap("array too large");
    size_t n = (size_t)count;
    V result = fwp_array_typed_new(n, elem);
    for (size_t i = 0; i < n; i++)
        fwp_array_store(result, i, (V)(a + (i128)i), elem);
    return result;
}
/* Compiler-only map followed immediately by numeric array construction.
 * Keep the same borrowed source snapshot and callback order as map, but pack
 * inline results directly from scratch instead of building temporary list nodes.
 * Complete every callback before allocating the array, just as the source does. */
static V fwp_p_array_map_list(V f, V xs, const fwp_desc *elem) {
    size_t n;
    V *items = fwp_map_items(xs, &n);
    fwp_cleanup cleanup; fwp_scratch_protect(&items, &cleanup);
    for (size_t i = 0; i < n; i++) items[i] = fwp_apply_borrowed(f, 1, &items[i]);
    V result = fwp_array_typed_new(n, elem);
    for (size_t i = 0; i < n; i++) fwp_array_store(result, i, items[i], elem);
    fwp_scratch_finish(&items, &cleanup);

    return result;
}
static V fwp_p_array_to_list_typed(V a, void (*dup)(V), const fwp_desc *elem, void (*drop_list)(V)) {
    fwp_value_owner result = {0, drop_list}; fwp_cleanup cleanup;
    fwp_value_protect(&result, &cleanup);
    for (size_t i = fwp_array_len(a); i; i--) {
        V value = fwp_array_load(a, i - 1, elem);
        value = fwp_array_retain(value, dup, elem);
        fwp_value_owner pending = {value, elem->drop}; fwp_cleanup pending_cleanup;
        fwp_value_protect(&pending, &pending_cleanup);
        result.value = fwp_rc_fresh(fwp_cons(value, result.value));
        (void)fwp_value_finish(&pending, &pending_cleanup);
    }

    return fwp_value_finish(&result, &cleanup);
}
static V fwp_p_array_get_typed(V i, V a, void (*dup)(V), const fwp_desc *elem) {
    if ((int64_t)i < 0 || (uint64_t)(int64_t)i >= fwp_array_len(a)) return FWP_NONE;
    V value = fwp_array_load(a, (int64_t)i, elem);
    value = fwp_array_retain(value, dup, elem);
    fwp_value_owner pending = {value, elem->drop}; fwp_cleanup cleanup;
    fwp_value_protect(&pending, &cleanup);
    V result = fwp_rc_fresh(fwp_some(value));
    (void)fwp_value_finish(&pending, &cleanup);

    return result;
}
static V fwp_p_array_set_typed(V i, V x, V a, void (*dup)(V),
                              void (*drop_element)(V), void (*drop_array)(V), const fwp_desc *elem) {
    fwp_value_owner owner = {a, drop_array}; fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    if ((int64_t)i < 0 || (uint64_t)(int64_t)i >= fwp_array_len(a)) {
        drop_array(fwp_value_finish(&owner, &cleanup));

        return FWP_NONE;
    }
    int unique = fwp_array_is_view(a) ? 0 : fwp_rc_unique_mut(a);
    V result = a;
    if (unique != 1) {
        /* Copying preserves each existing owner's children. */
        result = fwp_array_typed_copy(a, 0, dup, elem);
        owner.value = result;
        drop_array(a);
    }
    if (dup && elem->kind != K_F128) dup(x);
    V previous = fwp_array_load(result, (int64_t)i, elem);
    fwp_array_store(result, (int64_t)i, x, elem);
    if (drop_element && elem->kind != K_F128) drop_element(previous);
    result = fwp_rc_fresh(fwp_some(result));
    (void)fwp_value_finish(&owner, &cleanup);

    return result;
}
static V fwp_p_array_push_typed(V x, V a, void (*dup)(V),
                               void (*drop_element)(V), void (*drop_array)(V), const fwp_desc *elem) {
    (void)drop_element;
    fwp_value_owner owner = {a, drop_array}; fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    size_t n = fwp_array_len(a);
    if (n >= (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap("array too large");
    if (fwp_array_stride(elem) > sizeof(V) && n >= (SIZE_MAX - sizeof(fwp_arr)) / fwp_array_stride(elem)) fwp_trap("array too large");
    int unique = fwp_array_is_view(a) ? 0 : fwp_rc_unique_mut(a);
    if (unique == 1 && fwp_array_capacity(a, elem) >= sizeof(fwp_arr) + (n + 1) * fwp_array_stride(elem)) {
        if (dup && elem->kind != K_F128) dup(x);
        fwp_array_store(a, n, x, elem);
        fwp_array_set_len(a, n + 1);
        return fwp_value_finish(&owner, &cleanup);
    }
    size_t capacity = n + 1;
    if (unique && n <= (SIZE_MAX - sizeof(fwp_arr)) / fwp_array_stride(elem) / 2)
        capacity = n < 4 ? 4 : 2 * n;
    V result = fwp_array_typed_copy(a, capacity - n, unique ? NULL : dup, elem);
    if (unique) fwp_array_set_len(a, 0);
    owner.value = result;
    drop_array(a);
    fwp_array_set_len(result, n + 1);
    if (dup && elem->kind != K_F128) dup(x);
    fwp_array_store(result, n, x, elem);

    return fwp_value_finish(&owner, &cleanup);
}
static V fwp_p_array_make_typed(V n, V x, void (*dup)(V), const fwp_desc *elem) {
    size_t count = fwp_count_arg(n);
    fwp_array_builder result = {fwp_array_typed_new(count, elem), 0, elem};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    for (size_t i = 0; i < count; i++) {
        if (dup && elem->kind != K_F128) dup(x);
        fwp_array_store(result.value, i, x, elem);
        result.filled++;
    }

    return fwp_array_builder_finish(&result, &cleanup);
}
static V fwp_p_array_generate_typed(V n, V f, const fwp_desc *elem) {
    size_t count = fwp_count_arg(n);
    fwp_array_builder result = {fwp_array_typed_new(count, elem), 0, elem};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    for (size_t i = 0; i < count; i++) {
        V index = (V)i;
        fwp_array_store_owned(result.value, i, fwp_apply_borrowed(f, 1, &index), elem);
        result.filled++;
    }

    return fwp_array_builder_finish(&result, &cleanup);
}
static V fwp_p_array_map_typed(V f, V a, const fwp_desc *elem, const fwp_desc *input) {
    size_t count = fwp_array_len(a);
    fwp_array_builder result = {fwp_array_typed_new(count, elem), 0, elem};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    for (size_t i = 0; i < count; i++) {
        V value = fwp_array_load(a, i, input);
        size_t consumed = input->kind == K_F128 ? 1 : 0;
        if (consumed) value = fwp_array_retain(value, NULL, input);
        fwp_array_store_owned(result.value, i, fwp_apply_borrowed_prefix(f, 1, &value, consumed), elem);
        result.filled++;
    }


    return fwp_array_builder_finish(&result, &cleanup);
}
static V fwp_p_array_fold_typed(V f, V z, V a, const fwp_desc *elem, void (*drop_accumulator)(V)) {
    fwp_value_owner owner = {z, drop_accumulator}; fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    for (size_t i = 0; i < fwp_array_len(a); i++) {
        V args[] = {owner.value, fwp_array_load(a, i, elem)};
        if (elem->kind == K_F128) args[1] = fwp_array_retain(args[1], NULL, elem);
        owner.value = 0;
        owner.value = fwp_apply_borrowed_prefix(f, 2, args, elem->kind == K_F128 ? 2 : 1);
    }


    return fwp_value_finish(&owner, &cleanup);
}
static V fwp_p_array_slice_typed(V start, V len, V a, void (*dup)(V), const fwp_desc *elem) {
    size_t n = fwp_array_len(a), first = fwp_count_arg(start);
    if (first > n) first = n;
    size_t count = fwp_count_arg(len);
    if (count > n - first) count = n - first;
#if FWP_PACKED_ARRAYS
    if (fwp_array_should_view(a, count, elem)) {
        V owner = fwp_array_owner(a);
        const unsigned char *data = fwp_array_data(a) + first * fwp_array_stride(elem);
        fwp_array_view *view = (fwp_array_view *)fwp_alloc_init(sizeof *view);
        view->len = FWP_ARRAY_VIEW_FLAG | count; view->owner = owner; view->data = data;
        fwp_value_owner header = {fwp_rc_fresh(PTR(view)), fwp_rc_resource_free_arr};
        fwp_cleanup cleanup; fwp_value_protect(&header, &cleanup);
        fwp_rc_dup(owner);
        V result = fwp_value_finish(&header, &cleanup);
        return result;
    }
#endif
    fwp_array_builder result = {fwp_array_typed_new(count, elem), 0, elem};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    for (size_t i = 0; i < count; i++) {
        V value = fwp_array_load(a, first + i, elem);
        if (dup && elem->kind != K_F128) dup(value);
        fwp_array_store(result.value, i, value, elem);
        result.filled++;
    }

    return fwp_array_builder_finish(&result, &cleanup);
}
static V fwp_p_array_append_typed(V b, V a, void (*dup)(V), const fwp_desc *elem) {
    size_t n = fwp_array_len(a), m = fwp_array_len(b);
    if (m > SIZE_MAX - n) fwp_trap("array too large");
    fwp_array_builder result = {fwp_array_typed_new(n + m, elem), 0, elem};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    for (size_t i = 0; i < n + m; i++) {
        V value = i < n ? fwp_array_load(a, i, elem) : fwp_array_load(b, i - n, elem);
        if (dup && elem->kind != K_F128) dup(value);
        fwp_array_store(result.value, i, value, elem);
        result.filled++;
    }


    return fwp_array_builder_finish(&result, &cleanup);
}
static V fwp_p_array_sort_typed(V a, void (*dup)(V),
                               void (*drop_array)(V), const fwp_desc *elem) {
    fwp_value_owner input = {a, drop_array};
    fwp_cleanup input_cleanup; fwp_value_protect(&input, &input_cleanup);
    size_t n = fwp_array_len(a);
    if (n < 2) return fwp_value_finish(&input, &input_cleanup);
    int unique = fwp_array_is_view(a) ? 0 : fwp_rc_unique_mut(a);
    V result = unique == 1 ? a : fwp_array_typed_copy(a, 0, unique ? NULL : dup, elem);
    /* Verification can require copying unique storage. Transfer its children
     * without retaining them, keeping the old bytes alive until sorting ends. */
    if (unique && unique != 1) fwp_array_set_len(a, 0);
    fwp_value_owner owner = {result, drop_array};
    fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);
    if (result == a) input.value = 0;
    V *keys = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    fwp_cleanup key_cleanup; fwp_scratch_protect(&keys, &key_cleanup);
    V *tk = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    fwp_cleanup tk_cleanup; fwp_scratch_protect(&tk, &tk_cleanup);
    for (size_t i = 0; i < n; i++) keys[i] = fwp_array_load(a, i, elem);
    fwp_msort(keys, keys, n, elem, tk, tk);
    if (result == a && fwp_array_stride(elem) == 16) {
        /* Wide keys borrow original array slots. Apply their permutation
         * in cycles so writing one slot cannot overwrite a later key. */
        unsigned char saved[16];
        unsigned char *data = (unsigned char *)(uintptr_t)a + sizeof(fwp_arr);
        for (size_t i = 0; i < n; i++) {
            V original = PTR(data + i * 16);
            if (keys[i] == original) continue;
            memcpy(saved, data + i * 16, sizeof saved);
            size_t position = i;
            while (keys[position] != original) {
                size_t from = (size_t)(keys[position] - PTR(data)) / 16;
                memmove(data + position * 16, data + from * 16, sizeof saved);
                keys[position] = PTR(data + position * 16);
                position = from;
            }
            memcpy(data + position * 16, saved, sizeof saved);
            keys[position] = PTR(data + position * 16);
        }
    } else {
        for (size_t i = 0; i < n; i++) fwp_array_store(result, i, keys[i], elem);
    }


    fwp_scratch_finish(&tk, &tk_cleanup);
    fwp_scratch_finish(&keys, &key_cleanup);

    V sorted = fwp_value_finish(&owner, &cleanup);
    drop_array(fwp_value_finish(&input, &input_cleanup));
    return sorted;
}

/* ------------------------------------------------------------ maps, sets */

static fwp_map fwp_empty_map = {0};
#define FWP_EMPTY_MAP PTR(&fwp_empty_map)


static V fwp_map_alloc(uint64_t len, size_t columns) {
    if (len > (SIZE_MAX - sizeof(fwp_map)) / (columns * sizeof(V))) fwp_trap("map too large");
    fwp_map *m = (fwp_map *)fwp_alloc(sizeof(fwp_map) + columns * len * sizeof(V));
    m->len = len;
    return PTR(m);
}

/* a map from interleaved key/value pairs already in key order */
static V fwp_map_from_sorted(uint64_t len, const V *kv) {
    if (len == 0) return PTR(&fwp_empty_map);
    V m = fwp_map_alloc(len, 2);
    memcpy(MAP(m)->d, kv, 2 * len * sizeof(V));
    return m;
}

/* index of key or insertion point (found flag) */
static uint64_t fwp_map_find(V m, V k, const fwp_desc *kd, int *found, size_t columns) {
    uint64_t lo = 0, hi = MAP(m)->len;
    /* integer keys: compared inline, without the descriptor */
    switch (kd->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64: {
        int64_t x = (int64_t)k;
        const V *d = MAP(m)->d;
        while (lo < hi) {
            uint64_t mid = (lo + hi) / 2;
            int64_t y = (int64_t)d[columns * mid];
            if (y == x) { *found = 1; return mid; }
            if (y < x) lo = mid + 1; else hi = mid;
        }
        *found = 0;
        return lo;
    }
    case K_U8: case K_U16: case K_U32: case K_U64: {
        const V *d = MAP(m)->d;
        while (lo < hi) {
            uint64_t mid = (lo + hi) / 2;
            V y = d[columns * mid];
            if (y == k) { *found = 1; return mid; }
            if (y < k) lo = mid + 1; else hi = mid;
        }
        *found = 0;
        return lo;
    }
    default: break;
    }
    while (lo < hi) {
        uint64_t mid = (lo + hi) / 2;
        int c = fwp_cmp(MAP(m)->d[columns * mid], k, kd);
        if (c == 0) { *found = 1; return mid; }
        if (c < 0) lo = mid + 1; else hi = mid;
    }
    *found = 0;
    return lo;
}

static V fwp_p_map_insert(V k, V v, V m, const fwp_desc *kd, size_t columns) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found, columns);
    uint64_t n = MAP(m)->len;
    V r = fwp_map_alloc(found ? n : n + 1, columns);
    if (found) {
        memcpy(MAP(r)->d, MAP(m)->d, columns * n * sizeof(V));
        if (columns == 2) MAP(r)->d[columns * i + 1] = v;
    } else {
        memcpy(MAP(r)->d, MAP(m)->d, columns * i * sizeof(V));
        MAP(r)->d[columns * i] = k;
        if (columns == 2) MAP(r)->d[columns * i + 1] = v;
        memcpy(MAP(r)->d + columns * (i + 1), MAP(m)->d + columns * i, columns * (n - i) * sizeof(V));
    }
    return r;
}

static V fwp_p_map_get(V k, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found, 2);
    return found ? fwp_some(MAP(m)->d[2 * i + 1]) : FWP_NONE;
}

static V fwp_p_map_remove(V k, V m, const fwp_desc *kd, size_t columns) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found, columns);
    if (!found) return m;
    uint64_t n = MAP(m)->len;
    V r = fwp_map_alloc(n - 1, columns);
    memcpy(MAP(r)->d, MAP(m)->d, columns * i * sizeof(V));
    memcpy(MAP(r)->d + columns * i, MAP(m)->d + columns * (i + 1), columns * (n - i - 1) * sizeof(V));
    return r;
}

static V fwp_p_map_contains(V k, V m, const fwp_desc *kd, size_t columns) {
    int found;
    fwp_map_find(m, k, kd, &found, columns);
    return found ? FWP_TRUE : FWP_FALSE;
}

static V fwp_p_map_size(V m) { return (V)(int64_t)MAP(m)->len; }

static V fwp_p_map_column(V m, int col, size_t columns) {
    uint64_t n = MAP(m)->len;
    V *a = (V *)fwp_alloc((n + 1) * sizeof(V));
    for (uint64_t i = 0; i < n; i++) a[i] = MAP(m)->d[columns * i + col];
    return fwp_list_from(a, n);
}

static V fwp_p_map_to_list(V m) {
    uint64_t n = MAP(m)->len;
    V *a = (V *)fwp_alloc((n + 1) * sizeof(V));
    for (uint64_t i = 0; i < n; i++) a[i] = fwp_tuple2(MAP(m)->d[2 * i], MAP(m)->d[2 * i + 1]);
    return fwp_list_from(a, n);
}

/* A map of n keys and values in list order, sorted once (stable), where a
 * repeated key keeps its first occurrence and the last value, as inserting
 * them one by one would: O(n log n) instead of a copy per insert. */
static V fwp_map_build(V *keys, V *vals, size_t n, const fwp_desc *kd, size_t columns) {
    if (n == 0) return FWP_EMPTY_MAP;
    V *tk = (V *)fwp_alloc((n + 1) * sizeof(V));
    V *tv = (V *)fwp_alloc((n + 1) * sizeof(V));
    fwp_msort(keys, vals, n, kd, tk, tv);
    size_t len = 0;
    for (size_t i = 0; i < n; len++) {
        size_t j = i + 1;
        while (j < n && fwp_cmp(keys[j], keys[i], kd) == 0) j++;
        tk[len] = keys[i];
        tv[len] = vals[j - 1];
        i = j;
    }
    V m = fwp_map_alloc(len, columns);
    for (size_t i = 0; i < len; i++) {
        MAP(m)->d[columns * i] = tk[i];
        if (columns == 2) MAP(m)->d[columns * i + 1] = tv[i];
    }
    return m;
}

static V fwp_p_map_from_list(V xs, const fwp_desc *kd) {
    size_t n = fwp_list_len(xs);
    V *keys = (V *)fwp_alloc((n + 1) * sizeof(V));
    V *vals = (V *)fwp_alloc((n + 1) * sizeof(V));
    for (size_t i = 0; i < n; i++, xs = OBJ(xs)->f[1]) {
        V p = OBJ(xs)->f[0];
        keys[i] = OBJ(p)->f[0];
        vals[i] = OBJ(p)->f[1];
    }
    return fwp_map_build(keys, vals, n, kd, 2);
}

static V fwp_p_map_update(V k, V f, V d, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found, 2);
    V cur = found ? MAP(m)->d[2 * i + 1] : d;
    return fwp_p_map_insert(k, fwp_apply1(f, cur), m, kd, 2);
}

static V fwp_p_map_map_values(V f, V m) {
    uint64_t n = MAP(m)->len;
    V r = fwp_map_alloc(n, 2);
    for (uint64_t i = 0; i < n; i++) {
        MAP(r)->d[2 * i] = MAP(m)->d[2 * i];
        MAP(r)->d[2 * i + 1] = fwp_apply1(f, MAP(m)->d[2 * i + 1]);
    }
    return r;
}

static V fwp_p_set_insert(V k, V s, const fwp_desc *kd) { return fwp_p_map_insert(k, 0, s, kd, 1); }

/* `map.insert`, `map.remove`, `map.update`, `set.insert` and `set.remove`
 * given the only reference to the map (src/rc.rs): written in place when
 * it is unique, a map inserted into while unique growing by doubling;
 * else copied, and the reference given up. Results are counted. */
static V fwp_map_given_up(V m, V r) {
    fwp_rc_drop(m);
    return fwp_rc_fresh(r);
}

static V fwp_p_map_insert_own(V k, V v, V m, const fwp_desc *kd, size_t columns) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found, columns);
    uint64_t n = MAP(m)->len;
    int u = fwp_rc_unique_mut(m);
    if (u == 1 && found) {
        if (columns == 2) MAP(m)->d[columns * i + 1] = v;
        return m;
    }
    if (u == 1 && fwp_rc_capacity(m) >= sizeof(fwp_map) + columns * (n + 1) * sizeof(V)) {
        memmove(MAP(m)->d + columns * (i + 1), MAP(m)->d + columns * i, columns * (n - i) * sizeof(V));
        MAP(m)->d[columns * i] = k;
        if (columns == 2) MAP(m)->d[columns * i + 1] = v;
        MAP(m)->len = n + 1;
        return m;
    }
    if (u != 1 || found) return fwp_map_given_up(m, fwp_p_map_insert(k, v, m, kd, columns));
    V r = fwp_map_alloc(n < 4 ? 4 : 2 * n, columns);
    memcpy(MAP(r)->d, MAP(m)->d, columns * i * sizeof(V));
    MAP(r)->d[columns * i] = k;
    if (columns == 2) MAP(r)->d[columns * i + 1] = v;
    memcpy(MAP(r)->d + columns * (i + 1), MAP(m)->d + columns * i, columns * (n - i) * sizeof(V));
    MAP(r)->len = n + 1;
    return fwp_map_given_up(m, r);
}

static V fwp_p_map_remove_own(V k, V m, const fwp_desc *kd, size_t columns) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found, columns);
    if (!found) return m;
    uint64_t n = MAP(m)->len;
    int u = fwp_rc_unique_mut(m);
    if (u == 1) {
        memmove(MAP(m)->d + columns * i, MAP(m)->d + columns * (i + 1), columns * (n - i - 1) * sizeof(V));
        /* the freed pair keeps nothing alive */
        memset(MAP(m)->d + columns * (n - 1), 0, columns * sizeof(V));
        MAP(m)->len = n - 1;
        return m;
    }
    return fwp_map_given_up(m, fwp_p_map_remove(k, m, kd, columns));
}

static V fwp_p_map_update_own(V k, V f, V d, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found, 2);
    V cur = found ? MAP(m)->d[2 * i + 1] : d;
    return fwp_p_map_insert_own(k, fwp_apply1(f, cur), m, kd, 2);
}

static V fwp_p_set_insert_own(V k, V s, const fwp_desc *kd) { return fwp_p_map_insert_own(k, 0, s, kd, 1); }

static V fwp_p_set_from_list(V xs, const fwp_desc *kd) {
    size_t n;
    V *keys = fwp_list_items(xs, &n);
    V *vals = (V *)fwp_alloc((n + 1) * sizeof(V));
    return fwp_map_build(keys, vals, n, kd, 1);
}

/* op: 0 union, 1 intersect, 2 diff; `other` is the argument, `this` the
 * subject (data-last). Both are sorted, so they are merged; a key in both
 * is this one's. */
static V fwp_p_set_op(V other, V this_, int op, const fwp_desc *kd) {
    uint64_t a = MAP(this_)->len, b = MAP(other)->len, i = 0, j = 0, n = 0;
    V *out = (V *)fwp_alloc((a + b + 1) * sizeof(V));
    while (i < a || j < b) {
        int c = i == a ? 1 : j == b ? -1 : fwp_cmp(MAP(this_)->d[i], MAP(other)->d[j], kd);
        if (c < 0) {
            if (op != 1) out[n++] = MAP(this_)->d[i];
            i++;
        } else if (c > 0) {
            if (op == 0) out[n++] = MAP(other)->d[j];
            j++;
        } else {
            if (op != 2) out[n++] = MAP(this_)->d[i];
            i++;
            j++;
        }
    }
    if (n == 0) return FWP_EMPTY_MAP;
    V r = fwp_map_alloc(n, 1);
    for (uint64_t k = 0; k < n; k++) {
        MAP(r)->d[k] = out[k];
    }
    return r;
}

/* Typed map/set operations. The first stored key survives replacement.
 * Insert/remove/update consume their map; other inputs borrow. A partial map
 * records each acquired key before acquiring its value, whose slot is zeroed. */
typedef struct {
    void (*dup_key)(V), (*dup_value)(V);
    void (*drop_key)(V), (*drop_value)(V), (*drop_map)(V), (*drop_result)(V);
    size_t columns; /* one key word for sets, key/value pairs for maps */
} fwp_map_ops;
static V fwp_map_typed_new(size_t capacity, size_t columns) {
    if (!capacity) return FWP_EMPTY_MAP;
    if (capacity > (SIZE_MAX - sizeof(fwp_map)) / (columns * sizeof(V))) fwp_trap("map too large");
    return fwp_rc_fresh(fwp_map_alloc(capacity, columns));
}
/* An immediately consumed inline integer range has sorted, distinct keys.
 * Check the full byte count before narrowing to size_t, also on 32-bit WASI.
 * There are no callbacks, allocations or cancellation points after allocation;
 * initializing inline keys cannot fail and requires no partial-value owner. */
static V fwp_p_set_range(V lo, V hi, const fwp_desc *elem) {
    i128 a = fwp_as_i128(elem->kind, lo), b = fwp_as_i128(elem->kind, hi);
    u128 count = b > a ? (u128)(b - a) : 0;
    if (count > (SIZE_MAX - sizeof(fwp_map)) / sizeof(V)) fwp_trap("map too large");
    size_t n = (size_t)count;
    if (!n) return FWP_EMPTY_MAP;
    V result = fwp_map_typed_new(n, 1);
    for (size_t i = 0; i < n; i++) MAP(result)->d[i] = (V)(a + (i128)i);
    return result;
}
static V fwp_map_typed_copy(V m, size_t capacity, int retain, const fwp_map_ops *ops) {
    if (!capacity) return FWP_EMPTY_MAP;
    V result = fwp_map_typed_new(capacity, ops->columns);
    MAP(result)->len = 0;
    fwp_value_owner owner = {result, ops->drop_map};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    size_t n = MAP(m)->len;
    for (size_t i = 0; i < n; i++) {
        V key = MAP(m)->d[ops->columns * i], value = ops->columns == 2 ? MAP(m)->d[ops->columns * i + 1] : 0;
        if (retain && ops->dup_key) ops->dup_key(key);
        MAP(result)->d[ops->columns * i] = key;
        MAP(result)->len = i + 1;
        if (retain && ops->dup_value) ops->dup_value(value);
        if (ops->columns == 2) MAP(result)->d[ops->columns * i + 1] = value;
    }

    return fwp_value_finish(&owner, &cleanup);
}
static V fwp_p_map_insert_typed(V k, V v, V m, const fwp_map_ops *ops, const fwp_desc *kd) {
    fwp_value_owner owner = {m, ops->drop_map};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    int found;
    size_t i = fwp_map_find(m, k, kd, &found, ops->columns), n = MAP(m)->len;
    int unique = fwp_rc_unique_mut(m);
    V result = m;
    size_t capacity = n;
    if (!found) {
        size_t max = (SIZE_MAX - sizeof(fwp_map)) / (ops->columns * sizeof(V));
        if (n >= max) fwp_trap("map too large");
        capacity = n + 1;
        if (unique && n <= max / 2) capacity = n < 4 ? 4 : 2 * n;
    }
    if (unique != 1 || (!found && fwp_rc_capacity(m) < sizeof(fwp_map) + ops->columns * (n + 1) * sizeof(V))) {
        result = fwp_map_typed_copy(m, capacity, !unique, ops);
        if (unique) MAP(m)->len = 0;
        owner.value = result;
        ops->drop_map(m);
    }
    if (ops->dup_value) ops->dup_value(v);
    fwp_value_owner pending = {v, ops->drop_value};
    fwp_cleanup pending_cleanup;
    fwp_value_protect(&pending, &pending_cleanup);
    if (found && ops->columns == 2) {
        V old = MAP(result)->d[ops->columns * i + 1];
        MAP(result)->d[ops->columns * i + 1] = v;
        pending.value = 0;
        if (ops->drop_value) ops->drop_value(old);
    } else if (!found) {
        if (ops->dup_key) ops->dup_key(k);
        memmove(MAP(result)->d + ops->columns * (i + 1), MAP(result)->d + ops->columns * i, ops->columns * (n - i) * sizeof(V));
        MAP(result)->d[ops->columns * i] = k;
        if (ops->columns == 2) MAP(result)->d[ops->columns * i + 1] = v;
        MAP(result)->len = n + 1;
        pending.value = 0;
    }
    fwp_value_finish(&pending, &pending_cleanup);

    return fwp_value_finish(&owner, &cleanup);
}
static V fwp_p_set_insert_typed(V k, V s, const fwp_map_ops *ops, const fwp_desc *kd) {
    return fwp_p_map_insert_typed(k, 0, s, ops, kd);
}
static V fwp_p_map_remove_typed(V k, V m, const fwp_map_ops *ops, const fwp_desc *kd) {
    fwp_value_owner input = {m, ops->drop_map};
    fwp_cleanup input_cleanup;
    fwp_value_protect(&input, &input_cleanup);
    int found;
    size_t i = fwp_map_find(m, k, kd, &found, ops->columns), n = MAP(m)->len;
    if (!found) return fwp_value_finish(&input, &input_cleanup);
    int unique = fwp_rc_unique_mut(m);
    if (unique == 1) {
        V old_key = MAP(m)->d[ops->columns * i], old_value = ops->columns == 2 ? MAP(m)->d[ops->columns * i + 1] : 0;
        memmove(MAP(m)->d + ops->columns * i, MAP(m)->d + ops->columns * (i + 1), ops->columns * (n - i - 1) * sizeof(V));
        MAP(m)->len = n - 1;
        memset(MAP(m)->d + ops->columns * (n - 1), 0, ops->columns * sizeof(V));
        if (ops->drop_key) ops->drop_key(old_key);
        if (ops->drop_value) ops->drop_value(old_value);
        return fwp_value_finish(&input, &input_cleanup);
    }
    V result = fwp_map_typed_new(n - 1, ops->columns);
    if (n > 1) MAP(result)->len = 0;
    fwp_value_owner output = {result, ops->drop_map};
    fwp_cleanup output_cleanup;
    fwp_value_protect(&output, &output_cleanup);
    for (size_t j = 0, out = 0; j < n; j++) {
        if (j == i) continue;
        V key = MAP(m)->d[ops->columns * j], value = ops->columns == 2 ? MAP(m)->d[ops->columns * j + 1] : 0;
        if (!unique && ops->dup_key) ops->dup_key(key);
        MAP(result)->d[ops->columns * out] = key;
        MAP(result)->len = out + 1;
        if (!unique && ops->dup_value) ops->dup_value(value);
        if (ops->columns == 2) MAP(result)->d[ops->columns * out + 1] = value;
        out++;
    }
    if (unique) {
        V old_key = MAP(m)->d[ops->columns * i], old_value = ops->columns == 2 ? MAP(m)->d[ops->columns * i + 1] : 0;
        MAP(m)->len = 0;
        if (ops->drop_key) ops->drop_key(old_key);
        if (ops->drop_value) ops->drop_value(old_value);
    }
    fwp_value_finish(&output, &output_cleanup);
    fwp_value_release(&input);
    fwp_value_finish(&input, &input_cleanup);

    return result;
}
static V fwp_p_set_remove_typed(V k, V s, const fwp_map_ops *ops, const fwp_desc *kd) {
    return fwp_p_map_remove_typed(k, s, ops, kd);
}
static V fwp_p_map_get_typed(V k, V m, const fwp_map_ops *ops, const fwp_desc *kd) {
    int found;
    size_t i = fwp_map_find(m, k, kd, &found, 2);
    if (!found) return FWP_NONE;
    V value = MAP(m)->d[2 * i + 1];
    if (ops->dup_value) ops->dup_value(value);
    fwp_value_owner owner = {value, ops->drop_value};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    V result = fwp_rc_fresh(fwp_some(value));
    fwp_value_finish(&owner, &cleanup);

    return result;
}
static V fwp_map_column_typed(V m, int col, const fwp_map_ops *ops) {
    fwp_value_owner output = {0, ops->drop_result};
    fwp_cleanup output_cleanup;
    fwp_value_protect(&output, &output_cleanup);
    for (size_t i = MAP(m)->len; i; i--) {
        V value = MAP(m)->d[ops->columns * (i - 1) + col];
        void (*dup)(V) = col ? ops->dup_value : ops->dup_key;
        if (dup) dup(value);
        fwp_value_owner pending = {value, col ? ops->drop_value : ops->drop_key};
        fwp_cleanup pending_cleanup;
        fwp_value_protect(&pending, &pending_cleanup);
        output.value = fwp_rc_fresh(fwp_cons(value, output.value));
        fwp_value_finish(&pending, &pending_cleanup);
    }

    return fwp_value_finish(&output, &output_cleanup);
}
static V fwp_p_map_keys_typed(V m, const fwp_map_ops *ops) { return fwp_map_column_typed(m, 0, ops); }
static V fwp_p_set_to_list_typed(V m, const fwp_map_ops *ops) { return fwp_map_column_typed(m, 0, ops); }
static V fwp_p_map_values_typed(V m, const fwp_map_ops *ops) { return fwp_map_column_typed(m, 1, ops); }
static V fwp_p_map_to_list_typed(V m, const fwp_map_ops *ops) {
    fwp_value_owner output = {0, ops->drop_result};
    fwp_cleanup output_cleanup;
    fwp_value_protect(&output, &output_cleanup);
    for (size_t i = MAP(m)->len; i; i--) {
        V key = MAP(m)->d[2 * (i - 1)], value = MAP(m)->d[2 * (i - 1) + 1];
        if (ops->dup_key) ops->dup_key(key);
        fwp_value_owner pending_key = {key, ops->drop_key};
        fwp_cleanup key_cleanup;
        fwp_value_protect(&pending_key, &key_cleanup);
        if (ops->dup_value) ops->dup_value(value);
        fwp_value_owner pending_value = {value, ops->drop_value};
        fwp_cleanup value_cleanup;
        fwp_value_protect(&pending_value, &value_cleanup);
        V pair = fwp_rc_fresh(fwp_tuple2(key, value));
        /* Field owners remain separate until the pair enters the result list. */
        fwp_value_owner pending_pair = {pair, fwp_rc_free_obj};
        fwp_cleanup pair_cleanup;
        fwp_value_protect(&pending_pair, &pair_cleanup);
        output.value = fwp_rc_fresh(fwp_cons(pair, output.value));
        fwp_value_finish(&pending_pair, &pair_cleanup);
        fwp_value_finish(&pending_value, &value_cleanup);
        fwp_value_finish(&pending_key, &key_cleanup);
    }

    return fwp_value_finish(&output, &output_cleanup);
}
/* keys/vals are caller-owned scratch containing borrowed child words.
 * A set passes NULL values: sorting aliases key/value lanes and scratch, then
 * materialization stores only keys in the final set. */
static V fwp_map_build_typed(V *keys, V *vals, size_t n, const fwp_map_ops *ops, const fwp_desc *kd) {
    if (!n) return FWP_EMPTY_MAP;
    /* Related lanes share one owner and no allocator-sized gap. */
    size_t lanes = vals ? 2 : 1;
    if (n > SIZE_MAX / (lanes * sizeof(V))) fwp_trap("map too large");
    V *tk = (V *)fwp_mem_alloc(lanes * n * sizeof(V));
    fwp_cleanup tk_cleanup;
    fwp_scratch_protect(&tk, &tk_cleanup);
    V *tv = vals ? tk + n : NULL;
    fwp_msort(keys, vals ? vals : keys, n, kd, tk, tv ? tv : tk);
    /* Sorting is complete. Compact the borrowed words into their input lanes;
     * len never exceeds i, so no unread key/value is overwritten. Callers keep
     * the source owners alive and discard these scratch lanes after return. */
    fwp_scratch_finish(&tk, &tk_cleanup);
    size_t len = 0;
    for (size_t i = 0; i < n; len++) {
        size_t j = i + 1;
        while (j < n && fwp_cmp(keys[j], keys[i], kd) == 0) j++;
        keys[len] = keys[i];
        if (vals) vals[len] = vals[j - 1];
        i = j;
    }
    V result = fwp_map_typed_new(len, ops->columns);
    MAP(result)->len = 0;
    fwp_value_owner owner = {result, ops->drop_map};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    for (size_t i = 0; i < len; i++) {
        if (ops->dup_key) ops->dup_key(keys[i]);
        MAP(result)->d[ops->columns * i] = keys[i];
        MAP(result)->len = i + 1;
        V value = vals ? vals[i] : 0;
        if (ops->dup_value) ops->dup_value(value);
        if (ops->columns == 2) MAP(result)->d[ops->columns * i + 1] = value;
    }
    fwp_value_finish(&owner, &cleanup);

    return result;
}
static V fwp_p_map_from_list_typed(V xs, const fwp_map_ops *ops, const fwp_desc *kd) {
    V source = xs;
    size_t n = fwp_list_len(xs);
    if (!n) return FWP_EMPTY_MAP;
    if (n > SIZE_MAX / (2 * sizeof(V))) fwp_trap("map too large");
    V *keys = (V *)fwp_mem_alloc(2 * n * sizeof(V));
    fwp_cleanup keys_cleanup;
    fwp_scratch_protect(&keys, &keys_cleanup);
    V *vals = keys + n;
    for (size_t i = 0; xs; i++, xs = OBJ(xs)->f[1]) {
        V pair = OBJ(xs)->f[0]; keys[i] = OBJ(pair)->f[0]; vals[i] = OBJ(pair)->f[1];
    }
    V result = fwp_map_build_typed(keys, vals, n, ops, kd);
    fwp_scratch_finish(&keys, &keys_cleanup);

    return result;
}
static V fwp_p_set_from_list_typed(V xs, const fwp_map_ops *ops, const fwp_desc *kd) {
    if (!xs) return FWP_EMPTY_MAP;
    V source = xs;
    size_t n;
    V *keys = fwp_map_items(xs, &n);
    fwp_cleanup keys_cleanup;
    fwp_scratch_protect(&keys, &keys_cleanup);
    V result = fwp_map_build_typed(keys, NULL, n, ops, kd);
    fwp_scratch_finish(&keys, &keys_cleanup);

    return result;
}
static V fwp_p_map_update_typed(V k, V f, V d, V m, const fwp_map_ops *ops, const fwp_desc *kd) {
    fwp_value_owner input = {m, ops->drop_map};
    fwp_cleanup input_cleanup;
    fwp_value_protect(&input, &input_cleanup);
    int found;
    size_t i = fwp_map_find(m, k, kd, &found, 2);
    V current = found ? MAP(m)->d[2 * i + 1] : d;
    V value = fwp_apply_borrowed(f, 1, &current);
    fwp_value_owner pending = {value, ops->drop_value};
    fwp_cleanup pending_cleanup;
    fwp_value_protect(&pending, &pending_cleanup);
    input.value = 0; /* insert consumes this owner even when it fails */
    input.value = fwp_p_map_insert_typed(k, value, m, ops, kd);
    fwp_value_release(&pending);
    fwp_value_finish(&pending, &pending_cleanup);

    return fwp_value_finish(&input, &input_cleanup);
}
static V fwp_p_map_map_values_typed(V f, V m, const fwp_map_ops *ops) {
    size_t n = MAP(m)->len;
    if (!n) return FWP_EMPTY_MAP;
    V result = fwp_map_typed_new(n, ops->columns);
    MAP(result)->len = 0;
    fwp_value_owner owner = {result, ops->drop_map};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    for (size_t i = 0; i < n; i++) {
        V key = MAP(m)->d[2 * i], value = MAP(m)->d[2 * i + 1];
        if (ops->dup_key) ops->dup_key(key);
        MAP(result)->d[2 * i] = key;
        /* The zeroed value slot owns nothing until its callback succeeds. */
        MAP(result)->len = i + 1;
        MAP(result)->d[2 * i + 1] = fwp_apply_borrowed(f, 1, &value);
    }

    return fwp_value_finish(&owner, &cleanup);
}
static V fwp_set_op_typed(V other, V this_, int op, const fwp_map_ops *ops, const fwp_desc *kd) {
    size_t a = MAP(this_)->len, b = MAP(other)->len, i = 0, j = 0, n = 0;
    if (b >= SIZE_MAX / sizeof(V) || a >= SIZE_MAX / sizeof(V) - b) fwp_trap("set too large");
    V *out = (V *)fwp_mem_alloc((a + b + 1) * sizeof(V));
    fwp_cleanup scratch_cleanup;
    fwp_scratch_protect(&out, &scratch_cleanup);
    while (i < a || j < b) {
        int c = i == a ? 1 : j == b ? -1 : fwp_cmp(MAP(this_)->d[i], MAP(other)->d[j], kd);
        if (c < 0) { if (op != 1) out[n++] = MAP(this_)->d[i]; i++; }
        else if (c > 0) { if (op == 0) out[n++] = MAP(other)->d[j]; j++; }
        else { if (op != 2) out[n++] = MAP(this_)->d[i]; i++; j++; }
    }
    V result = fwp_map_typed_new(n, ops->columns);
    if (n) MAP(result)->len = 0;
    fwp_value_owner owner = {result, ops->drop_map};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    for (size_t k = 0; k < n; k++) {
        if (ops->dup_key) ops->dup_key(out[k]);
        MAP(result)->d[k] = out[k];
        MAP(result)->len = k + 1;
    }
    fwp_value_finish(&owner, &cleanup);
    fwp_scratch_finish(&out, &scratch_cleanup);

    return result;
}
static V fwp_p_set_union_typed(V other, V this_, const fwp_map_ops *ops, const fwp_desc *kd) { return fwp_set_op_typed(other, this_, 0, ops, kd); }
static V fwp_p_set_intersect_typed(V other, V this_, const fwp_map_ops *ops, const fwp_desc *kd) { return fwp_set_op_typed(other, this_, 1, ops, kd); }
static V fwp_p_set_diff_typed(V other, V this_, const fwp_map_ops *ops, const fwp_desc *kd) { return fwp_set_op_typed(other, this_, 2, ops, kd); }

/* ------------------------------------------------------------------ bytes */

static V fwp_p_bytes_from_list(V xs) {
    fwp_buf b = {0};
    for (; xs != 0; xs = OBJ(xs)->f[1]) buf_putc(&b, (char)(uint8_t)OBJ(xs)->f[0]);
    return buf_to_str(&b);
}

static V fwp_p_bytes_to_list(V b) {
    size_t n = STR(b)->len;
    V *a = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    for (size_t i = 0; i < n; i++) a[i] = (V)(unsigned char)STR(b)->d[i];
    V result = fwp_list_from(a, n);
    fwp_mem_free(a);
    return result;
}

static V fwp_p_bytes_get(V i, V b) {
    if ((int64_t)i < 0 || (uint64_t)(int64_t)i >= STR(b)->len) return FWP_NONE;
    return fwp_some((V)(unsigned char)STR(b)->d[(int64_t)i]);
}

static V fwp_p_bytes_slice(V start, V len, V b) {
    size_t n = STR(b)->len, s = fwp_count_arg(start);
    if (s > n) s = n;
    size_t count = fwp_count_arg(len);
    if (count > n - s) count = n - s;
    size_t e = s + count;
    return fwp_str_new(STR(b)->d + s, e - s);
}

/* --------------------------------------------------------------------- io */

/* Same decimal bytes and stream as show | print, without an owned string. */
static V fwp_print_integer(V value, int is_signed) {
    char buffer[24];
    int negative = is_signed && (int64_t)value < 0;
    uint64_t magnitude = negative ? (uint64_t)0 - value : value;
    int length = fwp_u64_fmt(buffer + sizeof buffer, magnitude);
    if (negative) buffer[sizeof buffer - ++length] = '-';
    fwrite(buffer + sizeof buffer - length, 1, (size_t)length, fwp_prog_out);
    fputc('\n', fwp_prog_out);
    return FWP_UNIT;
}

static V fwp_p_print(V s) {
    fwrite(STR(s)->d, 1, STR(s)->len, fwp_prog_out);
    fputc('\n', fwp_prog_out);
    return FWP_UNIT;
}

static V fwp_p_write(V s) {
    fwrite(STR(s)->d, 1, STR(s)->len, fwp_prog_out);
    return FWP_UNIT;
}

static V fwp_p_eprint(V s) {
    fflush(stdout);
    fwrite(STR(s)->d, 1, STR(s)->len, stderr);
    fputc('\n', stderr);
    return FWP_UNIT;
}

static V fwp_p_ewrite(V s) {
    fflush(stdout);
    fwrite(STR(s)->d, 1, STR(s)->len, stderr);
    fflush(stderr);
    return FWP_UNIT;
}

static V fwp_read_stdin_all(void) {
    fflush(stdout);
    fwp_buf b = {0};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_buf_release, &b);
    char tmp[65536];
    size_t n;
    while ((n = fread(tmp, 1, sizeof tmp, stdin)) > 0) buf_put(&b, tmp, n);
    V r = fwp_rc_fresh(fwp_str_lossy(b.d ? b.d : "", b.len));
    fwp_cleanup_pop(&cleanup);
    free(b.d);
    return r;
}

static V fwp_p_read_line(void) {
    fflush(stdout);
    fwp_buf b = {0};
    fwp_cleanup buffer_cleanup; fwp_cleanup_push(&buffer_cleanup, fwp_buf_release, &b);
    int c, any = 0;
    while ((c = fgetc(stdin)) != EOF) {
        any = 1;
        if (c == '\n') break;
        buf_putc(&b, (char)c);
    }
    if (!any) { fwp_cleanup_pop(&buffer_cleanup); free(b.d); return FWP_NONE; }
    if (b.len > 0 && b.d[b.len - 1] == '\r' && c == '\n') b.len--;
    V text = fwp_rc_fresh(fwp_str_lossy(b.d ? b.d : "", b.len));
    fwp_cleanup_pop(&buffer_cleanup);
    free(b.d);
    fwp_value_owner owner = {text, fwp_rc_free_obj}; fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    V result = fwp_rc_fresh(fwp_some(text));
    owner.value = 0;
    (void)fwp_value_finish(&owner, &cleanup);
    return result;
}

static V fwp_p_read_lines(void (*drop_list)(V)) {
    fwp_value_owner input = {fwp_read_stdin_all(), fwp_rc_free_obj};
    fwp_cleanup cleanup; fwp_value_protect(&input, &cleanup);
    V result = fwp_lines_of(STR(input.value)->d, STR(input.value)->len, drop_list);

    fwp_rc_free_obj(fwp_value_finish(&input, &cleanup));
    return result;
}

static V fwp_p_args(void (*drop_list)(V)) {
    /* Reuse the range builder's pending-element and completed-spine owner. */
    fwp_range_owner owner = {0, 0, fwp_rc_free_obj, drop_list};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_range_release, &owner);
    for (int i = fwp_argc - 1; i >= 1; i--) {
        owner.element = fwp_rc_fresh(fwp_str_lossy(fwp_argv[i], strlen(fwp_argv[i])));
        owner.list = fwp_rc_fresh(fwp_cons(owner.element, owner.list));
        owner.element = 0;
    }
    V result = owner.list; owner.list = 0;
    fwp_cleanup_pop(&cleanup);
    return result;
}

static V fwp_p_env_get(V name) {
    /* OS names cannot contain NUL; do not accidentally look up a prefix. */
    if (memchr(STR(name)->d, 0, STR(name)->len)) return FWP_NONE;
    V text;
#ifdef _WIN32
    if (!fwp_win_env_text(STR(name)->d, STR(name)->len, &text)) return FWP_NONE;
#else
    const char *value = getenv(STR(name)->d);
    if (!value) return FWP_NONE;
    text = fwp_str_lossy(value, strlen(value));
#endif
    fwp_value_owner owner = {fwp_rc_fresh(text), fwp_rc_free_obj};
    fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);
    V result = fwp_rc_fresh(fwp_some(text));
    owner.value = 0;
    (void)fwp_value_finish(&owner, &cleanup);
    return result;
}

static int64_t fwp_now_ns(void) {
#ifdef _WIN32
    LARGE_INTEGER counter, frequency;
    if (!QueryPerformanceCounter(&counter) || !QueryPerformanceFrequency(&frequency))
        fwp_trap("cannot read monotonic clock");
    i128 ns = (i128)counter.QuadPart * 1000000000 / frequency.QuadPart;
#else
    struct timespec t;
    if (clock_gettime(CLOCK_MONOTONIC, &t) != 0)
        fwp_trap("cannot read monotonic clock");
    i128 ns = (i128)t.tv_sec * 1000000000 + t.tv_nsec;
#endif
    if (ns < INT64_MIN || ns > INT64_MAX) fwp_trap("monotonic time exceeds Duration range");
    return (int64_t)ns;
}

static int64_t fwp_unix_ns(void) {
#ifdef _WIN32
    FILETIME now;
    GetSystemTimePreciseAsFileTime(&now);
    uint64_t ticks = ((uint64_t)now.dwHighDateTime << 32) | now.dwLowDateTime;
    i128 ns = ((i128)ticks - UINT64_C(116444736000000000)) * 100;
#else
    struct timespec now;
    if (clock_gettime(CLOCK_REALTIME, &now) != 0)
        fwp_trap("cannot read system clock");
    i128 ns = (i128)now.tv_sec * 1000000000 + now.tv_nsec;
#endif
    if (ns < INT64_MIN || ns > INT64_MAX) fwp_trap("system time exceeds Duration range");
    return (int64_t)ns;
}

static int64_t fwp_start_time;

static V fwp_duration(int64_t ns) { V f[1] = {(V)ns}; return fwp_record(1, f); }

static V fwp_p_time_monotonic(void) {
    i128 ns = (i128)fwp_now_ns() - fwp_start_time;
    if (ns < INT64_MIN || ns > INT64_MAX) fwp_trap("monotonic time exceeds Duration range");
    return fwp_duration((int64_t)ns);
}

static V fwp_p_time_unix(void) { return fwp_duration(fwp_unix_ns()); }

static V fwp_p_exit(V code) {
#ifdef FWP_TESTS
    fwp_test_abort(2, NULL, (int32_t)code);
#endif
    fflush(stdout);
    exit((int)(code & 255));
}

static uint64_t fwp_rng = 1;

static void fwp_seed_rng(void) {
    const char *s = getenv("FWP_SEED");
    uint64_t seed;
    char *end;
    if (s && *s && (seed = strtoull(s, &end, 10), *end == 0) && s[0] != '-' && s[0] != '+') {
        fwp_rng = seed | 1;
    } else {
        fwp_rng = (uint64_t)fwp_unix_ns() | 1;
    }
}

static uint64_t fwp_next_random(void) {
    uint64_t x = fwp_rng;
    x ^= x >> 12;
    x ^= x << 25;
    x ^= x >> 27;
    fwp_rng = x;
    return x * 0x2545F4914F6CDD1DULL;
}

static V fwp_p_random_u64(void) { return fwp_next_random(); }
static V fwp_p_random_f64(void) {
    return fwp_from_f64((double)(fwp_next_random() >> 11) / (double)(1ULL << 53));
}

/* ---------------------------------------------------------------- effects */

static V fwp_p_attempt(V f, V x) {
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = fwp_state_len;
    h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (setjmp(h.jb) == 0) {
        V r = fwp_apply1(f, x);
        fwp_handlers = h.prev;
        return fwp_data(0, 1, &r);
    }
    fwp_handlers = h.prev;
    fwp_state_restore(h.state_depth);
    V e = h.value;
    return fwp_data(1, 1, &e);
}

/* Both branches carry one typed owned value. Protect it if result boxing traps. */
static V fwp_p_attempt_owned(V f, V x, void (*drop_result)(V), void (*drop_error)(V)) {
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = fwp_state_len;
    h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    V value; uint32_t tag;
    if (setjmp(h.jb) == 0) {
        value = fwp_apply_borrowed(f, 1, &x);
        tag = 0;
    } else {
        fwp_state_restore(h.state_depth);
        value = h.value;
        tag = 1;
    }
    fwp_handlers = h.prev;
    fwp_value_owner owner = {value, tag ? drop_error : drop_result};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    V result = fwp_rc_fresh(fwp_data(tag, 1, &value));

    fwp_value_finish(&owner, &cleanup);
    return result;
}

static V fwp_p_get(void) { return fwp_state_len ? fwp_state[fwp_state_len - 1] : FWP_UNIT; }

/* A run-state activation owns its typed value independently of the scanned
 * buffer. These records live on the task stack; switching tasks saves the head.
 * Legacy untyped activations keep the shared compatibility convention. */
static fwp_state_owner *fwp_state_current_owner(void) {
    fwp_state_owner *owner = fwp_state_owners;
    while (owner && owner->index + 1 != fwp_state_len) owner = owner->prev;
    return owner;
}

static void fwp_state_owner_release(void *arg) {
    fwp_state_owner *owner = arg;
    V value = owner->value;
    owner->value = 0;
    /* Unlink before dropping captures: a destructor can itself recover a trap. */
    fwp_state_owners = owner->prev;
    if (owner->index < fwp_state_len) fwp_state[owner->index] = 0;
    if (owner->drop && value) owner->drop(value);
}

static V fwp_p_get_owned(void (*duplicate)(V)) {
    V value = fwp_p_get();
    if (duplicate) duplicate(value);
    return value;
}

static void fwp_state_install_owned(fwp_state_owner *owner, V value) {
    V old = owner->value;
    /* Install the new owner before old-value destruction can unwind. */
    owner->value = value;
    fwp_state[owner->index] = value;
    if (owner->drop && old) owner->drop(old);
}

static V fwp_p_put_owned(V value, void (*duplicate)(V)) {
    if (!fwp_state_len) return FWP_UNIT;
    fwp_state_owner *owner = fwp_state_current_owner();
    if (owner) {
        if (owner->duplicate) owner->duplicate(value);
        fwp_state_install_owned(owner, value);
    } else {
        /* Only pointer-bearing monomorphic values enter the legacy fallback. */
        if (duplicate) fwp_rc_share(value);
        fwp_state[fwp_state_len - 1] = value;
    }
    return FWP_UNIT;
}

/* Both generic and statically known callbacks transfer their result here. */
static V fwp_state_modify_result(V result, void (*duplicate)(V), void (*drop)(V)) {
    fwp_state_owner *owner = fwp_state_current_owner();
    if (owner) fwp_state_install_owned(owner, result);
    else if (fwp_state_len) {
        if (duplicate) fwp_rc_share(result);
        fwp_state[fwp_state_len - 1] = result;
    } else if (drop && result) drop(result);
    return FWP_UNIT;
}

static V fwp_p_modify_owned(V function, void (*duplicate)(V), void (*drop)(V)) {
    V current = fwp_p_get();
    V result = fwp_apply_borrowed(function, 1, &current);
    V unit = fwp_state_modify_result(result, duplicate, drop);

    return unit;
}

static V fwp_p_run_state_owned(V initial, V function, V argument,
        void (*duplicate)(V), void (*drop_state)(V), void (*drop_result)(V)) {
    size_t depth = fwp_state_len;
    fwp_handler handler;
    handler.prev = fwp_handlers;
    handler.state_depth = depth;
    handler.cleanup = fwp_cleanups;
    fwp_state_owner owner = {fwp_state_owners, depth, 0, duplicate, drop_state};
    fwp_cleanup state_cleanup;
    /* A failed retain leaves the borrowed initial value with its caller. */
    if (duplicate) duplicate(initial);
    owner.value = initial;
    fwp_state_owners = &owner;
    fwp_cleanup_push(&state_cleanup, fwp_state_owner_release, &owner);
    fwp_state_push(initial);
    fwp_handlers = &handler;
    if (setjmp(handler.jb) == 0) {
        V result = fwp_apply_borrowed(function, 1, &argument);
        fwp_handlers = handler.prev;
        fwp_value_owner result_owner = {result, drop_result};
        fwp_cleanup result_cleanup;
        fwp_value_protect(&result_owner, &result_cleanup);
        V state = fwp_state_pop();
        /* Both values remain owned across result-box allocation. */
        V pair = fwp_rc_fresh(fwp_tuple2(result, state));
        fwp_value_finish(&result_owner, &result_cleanup);
        owner.value = 0;
        fwp_state_owners = owner.prev;
        fwp_cleanup_pop(&state_cleanup);



        return pair;
    }
    /* Failure already unwound the typed owner before invalidating its frame. */
    fwp_handlers = handler.prev;
    fwp_state_restore(depth);
    fwp_fail(handler.value, handler.desc);
    return 0;
}


static V fwp_p_put(V s) {
    return fwp_p_put_owned(s, NULL);
}

static V fwp_p_modify(V f) {
    V cur = fwp_p_get();
    V n = fwp_apply1(f, cur);
    return fwp_p_put(n);
}

static V fwp_p_run_state(V s, V f, V x) {
    fwp_state_push(s);
    size_t depth = fwp_state_len;
    /* restore the stack if the body fails through us */
    fwp_handler h;
    h.prev = fwp_handlers;
    h.state_depth = depth - 1;
    h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (setjmp(h.jb) == 0) {
        V r = fwp_apply1(f, x);
        fwp_handlers = h.prev;
        V st = fwp_state_pop();
        return fwp_tuple2(r, st);
    }
    fwp_handlers = h.prev;
    fwp_state_restore(h.state_depth);
    fwp_fail(h.value, h.desc);
    return 0;
}

/* ------------------------------------------------------------------ files */

static V fwp_io_error(const char *kind, const char *msg, const fwp_desc *d) {
    fwp_value_owner key = {fwp_rc_fresh(fwp_cstr(kind)), fwp_rc_free_obj};
    fwp_cleanup key_cleanup; fwp_value_protect(&key, &key_cleanup);
    fwp_value_owner text = {fwp_rc_fresh(fwp_cstr(msg)), fwp_rc_free_obj};
    fwp_cleanup text_cleanup; fwp_value_protect(&text, &text_cleanup);
    V fields[2] = {key.value, text.value};
    V error = fwp_rc_fresh(fwp_record(2, fields));
    (void)fwp_value_finish(&text, &text_cleanup);
    (void)fwp_value_finish(&key, &key_cleanup);
    fwp_fail(error, d);
    return 0;
}

static V fwp_io_error_path(const char *kind, const char *path, const fwp_desc *d) {
    char buf[1024];
    snprintf(buf, sizeof buf, "%s: %s", path, strerror(errno));
    return fwp_io_error(kind, buf, d);
}

#ifdef FWP_LIBRARY
static void fwp_file_final(void *p) {
    fwp_file *h = (fwp_file *)p;
    if (h->f) { fclose(h->f); h->f = 0; }
}
#endif

static V fwp_p_file_close(V h) {
    fwp_file *f = (fwp_file *)(uintptr_t)h;
    if (f->f) { fclose(f->f); f->f = 0; }
    return FWP_UNIT;
}

/* File aliases use the resource's own wide count. Explicit close ends I/O;
 * dropping the last alias also closes the stream, removes its library finalizer
 * and releases the header and inline path. */
static void fwp_file_dup(V h) {
    if (!h) return;
    fwp_file *file = (fwp_file *)(uintptr_t)h;
    if (!file->refs) fwp_trap("internal: duplicate discarded file");
    if (file->refs == UINT64_MAX) fwp_trap("reference count overflow");
    file->refs++;
}
static void fwp_file_drop(V h) {
    if (!h) return;
    fwp_file *file = (fwp_file *)(uintptr_t)h;
    if (!file->refs || --file->refs) return;
    fwp_p_file_close(h);
#ifdef FWP_LIBRARY
    fwp_heap_forget_finalizer(file);
#endif
    fwp_rc_resource_free_obj(h);
}

typedef struct { FILE *stream; V handle; } fwp_file_cleanup;
static void fwp_close_scoped_file(void *arg) {
    fwp_file_cleanup *file = arg;
    if (file->handle) fwp_p_file_close(file->handle);
    else fclose(file->stream); /* allocation failed before a handle existed */
}

/* Close while the constructor owner is still live, then release its storage. */
static void fwp_close_owned_scoped_file(void *arg) {
    fwp_file_cleanup *file = arg;
    fwp_close_scoped_file(file);
    V handle = file->handle;
    file->handle = 0;
    fwp_file_drop(handle);
}

static V fwp_file_value(FILE *f, const char *path) {
    fwp_file_cleanup file = {f, 0};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_close_owned_scoped_file, &file);
    size_t len = strlen(path);
    if (len > SIZE_MAX - sizeof(fwp_file) - 1) fwp_trap("file path too long");
    /* No heap-valued children: the path belongs to this leaf allocation. */
    fwp_file *h = (fwp_file *)fwp_alloc_leaf(sizeof(fwp_file) + len + 1);
    h->f = f;
    h->refs = 1;
    /* The header's storage starts unshared; File owners use their own count. */
    fwp_rc_fresh(PTR(h));
    file.handle = PTR(h);
#ifdef FWP_LIBRARY
    fwp_heap_finalizer(h, fwp_file_final);
#endif
    memcpy(h->path, path, len + 1);

    fwp_cleanup_pop(&cleanup);
    return PTR(h);
}

/* OS paths cannot contain a zero byte. Check before calling C APIs so a
 * malformed language string never operates on its prefix. */
static int fwp_path_has_nul(V path) {
    return memchr(STR(path)->d, 0, STR(path)->len) != NULL;
}

static V fwp_p_file_open(V path, int create, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("open", "path contains a NUL character", err);
    FILE *f = fwp_path_fopen(path, create ? "w+b" : "rb");
    if (!f) return fwp_io_error_path("open", STR(path)->d, err);
    return fwp_file_value(f, STR(path)->d);
}

static void fwp_file_buffer_cleanup(void *arg) {
    fwp_buf *b = arg;
    free(b->d);
    b->d = 0;
}

static void fwp_file_text_drop(V value) {
#ifdef FWP_RESOURCE_NO_FREE
    fwp_rc_drop(value);
#else
    fwp_rc_free_obj(value);
#endif
}

/* The temporary buffer belongs to the read, not to the borrowed File. */
static V fwp_p_file_read_all(V h, const fwp_desc *err) {
    fwp_file *f = (fwp_file *)(uintptr_t)h;
    fwp_buf b = {0};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_file_buffer_cleanup, &b);
    if (f->f) {
        char tmp[65536];
        size_t n;
        while ((n = fread(tmp, 1, sizeof tmp, f->f)) > 0) buf_put(&b, tmp, n);
        if (ferror(f->f)) {
            int error = errno;
            fwp_cleanup_pop(&cleanup);
            fwp_file_buffer_cleanup(&b);
            return fwp_io_error("read", strerror(error), err);
        }
    }
    if (!fwp_valid_utf8((const unsigned char *)(b.d ? b.d : ""), b.len)) {
        fwp_cleanup_pop(&cleanup);
        fwp_file_buffer_cleanup(&b);
        return fwp_io_error("read", "stream did not contain valid UTF-8", err);
    }
    V text = fwp_rc_fresh(buf_to_str(&b));
    b.d = 0;
    fwp_value_owner text_owner = {text, fwp_file_text_drop};
    fwp_cleanup text_cleanup;
    fwp_value_protect(&text_owner, &text_cleanup);
    V result = fwp_tuple2(text, h);
    fwp_rc_fresh(result);

    fwp_value_finish(&text_owner, &text_cleanup);
    fwp_cleanup_pop(&cleanup);
    return result;
}

static V fwp_p_file_write(V s, V h, const fwp_desc *err) {
    fwp_file *f = (fwp_file *)(uintptr_t)h;
    /* Rust File::write_all writes through to the descriptor. Flush stdio's
     * buffer before returning so later reads see the same effects and errors. */
    if (f->f && (fwrite(STR(s)->d, 1, STR(s)->len, f->f) != STR(s)->len || fflush(f->f) != 0))
        return fwp_io_error("write", strerror(errno), err);
    return h;
}

/* Borrowed I/O inputs, owned File aliases in the returned value. Protect the
 * completed extra reference while I/O/conversion can fail. */
static V fwp_p_file_write_owned(V s, V h, const fwp_desc *err) {
    fwp_file_dup(h);
    fwp_value_owner owner = {h, fwp_file_drop};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    fwp_p_file_write(s, h, err);
    return fwp_value_finish(&owner, &cleanup);
}
static V fwp_p_file_read_all_owned(V h, const fwp_desc *err) {
    fwp_file_dup(h);
    fwp_value_owner owner = {h, fwp_file_drop};
    fwp_cleanup cleanup;
    fwp_value_protect(&owner, &cleanup);
    V result = fwp_p_file_read_all(h, err);
    fwp_value_finish(&owner, &cleanup);
    return result;
}

static V fwp_p_file_with(V path, V fn, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("open", "path contains a NUL character", err);
    FILE *f = fwp_path_fopen(path, "r+b");
    if (!f) f = fwp_path_fopen(path, "w+b");
    if (!f) return fwp_io_error_path("open", STR(path)->d, err);
    V h = fwp_file_value(f, STR(path)->d);
    fwp_file_cleanup file = {f, h};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_close_scoped_file, &file);
    fwp_handler hd;
    hd.prev = fwp_handlers;
    hd.state_depth = fwp_state_len;
    hd.cleanup = cleanup.prev; /* failure also releases this scoped file */
    fwp_handlers = &hd;
    if (setjmp(hd.jb) == 0) {
        V r = fwp_apply1(fn, h);
        fwp_handlers = hd.prev;
        fwp_cleanup_pop(&cleanup);
        fwp_close_scoped_file(&file);
        return OBJ(r)->f[0];
    }
    fwp_handlers = hd.prev;
    /* The failure unwind already closed the file. */
    fwp_fail(hd.value, hd.desc);
    return 0;
}

static V fwp_p_file_with_owned(V path, V fn, const fwp_desc *err, void (*drop_pair)(V), void (*dup_result)(V)) {
    if (fwp_path_has_nul(path)) return fwp_io_error("open", "path contains a NUL character", err);
    FILE *f = fwp_path_fopen(path, "r+b");
    if (!f) f = fwp_path_fopen(path, "w+b");
    if (!f) return fwp_io_error_path("open", STR(path)->d, err);
    V h = fwp_file_value(f, STR(path)->d);
    fwp_file_cleanup file = {f, h};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_close_owned_scoped_file, &file);
    fwp_handler hd;
    hd.prev = fwp_handlers;
    hd.state_depth = fwp_state_len;
    hd.cleanup = cleanup.prev; /* failure also releases this scoped file */
    fwp_handlers = &hd;
    if (setjmp(hd.jb) == 0) {
        V r = fwp_apply_borrowed(fn, 1, &h);
        fwp_handlers = hd.prev;
        fwp_value_owner pair_owner = {r, drop_pair};
        fwp_cleanup pair_cleanup;
        fwp_value_protect(&pair_owner, &pair_cleanup);
        V result = OBJ(r)->f[0];
        if (dup_result) dup_result(result);
        fwp_value_finish(&pair_owner, &pair_cleanup);
        if (drop_pair) drop_pair(r);
        fwp_cleanup_pop(&cleanup);
        fwp_close_owned_scoped_file(&file);

        return result;
    }
    fwp_handlers = hd.prev;
    /* The failure unwind already closed the file. */
    fwp_fail(hd.value, hd.desc);
    return 0;
}

static V fwp_p_file_read_impl(V path, const fwp_desc *err, int text) {
    if (fwp_path_has_nul(path)) return fwp_io_error("read", "path contains a NUL character", err);
    FILE *f = fwp_path_fopen(path, "rb");
    if (!f) return fwp_io_error_path("read", STR(path)->d, err);
    fwp_file_cleanup file = {f, 0};
    fwp_cleanup stream_cleanup;
    fwp_cleanup_push(&stream_cleanup, fwp_close_scoped_file, &file);
    fwp_buf b = {0};
    fwp_cleanup buffer_cleanup;
    fwp_cleanup_push(&buffer_cleanup, fwp_file_buffer_cleanup, &b);
    char tmp[65536];
    size_t n;
    while ((n = fread(tmp, 1, sizeof tmp, f)) > 0) buf_put(&b, tmp, n);
    int error = ferror(f) ? errno : 0;
    fclose(f);
    fwp_cleanup_pop(&buffer_cleanup);
    fwp_cleanup_pop(&stream_cleanup);
    if (error) {
        fwp_file_buffer_cleanup(&b);
        errno = error;
        return fwp_io_error_path("read", STR(path)->d, err);
    }
    if (text && !fwp_valid_utf8((const unsigned char *)(b.d ? b.d : ""), b.len)) {
        fwp_file_buffer_cleanup(&b);
        char message[1024];
        snprintf(message, sizeof message, "%s: stream did not contain valid UTF-8", STR(path)->d);
        return fwp_io_error("read", message, err);
    }
    fwp_cleanup_push(&buffer_cleanup, fwp_file_buffer_cleanup, &b);
    V result = buf_to_str(&b);
    b.d = 0;
    fwp_cleanup_pop(&buffer_cleanup);

    return result;
}

static V fwp_p_file_read(V path, const fwp_desc *err) {
    return fwp_p_file_read_impl(path, err, 1);
}
static V fwp_p_file_read_bytes(V path, const fwp_desc *err) {
    return fwp_p_file_read_impl(path, err, 0);
}

static V fwp_p_file_write_new(V path, V s, const fwp_desc *err) {
    if (fwp_path_has_nul(path)) return fwp_io_error("write", "path contains a NUL character", err);
    FILE *f = fwp_path_fopen(path, "wb");
    if (!f) return fwp_io_error_path("write", STR(path)->d, err);
    int error = fwrite(STR(s)->d, 1, STR(s)->len, f) == STR(s)->len ? 0 : errno;
    if (fclose(f) != 0 && !error) error = errno;
    if (error) {
        errno = error;
        return fwp_io_error_path("write", STR(path)->d, err);
    }
    return FWP_UNIT;
}

/* ------------------------------------------------------------ syntax.show */
/* Mirrors src/syntax.rs `show` (pretty printing of `Syntax` values). */

enum { SY_NAME, SY_CTOR, SY_INT, SY_FLOAT, SY_STR, SY_SELECT, SY_APPLY, SY_PIPE, SY_UNIT,
       SY_TUPLE, SY_LIST, SY_RECORD, SY_MATCH, SY_COMPTIME, SY_OTHER, SY_MACRO, SY_FIELDS };
enum { PY_HOLE, PY_INT, PY_STR, PY_CTOR, PY_BARE, PY_TUPLE, PY_UNIT };

static void sy_name(fwp_buf *b, V s) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len;
    if (n >= 2 && d[0] == ':' && d[1] == ':') {
        const char *abs = d + 2;
        size_t an = n - 2;
        const char *sep = 0;
        for (size_t i = 0; i + 1 < an; i++)
            if (abs[i] == ':' && abs[i + 1] == ':') { sep = abs + i; break; }
        if (!sep) { buf_put(b, abs, an); return; }
        size_t ml = (size_t)(sep - abs);
        const char *rest = sep + 2;
        size_t rl = an - ml - 2;
        if ((ml == 3 && memcmp(abs, "std", 3) == 0) || (ml == 4 && memcmp(abs, "main", 4) == 0)) {
            buf_put(b, rest, rl);
        } else {
            buf_put(b, abs, ml);
            buf_putc(b, '.');
            buf_put(b, rest, rl);
        }
        return;
    }
    buf_put(b, d, n);
}

static void sy_expr(fwp_buf *b, V v);
static void sy_atom(fwp_buf *b, V v);

/* STuple of one element and SApply without arguments stand for their
 * single sub-expression */
static V sy_norm(V v) {
    for (;;) {
        uint32_t t = fwp_tag(v);
        if (t == SY_APPLY && OBJ(v)->f[1] == 0) { v = OBJ(v)->f[0]; continue; }
        if (t == SY_TUPLE && OBJ(v)->f[0] != 0 && OBJ(OBJ(v)->f[0])->f[1] == 0) {
            v = OBJ(OBJ(v)->f[0])->f[0];
            continue;
        }
        return v;
    }
}

static void sy_list(fwp_buf *b, V xs, void (*item)(fwp_buf *, V)) {
    int first = 1;
    for (; xs != 0; xs = OBJ(xs)->f[1]) {
        if (!first) buf_puts(b, ", ");
        first = 0;
        item(b, OBJ(xs)->f[0]);
    }
}

static void sy_pat(fwp_buf *b, V p) {
    char t[64];
    switch (fwp_tag(p)) {
    case PY_HOLE: buf_putc(b, '_'); return;
    case PY_INT: snprintf(t, sizeof t, "%lld", (long long)(int64_t)OBJ(p)->f[0]); buf_puts(b, t); return;
    case PY_STR: fwp_escape(b, STR(OBJ(p)->f[0])->d, STR(OBJ(p)->f[0])->len); return;
    case PY_BARE: sy_name(b, OBJ(p)->f[0]); return;
    case PY_CTOR: {
        sy_name(b, OBJ(p)->f[0]);
        for (V xs = OBJ(p)->f[1]; xs != 0; xs = OBJ(xs)->f[1]) {
            V a = OBJ(xs)->f[0];
            buf_putc(b, ' ');
            int paren = fwp_tag(a) == PY_CTOR && OBJ(a)->f[1] != 0;
            if (paren) buf_putc(b, '(');
            sy_pat(b, a);
            if (paren) buf_putc(b, ')');
        }
        return;
    }
    case PY_TUPLE: buf_putc(b, '('); sy_list(b, OBJ(p)->f[0], sy_pat); buf_putc(b, ')'); return;
    default: buf_puts(b, "()"); return;
    }
}

static void sy_field(fwp_buf *b, V kv) {
    buf_put(b, STR(OBJ(kv)->f[0])->d, STR(OBJ(kv)->f[0])->len);
    buf_puts(b, " = ");
    sy_expr(b, OBJ(kv)->f[1]);
}

static void sy_arm(fwp_buf *b, V pe) {
    sy_pat(b, OBJ(pe)->f[0]);
    buf_puts(b, " -> ");
    sy_expr(b, OBJ(pe)->f[1]);
}

static void sy_atom(fwp_buf *b, V v) {
    char t[512];
    v = sy_norm(v);
    switch (fwp_tag(v)) {
    case SY_NAME: case SY_CTOR: sy_name(b, OBJ(v)->f[0]); return;
    case SY_INT: snprintf(t, sizeof t, "%lld", (long long)(int64_t)OBJ(v)->f[0]); buf_puts(b, t); return;
    case SY_FLOAT: {
        fwp_str *s = STR(OBJ(v)->f[0]);
        size_t p = 0, start;
        int fraction = 0, exponent = 0;
        if (p < s->len && s->d[p] == '-') p++;
        start = p;
        while (p < s->len && s->d[p] >= '0' && s->d[p] <= '9') p++;
        int valid = p > start;
        if (p < s->len && s->d[p] == '.') {
            fraction = 1;
            start = ++p;
            while (p < s->len && s->d[p] >= '0' && s->d[p] <= '9') p++;
            valid &= p > start;
        }
        if (p < s->len && s->d[p] == 'e') {
            exponent = 1;
            p++;
            if (p < s->len && (s->d[p] == '+' || s->d[p] == '-')) p++;
            start = p;
            while (p < s->len && s->d[p] >= '0' && s->d[p] <= '9') p++;
            valid &= p > start;
        }
        if (valid && (fraction || exponent) && p == s->len) buf_put(b, s->d, s->len);
        else buf_puts(b, "<SFloat needs an unsuffixed decimal float literal>");
        return;
    }
    case SY_STR: fwp_escape(b, STR(OBJ(v)->f[0])->d, STR(OBJ(v)->f[0])->len); return;
    case SY_SELECT:
        for (V xs = OBJ(v)->f[0]; xs != 0; xs = OBJ(xs)->f[1]) {
            buf_putc(b, '.');
            buf_put(b, STR(OBJ(xs)->f[0])->d, STR(OBJ(xs)->f[0])->len);
        }
        return;
    case SY_APPLY: case SY_PIPE: buf_putc(b, '('); sy_expr(b, v); buf_putc(b, ')'); return;
    case SY_UNIT: buf_puts(b, "()"); return;
    case SY_TUPLE:
        if (OBJ(v)->f[0] == 0) { buf_puts(b, "()"); return; }
        buf_putc(b, '('); sy_list(b, OBJ(v)->f[0], sy_expr); buf_putc(b, ')'); return;
    case SY_LIST: buf_putc(b, '['); sy_list(b, OBJ(v)->f[0], sy_expr); buf_putc(b, ']'); return;
    case SY_RECORD:
        if (OBJ(v)->f[0] == 0) { buf_puts(b, "()"); return; }
        buf_putc(b, '{'); sy_list(b, OBJ(v)->f[0], sy_field); buf_putc(b, '}'); return;
    case SY_MATCH: buf_puts(b, "(match {"); sy_list(b, OBJ(v)->f[0], sy_arm); buf_puts(b, "})"); return;
    case SY_COMPTIME: buf_puts(b, "(comptime "); sy_expr(b, OBJ(v)->f[0]); buf_putc(b, ')'); return;
    case SY_OTHER: buf_put(b, STR(OBJ(v)->f[0])->d, STR(OBJ(v)->f[0])->len); return;
    case SY_MACRO:
        buf_put(b, STR(OBJ(v)->f[0])->d, STR(OBJ(v)->f[0])->len);
        buf_puts(b, "!(");
        sy_list(b, OBJ(v)->f[1], sy_expr);
        buf_putc(b, ')');
        return;
    case SY_FIELDS: {
        /* kind: with, update, make, "make T", "record T" (printed `T {...}`) */
        V k = OBJ(v)->f[0];
        if (STR(k)->len > 7 && !memcmp(STR(k)->d, "record ", 7)) buf_put(b, STR(k)->d + 7, STR(k)->len - 7);
        else buf_put(b, STR(k)->d, STR(k)->len);
        buf_puts(b, " {");
        sy_list(b, OBJ(v)->f[1], sy_field);
        buf_putc(b, '}');
        return;
    }
    }
}

static void sy_app(fwp_buf *b, V v) {
    v = sy_norm(v);
    if (fwp_tag(v) == SY_APPLY) {
        sy_atom(b, OBJ(v)->f[0]);
        for (V xs = OBJ(v)->f[1]; xs != 0; xs = OBJ(xs)->f[1]) {
            buf_putc(b, ' ');
            sy_atom(b, OBJ(xs)->f[0]);
        }
        return;
    }
    sy_atom(b, v);
}

static void sy_expr(fwp_buf *b, V v) {
    v = sy_norm(v);
    switch (fwp_tag(v)) {
    case SY_PIPE:
        sy_expr(b, OBJ(v)->f[0]);
        buf_puts(b, " | ");
        sy_app(b, OBJ(v)->f[1]);
        return;
    case SY_COMPTIME:
        buf_puts(b, "comptime (");
        sy_expr(b, OBJ(v)->f[0]);
        buf_putc(b, ')');
        return;
    default: sy_app(b, v);
    }
}

static V fwp_p_syntax_show(V v) {
    fwp_buf b = {0};
    fwp_cleanup cleanup; fwp_cleanup_push(&cleanup, fwp_buf_release, &b);
    sy_expr(&b, v);
    V result = buf_to_str(&b);
    fwp_cleanup_pop(&cleanup);

    return result;
}

/* ------------------------------------------------------- linear algebra */
/* Same algorithms and operation order as src/linalg.rs. */

/* A solver owns its scratch and any result arrays not yet transferred into
 * the returned value. These fields stay on the C stack, not the managed heap. */
typedef struct { double *scratch[5]; V results[2]; } fwp_la_owner;
static void la_release(void *arg) {
    fwp_la_owner *owner = arg;
    for (size_t i = 2; i > 0; i--) {
        V value = owner->results[i - 1];
        owner->results[i - 1] = 0;
        if (value) { fwp_rc_free_arr(value); }
    }
    for (size_t i = 5; i > 0; i--) {
        double *buffer = owner->scratch[i - 1];
        owner->scratch[i - 1] = NULL;
        if (buffer) { fwp_mem_free(buffer); }
    }
}
static void la_protect(fwp_la_owner *owner, fwp_cleanup *cleanup) {
#if FWP_UNWIND
    fwp_cleanup_push(cleanup, la_release, owner);
#else
    (void)owner; (void)cleanup;
#endif
}
static void la_finish(fwp_la_owner *owner, fwp_cleanup *cleanup) {
#if FWP_UNWIND
    fwp_cleanup_pop(cleanup);
#else
    (void)cleanup;
#endif
    la_release(owner);
}
static double *la_alloc(fwp_la_owner *owner, size_t slot, size_t n) {
    if (n >= SIZE_MAX / sizeof(double)) fwp_trap("array too large");
    double *buffer = (double *)fwp_alloc_leaf((n + 1) * sizeof(double));
    owner->scratch[slot] = buffer;
    return buffer;
}
static double *la_get(fwp_la_owner *owner, size_t slot, V arr, size_t n) {
    double *d = la_alloc(owner, slot, n);
    for (size_t i = 0; i < n; i++) d[i] = fwp_f64(fwp_array_load(arr, i, NULL));
    return d;
}

/* traps unless array `arr` holds a rows x cols matrix (as la_check in
 * src/prims_std.rs) */
static void la_check(const char *name, V arr, int64_t rows, int64_t cols) {
    char msg[256];
    if (rows < 0 || cols < 0) {
        snprintf(msg, sizeof msg, "%s: negative dimension", name);
        fwp_trap(msg);
    }
    size_t len = fwp_array_len(arr);
    if ((i128)len != (i128)rows * (i128)cols) {
        snprintf(msg, sizeof msg, "%s: %zu elements given for a %lldx%lld matrix", name, len,
                 (long long)rows, (long long)cols);
        fwp_trap(msg);
    }
}

static V la_put(fwp_la_owner *owner, size_t slot, const double *d, size_t n) {
    V r = fwp_rc_fresh(fwp_arr_new(n));
    owner->results[slot] = r;
    for (size_t i = 0; i < n; i++) ARR(r)->d[i] = fwp_from_f64(d[i]);
    return r;
}

static V fwp_p_lu_solve(V nv, V av, V bv) {
    la_check("linalg.lu-solve", av, (int64_t)nv, (int64_t)nv);
    la_check("linalg.lu-solve", bv, (int64_t)nv, 1);
    size_t n = (size_t)(int64_t)nv;
    fwp_la_owner owner = {0}; fwp_cleanup cleanup;
    la_protect(&owner, &cleanup);
    double *a = la_get(&owner, 0, av, n * n), *x = la_get(&owner, 1, bv, n);
    for (size_t k = 0; k < n; k++) {
        size_t p = k;
        for (size_t i = k + 1; i < n; i++)
            if (fabs(a[i * n + k]) > fabs(a[p * n + k])) p = i;
        if (a[p * n + k] == 0.0) { la_finish(&owner, &cleanup); return FWP_NONE; }
        if (p != k) {
            for (size_t j = 0; j < n; j++) { double t = a[k * n + j]; a[k * n + j] = a[p * n + j]; a[p * n + j] = t; }
            double t = x[k]; x[k] = x[p]; x[p] = t;
        }
        for (size_t i = k + 1; i < n; i++) {
            double f = a[i * n + k] / a[k * n + k];
            for (size_t j = k; j < n; j++) a[i * n + j] -= f * a[k * n + j];
            x[i] -= f * x[k];
        }
    }
    for (size_t ii = n; ii > 0; ii--) {
        size_t i = ii - 1;
        double s = x[i];
        for (size_t j = i + 1; j < n; j++) s -= a[i * n + j] * x[j];
        x[i] = s / a[i * n + i];
    }
    V result = fwp_rc_fresh(fwp_some(la_put(&owner, 0, x, n)));
    owner.results[0] = 0;
    la_finish(&owner, &cleanup);
    return result;
}

static V fwp_p_det(V nv, V av) {
    la_check("linalg.det", av, (int64_t)nv, (int64_t)nv);
    size_t n = (size_t)(int64_t)nv;
    fwp_la_owner owner = {0}; fwp_cleanup cleanup;
    la_protect(&owner, &cleanup);
    double *a = la_get(&owner, 0, av, n * n), d = 1.0;
    for (size_t k = 0; k < n; k++) {
        size_t p = k;
        for (size_t i = k + 1; i < n; i++)
            if (fabs(a[i * n + k]) > fabs(a[p * n + k])) p = i;
        if (a[p * n + k] == 0.0) { la_finish(&owner, &cleanup); return fwp_from_f64(0.0); }
        if (p != k) {
            for (size_t j = 0; j < n; j++) { double t = a[k * n + j]; a[k * n + j] = a[p * n + j]; a[p * n + j] = t; }
            d = -d;
        }
        d *= a[k * n + k];
        for (size_t i = k + 1; i < n; i++) {
            double f = a[i * n + k] / a[k * n + k];
            for (size_t j = k; j < n; j++) a[i * n + j] -= f * a[k * n + j];
        }
    }
    la_finish(&owner, &cleanup);
    return fwp_from_f64(d);
}

static V fwp_p_inverse(V nv, V av) {
    la_check("linalg.inverse", av, (int64_t)nv, (int64_t)nv);
    size_t n = (size_t)(int64_t)nv;
    fwp_la_owner owner = {0}; fwp_cleanup cleanup;
    la_protect(&owner, &cleanup);
    double *a = la_get(&owner, 0, av, n * n);
    double *inv = la_alloc(&owner, 1, n * n);
    for (size_t i = 0; i < n * n; i++) inv[i] = 0.0;
    for (size_t i = 0; i < n; i++) inv[i * n + i] = 1.0;
    for (size_t k = 0; k < n; k++) {
        size_t p = k;
        for (size_t i = k + 1; i < n; i++)
            if (fabs(a[i * n + k]) > fabs(a[p * n + k])) p = i;
        if (a[p * n + k] == 0.0) { la_finish(&owner, &cleanup); return FWP_NONE; }
        if (p != k)
            for (size_t j = 0; j < n; j++) {
                double t = a[k * n + j]; a[k * n + j] = a[p * n + j]; a[p * n + j] = t;
                t = inv[k * n + j]; inv[k * n + j] = inv[p * n + j]; inv[p * n + j] = t;
            }
        double d = a[k * n + k];
        for (size_t j = 0; j < n; j++) { a[k * n + j] /= d; inv[k * n + j] /= d; }
        for (size_t i = 0; i < n; i++) {
            if (i == k) continue;
            double f = a[i * n + k];
            for (size_t j = 0; j < n; j++) {
                a[i * n + j] -= f * a[k * n + j];
                inv[i * n + j] -= f * inv[k * n + j];
            }
        }
    }
    V result = fwp_rc_fresh(fwp_some(la_put(&owner, 0, inv, n * n)));
    owner.results[0] = 0;
    la_finish(&owner, &cleanup);
    return result;
}

static V fwp_p_cholesky(V nv, V av) {
    la_check("linalg.cholesky", av, (int64_t)nv, (int64_t)nv);
    size_t n = (size_t)(int64_t)nv;
    fwp_la_owner owner = {0}; fwp_cleanup cleanup;
    la_protect(&owner, &cleanup);
    double *a = la_get(&owner, 0, av, n * n);
    double *l = la_alloc(&owner, 1, n * n);
    for (size_t i = 0; i < n * n; i++) l[i] = 0.0;
    for (size_t i = 0; i < n; i++)
        for (size_t j = 0; j <= i; j++) {
            double s = a[i * n + j];
            for (size_t k = 0; k < j; k++) s -= l[i * n + k] * l[j * n + k];
            if (i == j) {
                if (s <= 0.0) { la_finish(&owner, &cleanup); return FWP_NONE; }
                l[i * n + j] = sqrt(s);
            } else {
                l[i * n + j] = s / l[j * n + j];
            }
        }
    V result = fwp_rc_fresh(fwp_some(la_put(&owner, 0, l, n * n)));
    owner.results[0] = 0;
    la_finish(&owner, &cleanup);
    return result;
}

static V fwp_p_qr(V mv, V nv, V av) {
    la_check("linalg.qr", av, (int64_t)mv, (int64_t)nv);
    /* A zero-row input can have arbitrarily many columns. Bound the square
     * output before size_t conversion, multiplication or scratch allocation. */
    uint64_t columns = (uint64_t)nv;
    uint64_t limit = (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V);
    if (columns && columns > limit / columns) fwp_trap("array too large");
    size_t m = (size_t)(int64_t)mv, n = (size_t)(int64_t)nv;
    fwp_la_owner owner = {0}; fwp_cleanup cleanup;
    la_protect(&owner, &cleanup);
    double *q = la_get(&owner, 0, av, m * n);
    double *r = la_alloc(&owner, 1, n * n);
    for (size_t i = 0; i < n * n; i++) r[i] = 0.0;
    for (size_t j = 0; j < n; j++) {
        for (size_t i = 0; i < j; i++) {
            double d = 0.0;
            for (size_t k = 0; k < m; k++) d += q[k * n + i] * q[k * n + j];
            r[i * n + j] = d;
            for (size_t k = 0; k < m; k++) q[k * n + j] -= d * q[k * n + i];
        }
        double s = 0.0;
        for (size_t k = 0; k < m; k++) s += q[k * n + j] * q[k * n + j];
        double norm = sqrt(s);
        r[j * n + j] = norm;
        if (norm != 0.0)
            for (size_t k = 0; k < m; k++) q[k * n + j] /= norm;
    }
    V qv = la_put(&owner, 0, q, m * n);
    V rv = la_put(&owner, 1, r, n * n);
    V result = fwp_rc_fresh(fwp_tuple2(qv, rv));
    owner.results[0] = owner.results[1] = 0;
    la_finish(&owner, &cleanup);
    return result;
}

static double la_dot(const double *x, const double *y, size_t n) {
    double s = 0.0;
    for (size_t i = 0; i < n; i++) s += x[i] * y[i];
    return s;
}

static V fwp_p_cg(V itv, V tolv, V nv, V av, V bv) {
    int64_t maxit = (int64_t)itv;
    double tol = fwp_f64(tolv);
    la_check("linalg.cg", av, (int64_t)nv, (int64_t)nv);
    la_check("linalg.cg", bv, (int64_t)nv, 1);
    size_t n = (size_t)(int64_t)nv;
    fwp_la_owner owner = {0}; fwp_cleanup cleanup;
    la_protect(&owner, &cleanup);
    double *a = la_get(&owner, 0, av, n * n), *r = la_get(&owner, 1, bv, n), *p = la_get(&owner, 2, bv, n);
    double *x = la_alloc(&owner, 3, n);
    double *ap = la_alloc(&owner, 4, n);
    for (size_t i = 0; i < n; i++) x[i] = 0.0;
    double rs = la_dot(r, r, n);
    for (int64_t it = 0; it < maxit; it++) {
        if (sqrt(rs) <= tol) break;
        for (size_t i = 0; i < n; i++) {
            double s = 0.0;
            for (size_t j = 0; j < n; j++) s += a[i * n + j] * p[j];
            ap[i] = s;
        }
        double alpha = rs / la_dot(p, ap, n);
        for (size_t i = 0; i < n; i++) { x[i] += alpha * p[i]; r[i] -= alpha * ap[i]; }
        double rs_new = la_dot(r, r, n);
        double beta = rs_new / rs;
        for (size_t i = 0; i < n; i++) p[i] = r[i] + beta * p[i];
        rs = rs_new;
    }
    V result = la_put(&owner, 0, x, n);
    owner.results[0] = 0;
    la_finish(&owner, &cleanup);
    return result;
}

/* Borrow each input row, copy only list nodes and retain typed element aliases.
 * Scratch holds row cursors and completed columns, not copies of every row. */
static V fwp_p_list_transpose_owned(V xss, void (*dup_element)(V),
        void (*drop_element)(V), void (*drop_row)(V), void (*drop_result)(V)) {
    size_t nr;
    V *rows = fwp_map_items(xss, &nr);
    fwp_cleanup scratch_cleanup;
    fwp_scratch_protect(&rows, &scratch_cleanup);
    size_t nc = 0;
    for (size_t i = 0; i < nr; i++) {
        size_t n = fwp_list_len(rows[i]);
        if (i == 0 || n < nc) nc = n;
    }
    if (nc >= SIZE_MAX / sizeof(V)) fwp_trap("transpose too large");
    V *cols = (V *)fwp_mem_alloc((nc + 1) * sizeof(V));
    fwp_map_owner columns = {cols, 0, 0, drop_row, drop_result};
    fwp_cleanup columns_cleanup;
    fwp_map_protect(&columns, &columns_cleanup);
    fwp_value_owner row = {0, drop_row};
    fwp_value_owner pending = {0, drop_element};
    fwp_cleanup row_cleanup, pending_cleanup;
    fwp_value_protect(&row, &row_cleanup);
    fwp_value_protect(&pending, &pending_cleanup);
    for (size_t column = 0; column < nc; column++) {
        for (size_t i = nr; i > 0; i--) {
            V value = OBJ(rows[i - 1])->f[0];
            if (dup_element) dup_element(value);
            pending.value = value;
            row.value = fwp_rc_fresh(fwp_cons(value, row.value));
            pending.value = 0;
            rows[i - 1] = OBJ(rows[i - 1])->f[1];
        }
        cols[column] = row.value;
        columns.count++;
        row.value = 0;
    }
    (void)fwp_value_finish(&pending, &pending_cleanup);
    (void)fwp_value_finish(&row, &row_cleanup);
    V output = fwp_map_finish_protected(&columns, &columns_cleanup);
    fwp_scratch_finish(&rows, &scratch_cleanup);

    return output;
}

static V fwp_p_list_transpose(V xss) {
    size_t nr;
    V *rows = fwp_list_items(xss, &nr);
    size_t nc = 0;
    for (size_t i = 0; i < nr; i++) { size_t l = fwp_list_len(rows[i]); if (i == 0 || l < nc) nc = l; }
    if (nr == 0) return 0;
    V *cols = (V *)fwp_alloc((nc + 1) * sizeof(V));
    V **items = (V **)fwp_alloc((nr + 1) * sizeof(V *));
    for (size_t i = 0; i < nr; i++) { size_t l; items[i] = fwp_list_items(rows[i], &l); }
    V *col = (V *)fwp_alloc((nr + 1) * sizeof(V));
    for (size_t j = 0; j < nc; j++) {
        for (size_t i = 0; i < nr; i++) col[i] = items[i][j];
        cols[j] = fwp_list_from(col, nr);
    }
    return fwp_list_from(cols, nc);
}

/* ----- results of foreign C functions */

/* a string for C: NUL-terminated, so it must not contain NUL itself (C
 * would see a shorter string); traps as the interpreter does */
static const char *fwp_c_str_arg(V s) {
    if (memchr(STR(s)->d, 0, STR(s)->len)) fwp_trap("a string passed to C contains a NUL character");
    return (const char *)STR(s)->d;
}

static V fwp_c_string(const char *p) {
    if (!p) fwp_trap("foreign function returned a null string");
    size_t n = strlen(p);
    if (!fwp_valid_utf8((const unsigned char *)p, n)) fwp_trap("foreign function returned a string that is not UTF-8");
    return fwp_str_new(p, n);
}

static V fwp_c_optptr(void *p) { return p ? fwp_some((V)(uintptr_t)p) : FWP_NONE; }
