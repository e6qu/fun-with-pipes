struct udp_previous_header { fwp_socket_t fd; int kind; void *tls; };
_Static_assert(sizeof(fwp_sock)==sizeof(struct udp_previous_header), "UDP counting must not enlarge socket headers");
_Static_assert(offsetof(fwp_sock,refs)%_Alignof(uint64_t)==0, "UDP owners must be aligned");
static jmp_buf udp_jump;
static int udp_recover(void) { return 1; }
static void udp_expect_clean(intptr_t live_bytes, size_t descriptors) {
    if (fwp_cleanups || udp_buffers || udp_descriptor_count != descriptors || fwp_heap.live != live_bytes) {
        fprintf(stderr, "UDP owners: descriptors %zu/%zu, buffers %d, charged bytes %lld, cleanup %d\n",
                udp_descriptor_count, descriptors, udp_buffers,
                (long long)(fwp_heap.live - live_bytes), fwp_cleanups != NULL);
        exit(248);
    }
}
int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    fwp_tasks_init();
    if (fwp_sockets_init()) return 246;
    size_t initial_live_bytes=fwp_heap.live;
    V address=fwp_rc_fresh(fwp_cstr("127.0.0.1:0"));
    size_t live_bytes=fwp_heap.live;
    fwp_trap_recover=udp_recover; fwp_trap_jb=&udp_jump;
    fwp_trap_cleanup=fwp_cleanups; udp_left=1;
    if (!setjmp(udp_jump)) { (void)fwp_p_udp_bind(address, UDP_ERROR); return udp_failure(__LINE__); }
    udp_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
    udp_expect_clean(live_bytes, 0);
    for (int i=0;i<4096;i++) {
        V handle=fwp_p_udp_bind(address, UDP_ERROR);
        if (udp_descriptor_count!=1 || SOCK(handle)->refs!=1) return udp_failure(__LINE__);
        fwp_sock_drop(handle);
        udp_expect_clean(live_bytes, 0);
    }
    V handle=fwp_p_udp_bind(address, UDP_ERROR);
    for (int i=0;i<300;i++) fwp_sock_dup(handle);
    if (SOCK(handle)->refs!=301) return udp_failure(__LINE__);
    for (int i=0;i<300;i++) fwp_sock_drop(handle);
    if (udp_descriptor_count!=1 || SOCK(handle)->refs!=1) return udp_failure(__LINE__);
    fwp_sock_dup(handle);
    fwp_p_sock_close(handle);
    if (udp_descriptor_count || SOCK(handle)->fd!=FWP_INVALID_SOCKET) return udp_failure(__LINE__);
    fwp_sock_drop(handle); fwp_sock_drop(handle);
    udp_expect_clean(live_bytes, 0);
    handle=fwp_p_udp_bind(address, UDP_ERROR);
    V target=fwp_rc_fresh(fwp_p_local_addr(handle));
    V data=fwp_rc_fresh(fwp_str_new("a\0b",3));
    /* Establish persistent descriptor bookkeeping before the measured interval.
     * Every receive also exercises a readiness retry with a real queued packet. */
    fwp_p_udp_send_to(target,data,handle,UDP_ERROR); udp_retry_receive=1;
    V warmup=fwp_p_udp_recv_from(64,handle,UDP_ERROR,UDP_TUPLE); UDP_TUPLE->drop(warmup);
    size_t receive_live_bytes=fwp_heap.live;
    int failures=0;
    for (int allocation=1;allocation<=4;allocation++) {
        fwp_p_udp_send_to(target,data,handle,UDP_ERROR);
        udp_retry_receive=1;
        fwp_trap_recover=udp_recover; fwp_trap_jb=&udp_jump;
        fwp_trap_cleanup=fwp_cleanups; udp_left=allocation;
        if (!setjmp(udp_jump)) {
            V result=fwp_p_udp_recv_from(64,handle,UDP_ERROR,UDP_TUPLE);
            udp_left=0;
            V bytes=OBJ(result)->f[0], peer=OBJ(result)->f[1];
            if (allocation!=4 || STR(bytes)->len!=3 || memcmp(STR(bytes)->d,"a\0b",3)
                    || STR(peer)->len!=STR(target)->len || memcmp(STR(peer)->d,STR(target)->d,STR(target)->len)) return udp_failure(__LINE__);
            UDP_TUPLE->drop(result);
        } else failures++;
        udp_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        udp_expect_clean(receive_live_bytes, 1);
    }
    if (failures!=3) {
        fprintf(stderr,"expected 3 receive failures, got %d\n",failures);
        return udp_failure(__LINE__);
    }
    if (udp_retry_receive || udp_receive_retries!=5) return udp_failure(__LINE__);
    fwp_rc_free_obj(data); fwp_rc_free_obj(target); fwp_sock_drop(handle);
    udp_expect_clean(live_bytes, 0);
    fwp_rc_free_obj(address);
    udp_expect_clean(initial_live_bytes, 0);
    if (fwp_heap.nfins) return 248;
    puts("UDP: 4096 bind/drop cycles, 301 aliases, constructor and all 3 receive failures; final descriptors/buffers/managed storage 0");
    return 0;
}
