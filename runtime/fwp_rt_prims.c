/* Primitives of the standard library (C implementations, mirroring
 * src/interp.rs and src/prims_std.rs). */

static int fwp_argc;
static char **fwp_argv;

/* ------------------------------------------------------------------ lists */

static V fwp_p_map(V f, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++) a[i] = fwp_apply1(f, a[i]);
    return fwp_list_from(a, n);
}

/* Scratch storage remains scanned until results transfer into fresh nodes.
 * Elements already carry callback result ownership; never reset their counts. */
static V *fwp_map_items(V xs, size_t *n) {
    V source = xs;
    *n = fwp_list_len(xs);
    if (*n >= SIZE_MAX / sizeof(V)) fwp_trap("map too large");
    V *a = (V *)fwp_mem_alloc((*n + 1) * sizeof(V));
    for (size_t i = 0; xs; i++, xs = OBJ(xs)->f[1]) a[i] = OBJ(xs)->f[0];
    FWP_KEEP_ALIVE(source);
    return a;
}
static V fwp_map_finish(V *a, size_t n) {
    V result = 0;
    for (size_t i = n; i; i--) {
        V fields[] = {a[i - 1], result};
        result = fwp_rc_fresh(fwp_data(1, 2, fields));
    }
    FWP_KEEP_ALIVE(a);
    fwp_mem_free(a);
    return result;
}
static V fwp_p_map_owned(V f, V xs) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    for (size_t i = 0; i < n; i++) a[i] = fwp_apply_borrowed(f, 1, &a[i]);
    V result = fwp_map_finish(a, n);
    FWP_KEEP_ALIVE(f);
    FWP_KEEP_ALIVE(xs);
    return result;
}

static V fwp_p_filter(V f, V xs) {
    size_t n, k = 0;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++)
        if (fwp_apply1(f, a[i]) == FWP_TRUE) a[k++] = a[i];
    return fwp_list_from(a, k);
}

/* A selected output element needs its own reference independently of the
 * temporary owned copy consumed by the predicate. Its monomorphic parameter
 * metadata distinguishes pointers from scalar words. */
static void fwp_filter_element_dup(V f, V element) {
    fwp_clo *c = CLO(f);
    const fwp_fninfo *fi = &fwp_fns[c->fn];
    if (fi->owned) fi->owned->arguments(&element, c->n, 1);
    else fwp_rc_share(element);
}
static V fwp_p_filter_owned(V f, V xs) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    for (size_t i = 0; i < n; i++) {
        if (fwp_apply_borrowed(f, 1, &a[i]) == FWP_TRUE) {
            fwp_filter_element_dup(f, a[i]);
            a[k++] = a[i];
        }
    }
    V result = fwp_map_finish(a, k);
    FWP_KEEP_ALIVE(f);
    FWP_KEEP_ALIVE(xs);
    return result;
}

/* Prefix selection stops at the first rejected element. The input owner
 * remains live across predicate calls and result-node allocation. */
static V fwp_p_take_while_owned(V f, V xs) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    while (k < n && fwp_apply_borrowed(f, 1, &a[k]) == FWP_TRUE) {
        fwp_filter_element_dup(f, a[k]);
        k++;
    }
    V result = fwp_map_finish(a, k);
    FWP_KEEP_ALIVE(f);
    FWP_KEEP_ALIVE(xs);
    return result;
}
static V fwp_p_drop_while_owned(V f, V xs) {
    V source = xs;
    while (xs && fwp_apply_borrowed(f, 1, &OBJ(xs)->f[0]) == FWP_TRUE)
        xs = OBJ(xs)->f[1];
    fwp_rc_dup(xs);
    FWP_KEEP_ALIVE(f);
    FWP_KEEP_ALIVE(source);
    return xs;
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
    FWP_KEEP_ALIVE(f);
    FWP_KEEP_ALIVE(source);
    return z;
}

static V fwp_p_fold_right(V f, V z, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = n; i > 0; i--) z = fwp_apply2(f, a[i - 1], z);
    return z;
}

static V fwp_p_fold_right_own(V f, V z, V xs) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    for (size_t i = n; i > 0; i--) {
        V args[] = {a[i - 1], z};
        z = fwp_apply_borrowed_span(f, 2, args, 1, 1);
    }
    FWP_KEEP_ALIVE(a);
    fwp_mem_free(a);
    FWP_KEEP_ALIVE(f);
    FWP_KEEP_ALIVE(xs);
    return z;
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
    memcpy(vals, tv, n * sizeof(V));
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
    FWP_KEEP_ALIVE(a);
    return r;
}

static V fwp_p_flatten(V xss) {
    size_t n;
    V *a = fwp_list_items(xss, &n);
    V r = 0;
    for (size_t i = n; i > 0; i--) r = fwp_p_append(r, a[i - 1]);
    FWP_KEEP_ALIVE(a);
    return r;
}

/* Copies leave their new nodes uncounted until the monomorphic wrapper
 * duplicates element references by type. The optional suffix is borrowed. */
