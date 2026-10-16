struct udp_previous_header { fwp_socket_t fd; int kind; void *tls; };
_Static_assert(sizeof(fwp_sock)==sizeof(struct udp_previous_header), "UDP counting must not enlarge socket headers");
_Static_assert(offsetof(fwp_sock,refs)==offsetof(fwp_sock,tls), "disjoint socket kinds share payload storage");
_Static_assert(offsetof(fwp_sock,refs)%_Alignof(uint64_t)==0, "UDP owners must be aligned");
static jmp_buf udp_jump;
static int udp_recover(void) { return 1; }
static void udp_expect_clean(intptr_t budget, size_t descriptors) {
    if (fwp_cleanups || udp_buffers || udp_descriptor_count != descriptors || fwp_gc.budget != budget) {
        fprintf(stderr, "UDP owners: descriptors %zu/%zu, buffers %d, charged bytes %lld, cleanup %d\n",
                udp_descriptor_count, descriptors, udp_buffers,
                (long long)(budget-fwp_gc.budget), fwp_cleanups != NULL);
        exit(248);
    }
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    fwp_tasks_init();
    if (fwp_sockets_init()) return 246;
    intptr_t initial_budget=fwp_gc.budget;
    V address=fwp_rc_fresh(fwp_cstr("127.0.0.1:0"));
    intptr_t budget=fwp_gc.budget;
    fwp_trap_recover=udp_recover; fwp_trap_jb=&udp_jump;
    fwp_trap_cleanup=fwp_cleanups; udp_left=1;
    if (!setjmp(udp_jump)) { (void)fwp_p_udp_bind(address, UDP_ERROR); return 247; }
    udp_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
    udp_expect_clean(budget, 0);
    for (int i=0;i<4096;i++) {
        V handle=fwp_p_udp_bind(address, UDP_ERROR);
        if (udp_descriptor_count!=1 || SOCK(handle)->refs!=1) return 247;
        fwp_udp_drop(handle);
        udp_expect_clean(budget, 0);
    }
    V handle=fwp_p_udp_bind(address, UDP_ERROR);
    for (int i=0;i<300;i++) fwp_udp_dup(handle);
    if (SOCK(handle)->refs!=301) return 247;
    for (int i=0;i<300;i++) fwp_udp_drop(handle);
    if (udp_descriptor_count!=1 || SOCK(handle)->refs!=1) return 247;
    fwp_udp_dup(handle);
    fwp_p_sock_close(handle);
    if (udp_descriptor_count || SOCK(handle)->fd!=FWP_INVALID_SOCKET) return 247;
    fwp_udp_drop(handle); fwp_udp_drop(handle);
    udp_expect_clean(budget, 0);
    handle=fwp_p_udp_bind(address, UDP_ERROR);
    V target=fwp_rc_fresh(fwp_p_local_addr(handle));
    V data=fwp_rc_fresh(fwp_str_new("a\0b",3));
    intptr_t receive_budget=fwp_gc.budget;
    int failures=0;
    for (int allocation=1;allocation<=4;allocation++) {
        fwp_p_udp_send_to(target,data,handle,UDP_ERROR);
        fwp_trap_recover=udp_recover; fwp_trap_jb=&udp_jump;
        fwp_trap_cleanup=fwp_cleanups; udp_left=allocation;
        if (!setjmp(udp_jump)) {
            V result=fwp_p_udp_recv_from(64,handle,UDP_ERROR,UDP_TUPLE);
            udp_left=0;
            V bytes=OBJ(result)->f[0], peer=OBJ(result)->f[1];
            if (allocation!=4 || STR(bytes)->len!=3 || memcmp(STR(bytes)->d,"a\0b",3)
                    || STR(peer)->len!=STR(target)->len || memcmp(STR(peer)->d,STR(target)->d,STR(target)->len)) return 247;
            UDP_TUPLE->drop(result);
        } else failures++;
        udp_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        udp_expect_clean(receive_budget, 1);
    }
    if (failures!=3) return 247;
    fwp_rc_free_obj(data); fwp_rc_free_obj(target); fwp_udp_drop(handle);
    udp_expect_clean(budget, 0);
    fwp_rc_free_obj(address);
    udp_expect_clean(initial_budget, 0);
    if (fwp_gc.nfins) return 248;
    puts("UDP: 4096 bind/drop cycles, 301 aliases, constructor and all 3 receive failures; final descriptors/buffers/managed storage 0");
    return 0;
}
