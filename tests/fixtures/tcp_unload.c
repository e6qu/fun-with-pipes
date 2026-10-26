/* All three descriptors must remain live until this library unloads. */
#ifdef _WIN32
__declspec(dllexport)
#endif
void setup(uintptr_t *descriptors) {
    fwp_lib_init(); fwp_tasks_init();
    size_t live_bytes=fwp_heap.live;
    for(int i=0;i<32;i++) if(!probe(i)) exit(247);
    if(fwp_heap.ncollect || fwp_heap.enabled) exit(248);
#ifndef FWP_ARC_ONLY
    if(!fwp_reuse_verify)
#endif
    if(fwp_heap.live > live_bytes) exit(248);
    V address=fwp_rc_fresh(fwp_cstr("127.0.0.1:0"));
    V listener=fwp_p_tcp_listen(address,NULL);
    V target=fwp_rc_fresh(fwp_p_local_addr(listener));
    V client=fwp_p_tcp_connect(target,NULL);
    V accepted=fwp_p_tcp_accept(listener,NULL);
    descriptors[0]=(uintptr_t)SOCK(listener)->fd;
    descriptors[1]=(uintptr_t)SOCK(client)->fd;
    descriptors[2]=(uintptr_t)SOCK(accepted)->fd;
    fwp_rc_free_obj(target); fwp_rc_free_obj(address);
}