static V fwp_copy_finish(V *a, size_t n, V tail) {
    V result = tail;
    for (size_t i = n; i; i--) result = fwp_cons(a[i - 1], result);
    FWP_KEEP_ALIVE(a);
    FWP_KEEP_ALIVE(tail);
    fwp_mem_free(a);
    return result;
}
/* Sorting aliases values; scratch words are tracing roots, not owners. */
static V fwp_p_sort_copied(V xs, const fwp_desc *elem) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    if (n > 1) {
        V *tk = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        V *tv = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        V *vals = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        memcpy(vals, a, n * sizeof(V));
        fwp_msort(a, vals, n, elem, tk, tv);
        FWP_KEEP_ALIVE(tk);
        FWP_KEEP_ALIVE(tv);
        FWP_KEEP_ALIVE(vals);
        fwp_mem_free(vals);
        fwp_mem_free(tv);
        fwp_mem_free(tk);
    }
    V result = fwp_copy_finish(a, n, 0);
    FWP_KEEP_ALIVE(xs);
    return result;
}
/* Callback keys carry owned references; output values borrow the source.
 * The monomorphic key release distinguishes scalar words from references. */
static V fwp_p_sort_by_copied(V f, V xs, const fwp_desc *key, void (*drop_key)(V)) {
    size_t n;
    V *vals = fwp_map_items(xs, &n);
    V *keys = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    for (size_t i = 0; i < n; i++) keys[i] = fwp_apply_borrowed(f, 1, &vals[i]);
    if (n > 1) {
        V *tk = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        V *tv = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        fwp_msort(keys, vals, n, key, tk, tv);
        FWP_KEEP_ALIVE(tk);
        FWP_KEEP_ALIVE(tv);
        fwp_mem_free(tv);
        fwp_mem_free(tk);
    }
    if (drop_key) {
        for (size_t i = 0; i < n; i++) {
            V owned_key = keys[i];
            keys[i] = 0;
            drop_key(owned_key);
        }
    }
    FWP_KEEP_ALIVE(keys);
    fwp_mem_free(keys);
    V result = fwp_copy_finish(vals, n, 0);
    FWP_KEEP_ALIVE(f);
    FWP_KEEP_ALIVE(xs);
    return result;
}
static V fwp_p_reverse_copied(V xs) {
    V source = xs, result = 0;
    while (xs) {
        result = fwp_cons(OBJ(xs)->f[0], result);
        xs = OBJ(xs)->f[1];
    }
    FWP_KEEP_ALIVE(source);
    return result;
}
static V fwp_p_append_copied(V ys, V xs) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    V result = fwp_copy_finish(a, n, ys);
    FWP_KEEP_ALIVE(xs);
    FWP_KEEP_ALIVE(ys);
    return result;
}
static V fwp_p_flatten_copied(V xss) {
    size_t n;
    V *a = fwp_map_items(xss, &n);
    V result = 0;
    for (size_t i = n; i; i--) result = fwp_p_append_copied(result, a[i - 1]);
    FWP_KEEP_ALIVE(a);
    FWP_KEEP_ALIVE(xss);
    fwp_mem_free(a);
    return result;
}

static size_t fwp_count_arg(V n) { return (int64_t)n < 0 ? 0 : (size_t)(int64_t)n; }

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

static V fwp_p_take_copied(V n, V xs) {
    size_t len;
    V *a = fwp_map_items(xs, &len);
    size_t k = fwp_count_arg(n);
    V result = fwp_copy_finish(a, k < len ? k : len, 0);
    FWP_KEEP_ALIVE(xs);
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

FWP_K V fwp_k_map_owned(fwp_fn1 f, V xs) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    for (size_t i = 0; i < n; i++) a[i] = f(a[i]);
    V result = fwp_map_finish(a, n);
    FWP_KEEP_ALIVE(xs);
    return result;
}

FWP_K V fwp_k_filter(fwp_fn1 f, V xs) {
    size_t n, k = 0;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++)
        if (f(a[i]) == FWP_TRUE) a[k++] = a[i];
    return fwp_list_from(a, k);
}

FWP_K V fwp_k_filter_owned(fwp_fn1 f, void (*element_dup)(V *, uint32_t, uint32_t), V xs) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    for (size_t i = 0; i < n; i++) {
        if (f(a[i]) == FWP_TRUE) {
            element_dup(&a[i], 0, 1);
            a[k++] = a[i];
        }
    }
    V result = fwp_map_finish(a, k);
    FWP_KEEP_ALIVE(xs);
    return result;
}

FWP_K V fwp_k_take_while_owned(fwp_fn1 f, void (*element_dup)(V *, uint32_t, uint32_t), V xs) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    while (k < n && f(a[k]) == FWP_TRUE) {
        element_dup(&a[k], 0, 1);
        k++;
    }
    V result = fwp_map_finish(a, k);
    FWP_KEEP_ALIVE(xs);
    return result;
}
FWP_K V fwp_k_drop_while_owned(fwp_fn1 f, V xs) {
    V source = xs;
    while (xs && f(OBJ(xs)->f[0]) == FWP_TRUE) xs = OBJ(xs)->f[1];
    fwp_rc_dup(xs);
    FWP_KEEP_ALIVE(source);
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
    FWP_KEEP_ALIVE(source);
    return z;
}

FWP_K V fwp_k_fold_right(fwp_fn2 f, V z, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = n; i > 0; i--) z = f(a[i - 1], z);
    return z;
}

