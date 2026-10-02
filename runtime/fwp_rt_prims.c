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

static V fwp_p_filter(V f, V xs) {
    size_t n, k = 0;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = 0; i < n; i++)
        if (fwp_apply1(f, a[i]) == FWP_TRUE) a[k++] = a[i];
    return fwp_list_from(a, k);
}

static V fwp_p_fold(V f, V z, V xs) {
    while (xs != 0) { z = fwp_apply2(f, z, OBJ(xs)->f[0]); xs = OBJ(xs)->f[1]; }
    return z;
}

static V fwp_p_fold_right(V f, V z, V xs) {
    size_t n;
    V *a = fwp_list_items(xs, &n);
    for (size_t i = n; i > 0; i--) z = fwp_apply2(f, a[i - 1], z);
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
    return r;
}

static V fwp_p_flatten(V xss) {
    size_t n;
    V *a = fwp_list_items(xss, &n);
    V r = 0;
    for (size_t i = n; i > 0; i--) r = fwp_p_append(r, a[i - 1]);
    return r;
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

static V fwp_p_zip(V ys, V xs) {
    size_t n, m;
    V *a = fwp_list_items(xs, &n);
    V *b = fwp_list_items(ys, &m);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) a[i] = fwp_tuple2(a[i], b[i]);
    return fwp_list_from(a, k);
}

static V fwp_p_zip_with(V f, V ys, V xs) {
    size_t n, m;
    V *a = fwp_list_items(xs, &n);
    V *b = fwp_list_items(ys, &m);
    size_t k = n < m ? n : m;
    for (size_t i = 0; i < k; i++) a[i] = fwp_apply2(f, a[i], b[i]);
    return fwp_list_from(a, k);
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
    fwp_str *r = (fwp_str *)fwp_alloc(sizeof(fwp_str) + STR(s)->len + STR(t)->len + 1);
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
    V *a = (V *)fwp_alloc((cnt + 1) * sizeof(V));
    while (i < n) {
        size_t j = i + 1;
        while (j < n && fwp_is_cont((unsigned char)d[j])) j++;
        a[k++] = fwp_str_new(d + i, j - i);
        i = j;
    }
    return fwp_list_from(a, k);
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
    V *a = (V *)malloc(cap * sizeof(V));
    for (;;) {
        const char *p = fwp_memmem(d, (size_t)(end - d), STR(sep)->d, STR(sep)->len);
        if (k == cap) { cap *= 2; a = (V *)realloc(a, cap * sizeof(V)); }
        if (!p) { a[k++] = fwp_str_new(d, (size_t)(end - d)); break; }
        a[k++] = fwp_str_new(d, (size_t)(p - d));
        d = p + STR(sep)->len;
    }
    V r = fwp_list_from(a, k);
    free(a);
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
    V *a = (V *)malloc(cap * sizeof(V));
    while (i < n) {
        size_t j = i;
        while (j < n && d[j] != '\n') j++;
        size_t e = j;
        if (j < n && e > i && d[e - 1] == '\r') e--;
        if (k == cap) { cap *= 2; a = (V *)realloc(a, cap * sizeof(V)); }
        a[k++] = fwp_str_new(d + i, e - i);
        i = j + 1;
    }
    V r = fwp_list_from(a, k);
    free(a);
    return r;
}

static V fwp_p_lines(V s) { return fwp_lines_of(STR(s)->d, STR(s)->len); }

