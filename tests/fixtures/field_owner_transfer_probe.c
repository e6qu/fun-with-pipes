/* Instantiated once for each width. The counter covers only the actual call;
 * alias setup and teardown are outside it. Child release checks real storage. */
static void field_case_@width@(int direct, int shared, int same) {
    size_t baseline = fwp_heap.live;
    V children[@width@];
    for (size_t i = 0; i < @width@; i++) {
        if (same && i) {
            children[i] = children[0];
            fwp_rc_dup(children[i]);
        } else {
            children[i] = fwp_rc_fresh(fwp_cstr("field"));
        }
    }
    V box = 0;
    if (direct) {
        if (shared) for (size_t i = 0; i < @width@; i++) fwp_rc_dup(children[i]);
    } else {
        box = fwp_rc_fresh(fwp_record(@width@, children));
        if (shared) fwp_rc_dup(box);
    }
    V result = 0;
    V fields[@width@];
    field_dups = 0;
    field_active = 1;
    if (direct) {
        @result_type@ value = @worker@(@arguments@);
        @copy_fields@
    } else {
        result = @entry@(box);
        for (size_t i = 0; i < @width@; i++) fields[i] = OBJ(result)->f[i];
    }
    /* extra-field-owner-control */
    field_active = 0;
    if (field_dups != (!direct && shared ? @width@ : 0)) exit(251);
    for (size_t i = 0; i < @width@; i++) {
        if (fields[i] != children[@width@ - 1 - i]) exit(252);
        size_t owners = (same ? @width@ : 1) * (shared ? 2 : 1);
        if (*fwp_rc_slot(fields[i]) != owners) exit(252);
    }
    if (shared) {
        if (!direct) {
            if (*fwp_rc_slot(box) != 1) exit(252);
            fwp_rc_free_obj(box);
        }
        for (size_t i = 0; i < @width@; i++) field_release(children[i]);
    }
    if (result) fwp_rc_free_obj(result);
    for (size_t i = 0; i < @width@; i++) field_release(fields[i]);
    if (fwp_heap.live != baseline) exit(253);
}