FWP_K V fwp_k_fold_right_owned(fwp_fn2 f, V z, V xs) {
    size_t n;
    V *a = fwp_map_items(xs, &n);
    for (size_t i = n; i > 0; i--) z = f(a[i - 1], z);
    FWP_KEEP_ALIVE(a);
    fwp_mem_free(a);
    FWP_KEEP_ALIVE(xs);
    return z;
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

FWP_K V fwp_k_zip_with_owned(fwp_fn2 f, V ys, V xs) {
    size_t n, m;
    V *a = fwp_map_items(xs, &n);
    V *b = fwp_map_items(ys, &m);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) a[i] = f(b[i], a[i]);
    V result = fwp_map_finish(a, k);
    FWP_KEEP_ALIVE(b);
    fwp_mem_free(b);
    FWP_KEEP_ALIVE(xs);
    FWP_KEEP_ALIVE(ys);
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

/* data-last: the subject's element is the last argument (f y x) */
static V fwp_p_zip_with(V f, V ys, V xs) {
    size_t n, m;
    V *a = fwp_list_items(xs, &n);
    V *b = fwp_list_items(ys, &m);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) a[i] = fwp_apply2(f, b[i], a[i]);
    return fwp_list_from(a, k);
}

static V fwp_p_zip_with_owned(V f, V ys, V xs) {
    size_t n, m;
    V *a = fwp_map_items(xs, &n);
    V *b = fwp_map_items(ys, &m);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) {
        V args[] = {b[i], a[i]};
        a[i] = fwp_apply_borrowed(f, 2, args);
    }
    V result = fwp_map_finish(a, k);
    FWP_KEEP_ALIVE(b);
    fwp_mem_free(b);
    FWP_KEEP_ALIVE(f);
    FWP_KEEP_ALIVE(xs);
    FWP_KEEP_ALIVE(ys);
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