static V fwp_p_words(V s) {
    const char *d = STR(s)->d;
    size_t n = STR(s)->len, i = 0, cap = 8, k = 0;
    V *a = (V *)malloc(cap * sizeof(V));
    while (i < n) {
        while (i < n && fwp_is_space(d[i])) i++;
        size_t j = i;
        while (j < n && !fwp_is_space(d[j])) j++;
        if (j > i) {
            if (k == cap) { cap *= 2; a = (V *)realloc(a, cap * sizeof(V)); }
            a[k++] = fwp_str_new(d + i, j - i);
        }
        i = j;
    }
    V r = fwp_list_from(a, k);
    free(a);
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
    fwp_str *r = (fwp_str *)fwp_alloc(sizeof(fwp_str) + n + 1);
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
    V *a = (V *)fwp_alloc((n + 1) * sizeof(V));
    while (i < n) a[k++] = fwp_utf8_next(d, &i);
    return fwp_list_from(a, k);
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

static V fwp_p_parse_float(V s, int kind) {
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
    fwp_buf b = {0};
    const char *t = STR(tmpl)->d;
    size_t n = STR(tmpl)->len, i = 0;
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

/* index of key or insertion point (found flag) */
static uint64_t fwp_map_find(V m, V k, const fwp_desc *kd, int *found) {
    uint64_t lo = 0, hi = MAP(m)->len;
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

static V fwp_p_map_from_list(V xs, const fwp_desc *kd) {
    V m = FWP_EMPTY_MAP;
    for (; xs != 0; xs = OBJ(xs)->f[1]) {
        V p = OBJ(xs)->f[0];
        m = fwp_p_map_insert(OBJ(p)->f[0], OBJ(p)->f[1], m, kd);
    }
    return m;
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

static V fwp_p_set_from_list(V xs, const fwp_desc *kd) {
    V m = FWP_EMPTY_MAP;
    for (; xs != 0; xs = OBJ(xs)->f[1]) m = fwp_p_map_insert(OBJ(xs)->f[0], 0, m, kd);
    return m;
}

/* op: 0 union, 1 intersect, 2 diff; `other` is the argument, `this` the
 * subject (data-last). */
static V fwp_p_set_op(V other, V this_, int op, const fwp_desc *kd) {
    V r = FWP_EMPTY_MAP;
    for (uint64_t i = 0; i < MAP(this_)->len; i++) {
        V k = MAP(this_)->d[2 * i];
        int in_other;
        fwp_map_find(other, k, kd, &in_other);
        if (op == 0 || (op == 1 && in_other) || (op == 2 && !in_other))
            r = fwp_p_map_insert(k, 0, r, kd);
    }
    if (op == 0)
        for (uint64_t i = 0; i < MAP(other)->len; i++) r = fwp_p_map_insert(MAP(other)->d[2 * i], 0, r, kd);
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
    V *a = (V *)fwp_alloc((n + 1) * sizeof(V));
    for (size_t i = 0; i < n; i++) a[i] = (V)(unsigned char)STR(b)->d[i];
    return fwp_list_from(a, n);
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
    fwrite(STR(s)->d, 1, STR(s)->len, stdout);
    fputc('\n', stdout);
    return FWP_UNIT;
}

static V fwp_p_write(V s) {
    fwrite(STR(s)->d, 1, STR(s)->len, stdout);
    return FWP_UNIT;
}

static V fwp_p_eprint(V s) {
    fflush(stdout);
    fwrite(STR(s)->d, 1, STR(s)->len, stderr);
    fputc('\n', stderr);
    return FWP_UNIT;
}

static V fwp_read_stdin_all(void) {
    fflush(stdout);
    fwp_buf b = {0};
    char tmp[65536];
    size_t n;
    while ((n = fread(tmp, 1, sizeof tmp, stdin)) > 0) buf_put(&b, tmp, n);
    return buf_to_str(&b);
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
    return fwp_some(buf_to_str(&b));
}

static V fwp_p_read_lines(void) {
    V s = fwp_read_stdin_all();
    return fwp_lines_of(STR(s)->d, STR(s)->len);
}

static V fwp_p_args(void) {
    V r = 0;
    for (int i = fwp_argc - 1; i >= 1; i--) r = fwp_cons(fwp_cstr(fwp_argv[i]), r);
    return r;
}

static V fwp_p_env_get(V name) {
    const char *v = getenv(STR(name)->d);
    return v ? fwp_some(fwp_cstr(v)) : FWP_NONE;
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
    char *p = (char *)fwp_alloc(strlen(path) + 1);
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
