/* Partial decoder values are typed owners. Small field vectors stay on the
 * C stack; larger vectors use scanned scratch so tracing sees pending values.
 * The same cleanup record handles ordinary parse failure and nonlocal exit. */
typedef struct {
    V local[8], *values;
    size_t count, types;
    const fwp_desc *const *descs;
    const fwp_desc *element;
    V aggregate;
    const fwp_desc *aggregate_type;
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
    if (!f->transferred && f->aggregate_type && f->aggregate_type->drop)
        f->aggregate_type->drop(f->aggregate);
    f->aggregate = 0;
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

/* Snapshots copy process-owned metric names into an immutable owned list. */
static V fwp_p_metrics_snapshot(const fwp_desc *list_type) {
    if (fwp_nmetrics > 1)
        qsort(fwp_metrics, fwp_nmetrics, sizeof(fwp_metric), fwp_metric_cmp);
    fwp_value_owner list = {0, list_type->drop};
    fwp_cleanup cleanup; fwp_value_protect(&list, &cleanup);
    for (size_t i = fwp_nmetrics; i > 0; i--) {
        const fwp_metric *m = &fwp_metrics[i - 1];
        fwp_decode_fields fields;
        fwp_decode_fields_begin(&fields, 3, list_type->elem->fields, 3, NULL);
        fields.values[0] = fwp_rc_fresh(fwp_str_new(m->name, m->len));
        fields.values[1] = fwp_rc_fresh(fwp_cstr(m->kind));
        fields.values[2] = fwp_from_f64(m->x);
        fwp_value_owner tuple = {fwp_decode_record(&fields), list_type->elem->drop};
        fwp_cleanup tuple_cleanup; fwp_value_protect(&tuple, &tuple_cleanup);
        list.value = fwp_rc_fresh(fwp_cons(tuple.value, list.value));
        fwp_value_finish(&tuple, &tuple_cleanup);
    }
    return fwp_value_finish(&list, &cleanup);
}

#ifndef FWP_FIBERS
static V fwp_p_udp_recv_from(V nv, V s, const fwp_desc *err, const fwp_desc *tuple_type) {
    int64_t n = (int64_t)nv;
    if (n < 1) n = 1;
    char *buf = (char *)malloc((size_t)n);
    if (!buf) fwp_trap("socket receive allocation failed");
    fwp_cleanup buffer_cleanup;
    fwp_cleanup_push(&buffer_cleanup, free, buf);
    for (;;) {
        fwp_socket_t fd = SOCK(s)->fd;
        if (fd == FWP_INVALID_SOCKET) { fwp_cleanup_pop(&buffer_cleanup); free(buf); return fwp_closed_error("socket", err); }
        struct sockaddr_storage ss;
        socklen_t len = sizeof ss;
        ssize_t k = fwp_socket_recvfrom(fd, buf, (size_t)n, 0, (struct sockaddr *)&ss, &len);
        if (k >= 0) {
            char a[128];
            fwp_fmt_addr((struct sockaddr *)&ss, a, sizeof a);
            fwp_decode_fields fields;
            fwp_decode_fields_begin(&fields, 2, tuple_type->fields, 2, NULL);
            fields.values[0] = fwp_rc_fresh(fwp_str_new(buf, (size_t)k));
            fields.values[1] = fwp_rc_fresh(fwp_cstr(a));
            V r = fwp_decode_record(&fields);
            fwp_cleanup_pop(&buffer_cleanup); free(buf);
            FWP_KEEP_ALIVE(s);
            return r;
        }
        if (fwp_socket_again(errno)) {
            fwp_wait_fd(fd, 0, 0);
            continue;
        }
        fwp_cleanup_pop(&buffer_cleanup); free(buf);
        return fwp_os_error("receive", 0, err);
    }
}


/* Resolver entries are temporary native storage; returned strings/list cells
 * have independent owners. Preserve first occurrence order without a fixed cap. */
static V fwp_p_dns_resolve(V host, const fwp_desc *err, const fwp_desc *list_type) {
    fwp_check_cancel();
    if (memchr(STR(host)->d, 0, STR(host)->len))
        return fwp_io_error("resolve", "hostname contains a NUL byte", err);
    if (fwp_sockets_init()) return fwp_os_error("resolve", STR(host)->d, err);
    struct addrinfo hints, *addresses = NULL;
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    int status = getaddrinfo(STR(host)->d, NULL, &hints, &addresses);
    if (status) {
        char message[512];
        snprintf(message, sizeof message, "%s: failed to lookup address information: %s",
                 STR(host)->d, gai_strerror(status));
        return fwp_io_error("resolve", message, err);
    }
    fwp_cleanup address_cleanup;
    fwp_cleanup_push(&address_cleanup, fwp_addrinfo_release, &addresses);
    fwp_value_owner list = {0, list_type->drop};
    fwp_cleanup list_cleanup; fwp_value_protect(&list, &list_cleanup);
    for (const struct addrinfo *ai = addresses; ai; ai = ai->ai_next) {
        const void *address;
        if (ai->ai_family == AF_INET)
            address = &((const struct sockaddr_in *)ai->ai_addr)->sin_addr;
        else if (ai->ai_family == AF_INET6)
            address = &((const struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
        else continue;
        char ip[INET6_ADDRSTRLEN];
        if (!inet_ntop(ai->ai_family, address, ip, sizeof ip))
            return fwp_os_error("resolve", STR(host)->d, err);
        size_t length = strlen(ip);
        int duplicate = 0;
        for (V prior = list.value; prior; prior = OBJ(prior)->f[1]) {
            V text = OBJ(prior)->f[0];
            if (STR(text)->len == length && !memcmp(STR(text)->d, ip, length)) {
                duplicate = 1; break;
            }
        }
        if (duplicate) continue;
        fwp_value_owner text = {fwp_rc_fresh(fwp_str_new(ip, length)), list_type->elem->drop};
        fwp_cleanup text_cleanup; fwp_value_protect(&text, &text_cleanup);
        list.value = fwp_private_cons_owned(text.value, list.value);
        fwp_value_finish(&text, &text_cleanup);
    }
    list.value = fwp_private_reverse_owned(list.value);
    V result = fwp_value_finish(&list, &list_cleanup);
    fwp_cleanup_pop(&address_cleanup); fwp_addrinfo_release(&addresses);
    FWP_KEEP_ALIVE(host);
    return result;
}
#endif


static V fwp_decode_sequence(fwp_decode_fields *f, const fwp_desc *d) {
    if (f->aggregate_type) {
        V result = f->aggregate;
        fwp_decode_fields_end(f, 1);
        return result;
    }
    fwp_value_owner owner = {0, d->drop};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_value_release, &owner);
    if (d->kind == K_ARRAY) {
        owner.value = fwp_rc_fresh(fwp_array_new_packed(f->count, d->elem));
        fwp_array_set_len(owner.value, 0);
        for (size_t i = 0; i < f->count; i++) {
            fwp_array_store_owned(owner.value, i, f->values[i], d->elem);
            fwp_array_set_len(owner.value, i + 1);
            f->values[i] = 0;
        }
    } else {
        for (size_t i = f->count; i > 0; i--) {
            owner.value = fwp_rc_fresh(fwp_cons(f->values[i - 1], owner.value));
            f->values[i - 1] = 0;
        }
    }
    fwp_cleanup_pop(&cleanup);
    V result = owner.value;
    owner.value = 0;
    fwp_decode_fields_end(f, 1);
    return result;
}

/* A decoder owns its map exclusively. Insertion retains borrowed fields and
 * consumes the previous map; the field vector drops discarded duplicate keys. */
static V fwp_decode_map(fwp_decode_fields *f, const fwp_desc *d) {
    size_t stride = d->kind == K_SET ? 1 : 2;
    fwp_map_ops ops = {d->elem->dup, d->elem2 ? d->elem2->dup : NULL,
        d->elem->drop, d->elem2 ? d->elem2->drop : NULL, d->drop ? d->drop : fwp_rc_drop, NULL, stride};
    fwp_value_owner owner = {FWP_EMPTY_MAP, d->drop};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_value_release, &owner);
    for (size_t i = 0; i < f->count; i += stride) {
        V previous = owner.value;
        owner.value = 0; /* insertion takes this owner, including on unwind */
        owner.value = fwp_p_map_insert_typed(f->values[i], stride == 1 ? 0 : f->values[i + 1], previous, &ops, d->elem);
    }
    fwp_cleanup_pop(&cleanup);
    V result = owner.value;
    owner.value = 0;
    fwp_decode_fields_end(f, 0);
    return result;
}