static V fwp_p_repeat(V n, V x) {
    size_t k = fwp_count_arg(n);
    V r = 0;
    for (size_t i = 0; i < k; i++) r = fwp_cons(x, r);
    return r;
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
    FWP_KEEP_ALIVE(f);
    FWP_KEEP_ALIVE(source);
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
    FWP_KEEP_ALIVE(source);
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

static V fwp_p_unique_copied(V xs, const fwp_desc *d) {
    size_t n, k = 0;
    V *a = fwp_map_items(xs, &n);
    for (size_t i = 0; i < n; i++) {
        int seen = 0;
        for (size_t j = 0; j < k && !seen; j++) seen = fwp_cmp(a[j], a[i], d) == 0;
        if (!seen) a[k++] = a[i];
    }
    V result = fwp_copy_finish(a, k, 0);
    FWP_KEEP_ALIVE(xs);
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

static V fwp_p_chunks(V n, V xs) {
    if ((int64_t)n <= 0) fwp_trap("chunks: size must be positive");
    size_t k = (size_t)(int64_t)n, len;
    V *a = fwp_list_items(xs, &len);
    size_t nc = (len + k - 1) / k;
    V *cs = (V *)fwp_alloc((nc + 1) * sizeof(V));
    for (size_t c = 0; c < nc; c++) {
        size_t s = c * k, e = s + k < len ? s + k : len;
        cs[c] = fwp_list_from(a + s, e - s);
    }
    return fwp_list_from(cs, nc);
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

/* ---------------------------------------------------------------- strings */

static int fwp_is_space(char c) { return c == ' ' || c == '\t' || c == '\n' || c == '\r'; }
static int fwp_is_cont(unsigned char c) { return (c & 0xC0) == 0x80; }

static V fwp_p_trim_impl(V s, int start, int end) {
    const char *d = STR(s)->d;
    size_t a = 0, b = STR(s)->len;
    if (start) while (a < b && fwp_is_space(d[a])) a++;
    if (end) while (b > a && fwp_is_space(d[b - 1])) b--;
    return fwp_str_new(d + a, b - a);
}

static V fwp_p_case(V s, int upper) {
    V r = fwp_str_new(STR(s)->d, STR(s)->len);
    char *d = STR(r)->d;
    for (uint64_t i = 0; i < STR(r)->len; i++) {
        if (upper && d[i] >= 'a' && d[i] <= 'z') d[i] -= 32;
        if (!upper && d[i] >= 'A' && d[i] <= 'Z') d[i] += 32;
    }
    return r;
}

static V fwp_p_concat(V t, V s) {
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

static V fwp_lines_of(const char *d, size_t n) {
    size_t cap = 8, k = 0, i = 0;
    V *a = (V *)fwp_mem_alloc(cap * sizeof(V));
    while (i < n) {
        size_t j = i;
        while (j < n && d[j] != '\n') j++;
        size_t e = j;
        if (j < n && e > i && d[e - 1] == '\r') e--;
        if (k == cap) { cap *= 2; a = (V *)fwp_mem_realloc(a, cap / 2 * sizeof(V), cap * sizeof(V)); }
        a[k++] = fwp_str_new(d + i, e - i);
        i = j + 1;
    }
    V r = fwp_list_from(a, k);
    fwp_mem_free(a);
    return r;
}

static V fwp_p_lines(V s) { return fwp_lines_of(STR(s)->d, STR(s)->len); }

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
    if (STR(from)->len == 0) return s;
    fwp_buf b = {0};
    const char *d = STR(s)->d, *end = d + STR(s)->len;
    for (;;) {
        const char *p = fwp_memmem(d, (size_t)(end - d), STR(from)->d, STR(from)->len);
        if (!p) { buf_put(&b, d, (size_t)(end - d)); break; }
        buf_put(&b, d, (size_t)(p - d));
        buf_put(&b, STR(to)->d, STR(to)->len);
        d = p + STR(from)->len;
    }
    return buf_to_str(&b);
}

static V fwp_p_str_repeat(V n, V s) {
    fwp_buf b = {0};
    size_t k = fwp_count_arg(n);
    for (size_t i = 0; i < k; i++) buf_put(&b, STR(s)->d, STR(s)->len);
    return buf_to_str(&b);
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
    size_t e = st + fwp_count_arg(len);
    if (e > cnt) e = cnt;
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
static V fwp_str_lossy(const char *s, size_t n) {
    const unsigned char *d = (const unsigned char *)s;
    if (fwp_valid_utf8(d, n)) return fwp_str_new(s, n);
    fwp_buf b = {0};
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
    return buf_to_str(&b);
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

static V fwp_p_parse_int(V s, int kind, int w) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len;
    if (!fwp_valid_int(d, n)) return FWP_NONE;
    int neg = d[0] == '-';
    size_t i = (d[0] == '-' || d[0] == '+') ? 1 : 0;
    u128 mag = 0;
    for (; i < n; i++) {
        u128 next = mag * 10 + (u128)(d[i] - '0');
        if (next / 10 != mag) return FWP_NONE;
        mag = next;
    }
    V out;
    if (!fwp_int_in_range(neg, mag, kind, w, &out)) return FWP_NONE;
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
        return fwp_some(kind == K_F32 ? fwp_from_f32((float)x) : fwp_from_f64(x));
    }
    if (fwp_word_ci(d, n, "nan"))
        return fwp_some(kind == K_F32 ? fwp_from_f32(NAN) : fwp_from_f64(NAN));
    if (!fwp_valid_float(STR(s)->d, STR(s)->len)) return FWP_NONE;
    if (kind == K_F32) return fwp_some(fwp_from_f32(strtof(STR(s)->d, 0)));
    return fwp_some(fwp_from_f64(strtod(STR(s)->d, 0)));
}

static V fwp_p_format(V tmpl, V v, const fwp_desc *d) {
    V parts_small[1];
    V *parts = parts_small;
    int np;
    if (d->kind == K_RECORD && !d->name && d->n > 0) {
        np = d->n;
        parts = (V *)fwp_alloc((size_t)np * sizeof(V));
        for (int i = 0; i < np; i++) parts[i] = fwp_show(OBJ(v)->f[i], d->fields[i]);
    } else {
        np = 1;
        parts[0] = fwp_show(v, d);
    }
    const char *t = STR(tmpl)->d;
    size_t n = STR(tmpl)->len, i = 0;
    int holes = 0;
    while (i < n) {
        if (i + 1 < n && ((t[i] == '{' && t[i + 1] == '{') || (t[i] == '}' && t[i + 1] == '}'))) i += 2;
        else if (i + 1 < n && t[i] == '{' && t[i + 1] == '}') { holes++; i += 2; }
        else i++;
    }
    if (holes != np) {
        fwp_buf e = {0};
        char num[128];
        snprintf(num, sizeof num, "format: placeholder count (%d) does not match value count (%d) in \"", holes, np);
        buf_puts(&e, num);
        buf_put(&e, t, n);
        buf_putc(&e, '"');
        fwp_trap(STR(buf_to_str(&e))->d);
    }
    fwp_buf b = {0};
    i = 0;
    int next = 0;
    while (i < n) {
        if (t[i] == '{' && i + 1 < n && t[i + 1] == '{') { buf_putc(&b, '{'); i += 2; }
        else if (t[i] == '}' && i + 1 < n && t[i + 1] == '}') { buf_putc(&b, '}'); i += 2; }
        else if (t[i] == '{' && i + 1 < n && t[i + 1] == '}') {
            if (next < np) { buf_put(&b, STR(parts[next])->d, STR(parts[next])->len); next++; }
            else buf_puts(&b, "{}");
            i += 2;
        } else { buf_putc(&b, t[i]); i++; }
    }
    return buf_to_str(&b);
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
        if (u == 2) ARR(a)->len = 0; /* poisoned */
        else fwp_rc_drop(a);
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
    if (u == 2) ARR(a)->len = 0; /* poisoned */
    else fwp_rc_drop(a);
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
    size_t e = s + fwp_count_arg(len);
    if (e > n) e = n;
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

/* ------------------------------------------------------------ maps, sets */

static fwp_map fwp_empty_map = {0};
#define FWP_EMPTY_MAP PTR(&fwp_empty_map)


static V fwp_map_alloc(uint64_t len) {
    fwp_map *m = (fwp_map *)fwp_alloc(sizeof(fwp_map) + 2 * len * sizeof(V));
    m->len = len;
    return PTR(m);
}

/* a map from interleaved key/value pairs already in key order */
static V fwp_map_from_sorted(uint64_t len, const V *kv) {
    if (len == 0) return PTR(&fwp_empty_map);
    V m = fwp_map_alloc(len);
    memcpy(MAP(m)->d, kv, 2 * len * sizeof(V));
    return m;
}

/* index of key or insertion point (found flag) */
static uint64_t fwp_map_find(V m, V k, const fwp_desc *kd, int *found) {
    uint64_t lo = 0, hi = MAP(m)->len;
    /* integer keys: compared inline, without the descriptor */
    switch (kd->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64: {
        int64_t x = (int64_t)k;
        const V *d = MAP(m)->d;
        while (lo < hi) {
            uint64_t mid = (lo + hi) / 2;
            int64_t y = (int64_t)d[2 * mid];
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
            V y = d[2 * mid];
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
        int c = fwp_cmp(MAP(m)->d[2 * mid], k, kd);
        if (c == 0) { *found = 1; return mid; }
        if (c < 0) lo = mid + 1; else hi = mid;
    }
    *found = 0;
    return lo;
}

static V fwp_p_map_insert(V k, V v, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found);
    uint64_t n = MAP(m)->len;
    V r = fwp_map_alloc(found ? n : n + 1);
    if (found) {
        memcpy(MAP(r)->d, MAP(m)->d, 2 * n * sizeof(V));
        MAP(r)->d[2 * i + 1] = v;
    } else {
        memcpy(MAP(r)->d, MAP(m)->d, 2 * i * sizeof(V));
        MAP(r)->d[2 * i] = k;
        MAP(r)->d[2 * i + 1] = v;
        memcpy(MAP(r)->d + 2 * i + 2, MAP(m)->d + 2 * i, 2 * (n - i) * sizeof(V));
    }
    return r;
}

static V fwp_p_map_get(V k, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found);
    return found ? fwp_some(MAP(m)->d[2 * i + 1]) : FWP_NONE;
}

static V fwp_p_map_remove(V k, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found);
    if (!found) return m;
    uint64_t n = MAP(m)->len;
    V r = fwp_map_alloc(n - 1);
    memcpy(MAP(r)->d, MAP(m)->d, 2 * i * sizeof(V));
    memcpy(MAP(r)->d + 2 * i, MAP(m)->d + 2 * i + 2, 2 * (n - i - 1) * sizeof(V));
    return r;
}

static V fwp_p_map_contains(V k, V m, const fwp_desc *kd) {
    int found;
    fwp_map_find(m, k, kd, &found);
    return found ? FWP_TRUE : FWP_FALSE;
}

static V fwp_p_map_size(V m) { return (V)(int64_t)MAP(m)->len; }

static V fwp_p_map_column(V m, int col) {
    uint64_t n = MAP(m)->len;
    V *a = (V *)fwp_alloc((n + 1) * sizeof(V));
    for (uint64_t i = 0; i < n; i++) a[i] = MAP(m)->d[2 * i + col];
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
static V fwp_map_build(V *keys, V *vals, size_t n, const fwp_desc *kd) {
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
    V m = fwp_map_alloc(len);
    for (size_t i = 0; i < len; i++) {
        MAP(m)->d[2 * i] = tk[i];
        MAP(m)->d[2 * i + 1] = tv[i];
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
    return fwp_map_build(keys, vals, n, kd);
}

static V fwp_p_map_update(V k, V f, V d, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found);
    V cur = found ? MAP(m)->d[2 * i + 1] : d;
    return fwp_p_map_insert(k, fwp_apply1(f, cur), m, kd);
}

static V fwp_p_map_map_values(V f, V m) {
    uint64_t n = MAP(m)->len;
    V r = fwp_map_alloc(n);
    for (uint64_t i = 0; i < n; i++) {
        MAP(r)->d[2 * i] = MAP(m)->d[2 * i];
        MAP(r)->d[2 * i + 1] = fwp_apply1(f, MAP(m)->d[2 * i + 1]);
    }
    return r;
}

static V fwp_p_set_insert(V k, V s, const fwp_desc *kd) { return fwp_p_map_insert(k, 0, s, kd); }

/* `map.insert`, `map.remove`, `map.update`, `set.insert` and `set.remove`
 * given the only reference to the map (src/rc.rs): written in place when
 * it is unique, a map inserted into while unique growing by doubling;
 * else copied, and the reference given up. Results are counted. */
static V fwp_map_given_up(V m, int u, V r) {
    if (u == 2) MAP(m)->len = 0; /* poisoned (FWP_REUSE_VERIFY) */
    else fwp_rc_drop(m);
    return fwp_rc_fresh(r);
}

static V fwp_p_map_insert_own(V k, V v, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found);
    uint64_t n = MAP(m)->len;
    int u = fwp_rc_unique_mut(m);
    if (u == 1 && found) {
        MAP(m)->d[2 * i + 1] = v;
        return m;
    }
    if (u == 1 && fwp_rc_capacity(m) >= sizeof(fwp_map) + 2 * (n + 1) * sizeof(V)) {
        memmove(MAP(m)->d + 2 * i + 2, MAP(m)->d + 2 * i, 2 * (n - i) * sizeof(V));
        MAP(m)->d[2 * i] = k;
        MAP(m)->d[2 * i + 1] = v;
        MAP(m)->len = n + 1;
        return m;
    }
    if (u != 1 || found) return fwp_map_given_up(m, u, fwp_p_map_insert(k, v, m, kd));
    V r = fwp_map_alloc(n < 4 ? 4 : 2 * n);
    memcpy(MAP(r)->d, MAP(m)->d, 2 * i * sizeof(V));
    MAP(r)->d[2 * i] = k;
    MAP(r)->d[2 * i + 1] = v;
    memcpy(MAP(r)->d + 2 * i + 2, MAP(m)->d + 2 * i, 2 * (n - i) * sizeof(V));
    MAP(r)->len = n + 1;
    return fwp_map_given_up(m, u, r);
}

static V fwp_p_map_remove_own(V k, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found);
    if (!found) return m;
    uint64_t n = MAP(m)->len;
    int u = fwp_rc_unique_mut(m);
    if (u == 1) {
        memmove(MAP(m)->d + 2 * i, MAP(m)->d + 2 * i + 2, 2 * (n - i - 1) * sizeof(V));
        /* the freed pair keeps nothing alive */
        MAP(m)->d[2 * n - 2] = 0;
        MAP(m)->d[2 * n - 1] = 0;
        MAP(m)->len = n - 1;
        return m;
    }
    return fwp_map_given_up(m, u, fwp_p_map_remove(k, m, kd));
}

static V fwp_p_map_update_own(V k, V f, V d, V m, const fwp_desc *kd) {
    int found;
    uint64_t i = fwp_map_find(m, k, kd, &found);
    V cur = found ? MAP(m)->d[2 * i + 1] : d;
    return fwp_p_map_insert_own(k, fwp_apply1(f, cur), m, kd);
}

static V fwp_p_set_insert_own(V k, V s, const fwp_desc *kd) { return fwp_p_map_insert_own(k, 0, s, kd); }

static V fwp_p_set_from_list(V xs, const fwp_desc *kd) {
    size_t n;
    V *keys = fwp_list_items(xs, &n);
    V *vals = (V *)fwp_alloc((n + 1) * sizeof(V));
    return fwp_map_build(keys, vals, n, kd);
}

/* op: 0 union, 1 intersect, 2 diff; `other` is the argument, `this` the
 * subject (data-last). Both are sorted, so they are merged; a key in both
 * is this one's. */
static V fwp_p_set_op(V other, V this_, int op, const fwp_desc *kd) {
    uint64_t a = MAP(this_)->len, b = MAP(other)->len, i = 0, j = 0, n = 0;
    V *out = (V *)fwp_alloc((a + b + 1) * sizeof(V));
    while (i < a || j < b) {
        int c = i == a ? 1 : j == b ? -1 : fwp_cmp(MAP(this_)->d[2 * i], MAP(other)->d[2 * j], kd);
        if (c < 0) {
            if (op != 1) out[n++] = MAP(this_)->d[2 * i];
            i++;
        } else if (c > 0) {
            if (op == 0) out[n++] = MAP(other)->d[2 * j];
            j++;
        } else {
            if (op != 2) out[n++] = MAP(this_)->d[2 * i];
            i++;
            j++;
        }
    }
    if (n == 0) return FWP_EMPTY_MAP;
    V r = fwp_map_alloc(n);
    for (uint64_t k = 0; k < n; k++) {
        MAP(r)->d[2 * k] = out[k];
        MAP(r)->d[2 * k + 1] = 0;
    }
    return r;
}

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
    size_t e = s + fwp_count_arg(len);
    if (e > n) e = n;
    return fwp_str_new(STR(b)->d + s, e - s);
}

/* --------------------------------------------------------------------- io */

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
    char tmp[65536];
    size_t n;
    while ((n = fread(tmp, 1, sizeof tmp, stdin)) > 0) buf_put(&b, tmp, n);
    V r = fwp_str_lossy(b.d ? b.d : "", b.len);
    free(b.d);
    return r;
}

