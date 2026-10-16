/* Real TCP descriptors; fail only allocation of their language-level handle. */
static fwp_socket_t tcp_live[16];
static size_t tcp_live_count;
static int tcp_fail_header, tcp_allocations_left;
static void tcp_allocation(void) {
    if(tcp_allocations_left > 0 && !--tcp_allocations_left) fwp_trap("injected TCP result allocation failure");
}
static jmp_buf tcp_jump;
static int tcp_recover(void) { return 1; }
static int tcp_failure(int line) { fprintf(stderr,"TCP failure probe at line %d\n",line); return 247; }
static void tcp_track(fwp_socket_t fd) {
    if(fd==FWP_INVALID_SOCKET) return;
    if(tcp_live_count==16) abort();
    tcp_live[tcp_live_count++]=fd;
}
static fwp_socket_t tcp_open(int family,int type,int protocol) {
    fwp_socket_t fd=fwp_socket_open(family,type,protocol); tcp_track(fd); return fd;
}
static fwp_socket_t tcp_accept(fwp_socket_t fd,struct sockaddr *address,socklen_t *length) {
    fwp_socket_t accepted=fwp_socket_accept(fd,address,length); tcp_track(accepted); return accepted;
}
static int tcp_close(fwp_socket_t fd) {
    size_t i=0; while(i<tcp_live_count&&tcp_live[i]!=fd) i++;
    if(i==tcp_live_count) abort();
    int result=fwp_socket_close(fd); if(result) abort();
    tcp_live[i]=tcp_live[--tcp_live_count]; return result;
}
static void *tcp_header_alloc(size_t bytes) {
    if(tcp_fail_header) fwp_trap("injected TCP header allocation failure");
    return fwp_alloc_leaf(bytes);
}
static void tcp_expect(size_t handles,intptr_t budget) {
    if(tcp_live_count!=handles||fwp_cleanups||fwp_gc.budget!=budget) {
        fprintf(stderr,"TCP constructor: descriptors %zu/%zu, charged bytes %lld, cleanups %d\n",
            tcp_live_count,handles,(long long)(budget-fwp_gc.budget),fwp_cleanups!=NULL);
        exit(248);
    }
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    fwp_tasks_init(); if(fwp_sockets_init()) return 246;
    V address=fwp_rc_fresh(fwp_cstr("127.0.0.1:0"));
    intptr_t baseline=fwp_gc.budget;
    for(int i=0;i<32;i++) {
        fwp_trap_recover=tcp_recover; fwp_trap_jb=&tcp_jump;
        fwp_trap_cleanup=fwp_cleanups; tcp_fail_header=1;
        if(!setjmp(tcp_jump)) { (void)fwp_p_tcp_listen(address,TCP_ERROR); return tcp_failure(__LINE__); }
        tcp_fail_header=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        tcp_expect(0,baseline);
    }
    V listener=fwp_p_tcp_listen(address,TCP_ERROR);
    for(int i=0;i<300;i++) fwp_sock_dup(listener);
    if(SOCK(listener)->refs!=301) return tcp_failure(__LINE__);
    for(int i=0;i<300;i++) fwp_sock_drop(listener);
    V duration=fwp_rc_fresh(fwp_duration(1000000000LL));
    struct sockaddr_storage bound; socklen_t length=sizeof bound;
    if(getsockname(SOCK(listener)->fd,(struct sockaddr *)&bound,&length)) return 246;
    intptr_t listening=fwp_gc.budget;
    for(int i=0;i<32;i++) {
        fwp_socket_t client=fwp_socket_open(AF_INET,SOCK_STREAM,0);
        if(client==FWP_INVALID_SOCKET||fwp_socket_connect(client,(struct sockaddr *)&bound,length)) return 246;
        fwp_trap_recover=tcp_recover; fwp_trap_jb=&tcp_jump;
        fwp_trap_cleanup=fwp_cleanups; tcp_fail_header=1;
        if(!setjmp(tcp_jump)) { (void)fwp_p_tcp_accept(listener,TCP_ERROR); return tcp_failure(__LINE__); }
        tcp_fail_header=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        tcp_expect(1,listening); fwp_socket_close(client);
    }
    /* The optional wrapper may fail after accept has already acquired a handle. */
    for(int i=0;i<8;i++) {
        fwp_socket_t peer=fwp_socket_open(AF_INET,SOCK_STREAM,0);
        if(peer==FWP_INVALID_SOCKET||fwp_socket_connect(peer,(struct sockaddr *)&bound,length)) return 246;
        fwp_trap_recover=tcp_recover; fwp_trap_jb=&tcp_jump;
        fwp_trap_cleanup=fwp_cleanups; tcp_allocations_left=2;
        if(!setjmp(tcp_jump)) { (void)fwp_p_tcp_accept_for(duration,listener,TCP_ERROR); return tcp_failure(__LINE__); }
        tcp_allocations_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        tcp_expect(1,listening); fwp_socket_close(peer);
    }
    /* Successful construction still transfers the descriptor to the handle. */
    fwp_socket_t client=fwp_socket_open(AF_INET,SOCK_STREAM,0);
    if(client==FWP_INVALID_SOCKET||fwp_socket_connect(client,(struct sockaddr *)&bound,length)) return 246;
    V accepted=fwp_p_tcp_accept(listener,TCP_ERROR);
    if(tcp_live_count!=2||fwp_cleanups||SOCK(accepted)->fd==FWP_INVALID_SOCKET) return tcp_failure(__LINE__);
    intptr_t connected=fwp_gc.budget;
    for(int failure=1;failure<=2;failure++) {
        if(fwp_socket_send(client,"a\0b",3,0)!=3) return 246;
        fwp_trap_recover=tcp_recover; fwp_trap_jb=&tcp_jump;
        fwp_trap_cleanup=fwp_cleanups; tcp_allocations_left=failure;
        if(!setjmp(tcp_jump)) { (void)fwp_p_tcp_read_for(duration,64,accepted,TCP_ERROR); return tcp_failure(__LINE__); }
        tcp_allocations_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        tcp_expect(2,connected);
    }
    fwp_sock_drop(accepted);
    fwp_socket_close(client);
    fwp_sock_drop(listener);
    fwp_rc_free_obj(duration); tcp_expect(0,baseline); fwp_rc_free_obj(address);
    puts("TCP: 32 failed listener constructions, 32 failed accepted connections, optional-accept/read failures and 301 aliases; descriptors and temporary storage released");
    return 0;
}
