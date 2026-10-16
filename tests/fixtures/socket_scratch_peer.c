/* Deterministic socket outcomes exercise the real runtime cleanup stack. */
static int socket_mode, socket_native_live, socket_resolver_live, socket_inject;
static void socket_managed_allocation(void) {
    if(socket_inject && socket_mode==1) fwp_trap("injected receive result failure");
}
static void *socket_native_alloc(size_t n) {
    if(socket_mode==2) return NULL;
    void *p=malloc(n); if(!p) abort(); socket_native_live++; return p;
}
static void socket_native_free(void *p) { if(p) { free(p); socket_native_live--; } }
static ssize_t socket_receive(fwp_socket_t fd, void *buf, size_t n, int flags) {
    (void)fd; (void)flags;
    if(socket_mode==1) { if(!n) abort(); ((char *)buf)[0]='x'; return 1; }
    errno=EAGAIN; return -1;
}
static ssize_t socket_receive_from(fwp_socket_t fd, void *buf, size_t n, int flags,
                                  struct sockaddr *addr, socklen_t *len) {
    struct sockaddr_in value={0}; value.sin_family=AF_INET;
    value.sin_addr.s_addr=htonl(INADDR_LOOPBACK); value.sin_port=htons(1234);
    memcpy(addr,&value,sizeof value); *len=sizeof value;
    return socket_receive(fd,buf,n,flags);
}
static ssize_t socket_send_to(fwp_socket_t fd, const void *buf, size_t n, int flags,
                             const struct sockaddr *addr, socklen_t len) {
    (void)fd;(void)buf;(void)n;(void)flags;(void)addr;(void)len;
    errno=EAGAIN; return -1;
}
static int socket_wait(fwp_socket_t fd, int write, int64_t at) {
    (void)fd;(void)write;(void)at;
    if(socket_mode==3) return 0;
    fwp_trap("injected socket wait cancellation"); return 0;
}
static struct addrinfo *socket_resolve(V address, int kind, int passive,
                                      const char *operation, const fwp_desc *error) {
    struct addrinfo *result=fwp_resolve(address,kind,passive,operation,error);
    if(!result) abort(); socket_resolver_live++; return result;
}
static void socket_resolver_free(struct addrinfo *result) {
    freeaddrinfo(result); socket_resolver_live--;
}