static V fwp_p_read_line(void) {
    fflush(stdout);
    fwp_buf b = {0};
    int c, any = 0;
    while ((c = fgetc(stdin)) != EOF) {
        any = 1;
        if (c == '\n') break;
        buf_putc(&b, (char)c);
    }
    if (!any) { free(b.d); return FWP_NONE; }
    if (b.len > 0 && b.d[b.len - 1] == '\r' && c == '\n') b.len--;
    V r = fwp_str_lossy(b.d ? b.d : "", b.len);
    free(b.d);
    return fwp_some(r);
}

static V fwp_p_read_lines(void) {
    V s = fwp_read_stdin_all();
    return fwp_lines_of(STR(s)->d, STR(s)->len);
}

static V fwp_p_args(void) {
    V r = 0;
    for (int i = fwp_argc - 1; i >= 1; i--) r = fwp_cons(fwp_str_lossy(fwp_argv[i], strlen(fwp_argv[i])), r);
    return r;
}

static V fwp_p_env_get(V name) {
    const char *v = getenv(STR(name)->d);
    return v ? fwp_some(fwp_str_lossy(v, strlen(v))) : FWP_NONE;
}

static struct timespec fwp_start_time;

static V fwp_duration(int64_t ns) { V f[1] = {(V)ns}; return fwp_record(1, f); }

static V fwp_p_time_monotonic(void) {
    struct timespec t;
    clock_gettime(CLOCK_MONOTONIC, &t);
    int64_t ns = (int64_t)(t.tv_sec - fwp_start_time.tv_sec) * 1000000000LL +
                 (t.tv_nsec - fwp_start_time.tv_nsec);
    return fwp_duration(ns);
}

static V fwp_p_time_unix(void) {
    struct timespec t;
    clock_gettime(CLOCK_REALTIME, &t);
    return fwp_duration((int64_t)t.tv_sec * 1000000000LL + t.tv_nsec);
}

static V fwp_p_exit(V code) {
    fflush(stdout);
    exit((int)(int32_t)code);
}

static uint64_t fwp_rng = 1;

static void fwp_seed_rng(void) {
    const char *s = getenv("FWP_SEED");
    uint64_t seed;
    char *end;
    if (s && *s && (seed = strtoull(s, &end, 10), *end == 0) && s[0] != '-' && s[0] != '+') {
        fwp_rng = seed | 1;
    } else {
        struct timespec t;
        clock_gettime(CLOCK_REALTIME, &t);
        fwp_rng = ((uint64_t)t.tv_sec * 1000000000ULL + (uint64_t)t.tv_nsec) | 1;
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
    fwp_handlers = &h;
    if (setjmp(h.jb) == 0) {
        V r = fwp_apply1(f, x);
        fwp_handlers = h.prev;
        return fwp_data(0, 1, &r);
    }
    fwp_handlers = h.prev;
    fwp_state_len = h.state_depth;
    V e = h.value;
    return fwp_data(1, 1, &e);
}

static V fwp_p_get(void) { return fwp_state_len ? fwp_state[fwp_state_len - 1] : FWP_UNIT; }

static V fwp_p_put(V s) {
    if (fwp_state_len) fwp_state[fwp_state_len - 1] = s;
    return FWP_UNIT;
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
    fwp_handlers = &h;
    if (setjmp(h.jb) == 0) {
        V r = fwp_apply1(f, x);
        fwp_handlers = h.prev;
        V st = fwp_state[--fwp_state_len];
        return fwp_tuple2(r, st);
    }
    fwp_handlers = h.prev;
    fwp_state_len = h.state_depth;
    fwp_fail(h.value, h.desc);
    return 0;
}

/* ------------------------------------------------------------------ files */

static V fwp_io_error(const char *kind, const char *msg, const fwp_desc *d) {
    V f[2] = {fwp_cstr(kind), fwp_cstr(msg)};
    fwp_fail(fwp_record(2, f), d);
    return 0;
}

static V fwp_io_error_path(const char *kind, const char *path, const fwp_desc *d) {
    char buf[1024];
    snprintf(buf, sizeof buf, "%s: %s", path, strerror(errno));
    return fwp_io_error(kind, buf, d);
}

static V fwp_file_value(FILE *f, const char *path) {
    fwp_file *h = (fwp_file *)fwp_alloc(sizeof(fwp_file));
    h->f = f;
    char *p = (char *)fwp_alloc_leaf(strlen(path) + 1);
    strcpy(p, path);
    h->path = p;
    return PTR(h);
}

static V fwp_p_file_open(V path, int create, const fwp_desc *err) {
    FILE *f = fopen(STR(path)->d, create ? "w+b" : "rb");
    if (!f) return fwp_io_error_path("open", STR(path)->d, err);
    return fwp_file_value(f, STR(path)->d);
}

static V fwp_p_file_close(V h) {
    fwp_file *f = (fwp_file *)(uintptr_t)h;
    if (f->f) { fclose(f->f); f->f = 0; }
    return FWP_UNIT;
}

static V fwp_p_file_read_all(V h, const fwp_desc *err) {
    fwp_file *f = (fwp_file *)(uintptr_t)h;
    fwp_buf b = {0};
    if (f->f) {
        char tmp[65536];
        size_t n;
        while ((n = fread(tmp, 1, sizeof tmp, f->f)) > 0) buf_put(&b, tmp, n);
        if (ferror(f->f)) { free(b.d); return fwp_io_error("read", strerror(errno), err); }
    }
    return fwp_tuple2(buf_to_str(&b), h);
}

static V fwp_p_file_write(V s, V h, const fwp_desc *err) {
    fwp_file *f = (fwp_file *)(uintptr_t)h;
    if (f->f && fwrite(STR(s)->d, 1, STR(s)->len, f->f) != STR(s)->len)
        return fwp_io_error("write", strerror(errno), err);
    return h;
}

static V fwp_p_file_with(V path, V fn, const fwp_desc *err) {
    FILE *f = fopen(STR(path)->d, "r+b");
    if (!f) f = fopen(STR(path)->d, "w+b");
    if (!f) return fwp_io_error_path("open", STR(path)->d, err);
    V h = fwp_file_value(f, STR(path)->d);
    fwp_handler hd;
    hd.prev = fwp_handlers;
    hd.state_depth = fwp_state_len;
    fwp_handlers = &hd;
    if (setjmp(hd.jb) == 0) {
        V r = fwp_apply1(fn, h);
        fwp_handlers = hd.prev;
        fwp_p_file_close(h);
        return OBJ(r)->f[0];
    }
    fwp_handlers = hd.prev;
    fwp_p_file_close(h);
    fwp_fail(hd.value, hd.desc);
    return 0;
}

static V fwp_p_file_read(V path, const fwp_desc *err) {
    FILE *f = fopen(STR(path)->d, "rb");
    if (!f) return fwp_io_error_path("read", STR(path)->d, err);
    fwp_buf b = {0};
    char tmp[65536];
    size_t n;
    while ((n = fread(tmp, 1, sizeof tmp, f)) > 0) buf_put(&b, tmp, n);
    fclose(f);
    return buf_to_str(&b);
}

static V fwp_p_file_write_new(V path, V s, const fwp_desc *err) {
    FILE *f = fopen(STR(path)->d, "wb");
    if (!f) return fwp_io_error_path("write", STR(path)->d, err);
    fwrite(STR(s)->d, 1, STR(s)->len, f);
    fclose(f);
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
    case SY_FLOAT: fwp_fmt_f64(t, fwp_f64(OBJ(v)->f[0])); buf_puts(b, t); return;
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
    sy_expr(&b, v);
    return buf_to_str(&b);
}

/* ------------------------------------------------------- linear algebra */
/* Same algorithms and operation order as src/linalg.rs. */

static double *la_get(V arr, size_t n) {
    double *d = (double *)fwp_alloc_leaf((n + 1) * sizeof(double));
    for (size_t i = 0; i < n; i++) d[i] = fwp_f64(ARR(arr)->d[i]);
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
    size_t len = ARR(arr)->len;
    if ((i128)len != (i128)rows * (i128)cols) {
        snprintf(msg, sizeof msg, "%s: %zu elements given for a %lldx%lld matrix", name, len,
                 (long long)rows, (long long)cols);
        fwp_trap(msg);
    }
}

static V la_put(const double *d, size_t n) {
    V r = fwp_arr_new(n);
    for (size_t i = 0; i < n; i++) ARR(r)->d[i] = fwp_from_f64(d[i]);
    return r;
}

static V fwp_p_lu_solve(V nv, V av, V bv) {
    la_check("linalg.lu-solve", av, (int64_t)nv, (int64_t)nv);
    la_check("linalg.lu-solve", bv, (int64_t)nv, 1);
    size_t n = (size_t)(int64_t)nv;
    double *a = la_get(av, n * n), *x = la_get(bv, n);
    for (size_t k = 0; k < n; k++) {
        size_t p = k;
        for (size_t i = k + 1; i < n; i++)
            if (fabs(a[i * n + k]) > fabs(a[p * n + k])) p = i;
        if (a[p * n + k] == 0.0) return FWP_NONE;
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
    return fwp_some(la_put(x, n));
}

static V fwp_p_det(V nv, V av) {
    la_check("linalg.det", av, (int64_t)nv, (int64_t)nv);
    size_t n = (size_t)(int64_t)nv;
    double *a = la_get(av, n * n), d = 1.0;
    for (size_t k = 0; k < n; k++) {
        size_t p = k;
        for (size_t i = k + 1; i < n; i++)
            if (fabs(a[i * n + k]) > fabs(a[p * n + k])) p = i;
        if (a[p * n + k] == 0.0) return fwp_from_f64(0.0);
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
    return fwp_from_f64(d);
}

static V fwp_p_inverse(V nv, V av) {
    la_check("linalg.inverse", av, (int64_t)nv, (int64_t)nv);
    size_t n = (size_t)(int64_t)nv;
    double *a = la_get(av, n * n);
    double *inv = (double *)fwp_alloc_leaf((n * n + 1) * sizeof(double));
    for (size_t i = 0; i < n * n; i++) inv[i] = 0.0;
    for (size_t i = 0; i < n; i++) inv[i * n + i] = 1.0;
    for (size_t k = 0; k < n; k++) {
        size_t p = k;
        for (size_t i = k + 1; i < n; i++)
            if (fabs(a[i * n + k]) > fabs(a[p * n + k])) p = i;
        if (a[p * n + k] == 0.0) return FWP_NONE;
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
    return fwp_some(la_put(inv, n * n));
}

static V fwp_p_cholesky(V nv, V av) {
    la_check("linalg.cholesky", av, (int64_t)nv, (int64_t)nv);
    size_t n = (size_t)(int64_t)nv;
    double *a = la_get(av, n * n);
    double *l = (double *)fwp_alloc_leaf((n * n + 1) * sizeof(double));
    for (size_t i = 0; i < n * n; i++) l[i] = 0.0;
    for (size_t i = 0; i < n; i++)
        for (size_t j = 0; j <= i; j++) {
            double s = a[i * n + j];
            for (size_t k = 0; k < j; k++) s -= l[i * n + k] * l[j * n + k];
            if (i == j) {
                if (s <= 0.0) return FWP_NONE;
                l[i * n + j] = sqrt(s);
            } else {
                l[i * n + j] = s / l[j * n + j];
            }
        }
    return fwp_some(la_put(l, n * n));
}

static V fwp_p_qr(V mv, V nv, V av) {
    la_check("linalg.qr", av, (int64_t)mv, (int64_t)nv);
    size_t m = (size_t)(int64_t)mv, n = (size_t)(int64_t)nv;
    double *q = la_get(av, m * n);
    double *r = (double *)fwp_alloc_leaf((n * n + 1) * sizeof(double));
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
    return fwp_tuple2(la_put(q, m * n), la_put(r, n * n));
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
    double *a = la_get(av, n * n), *r = la_get(bv, n), *p = la_get(bv, n);
    double *x = (double *)fwp_alloc_leaf((n + 1) * sizeof(double));
    double *ap = (double *)fwp_alloc_leaf((n + 1) * sizeof(double));
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
    return la_put(x, n);
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
