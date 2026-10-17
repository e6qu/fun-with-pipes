/* Count real OS descriptors and receive scratch storage. No mocked I/O. */
static fwp_socket_t udp_descriptors[16];
static size_t udp_descriptor_count;
static int udp_buffers, udp_left;
static int udp_retry_receive, udp_receive_retries;
static int udp_failure(int line) {
    fprintf(stderr, "UDP failure probe at line %d, remaining allocation %d, readiness retries %d\n",
            line, udp_left, udp_receive_retries);
    return 247;
}
static ssize_t udp_recvfrom(fwp_socket_t fd, void *data, size_t size, int flags,
                            struct sockaddr *address, socklen_t *length) {
    if (udp_retry_receive) {
        udp_retry_receive=0; udp_receive_retries++; errno=EAGAIN; return -1;
    }
    return fwp_socket_recvfrom(fd,data,size,flags,address,length);
}
static void udp_allocation(void) {
    if (udp_left > 0 && !--udp_left) fwp_trap("injected UDP allocation failure");
}
static fwp_socket_t udp_socket_open(int family, int type, int protocol) {
    fwp_socket_t fd = fwp_socket_open(family, type, protocol);
    if (fd != FWP_INVALID_SOCKET) {
        if (udp_descriptor_count == 16) abort();
        udp_descriptors[udp_descriptor_count++] = fd;
    }
    return fd;
}
static int udp_socket_close(fwp_socket_t fd) {
    size_t i;
    for (i = 0; i < udp_descriptor_count && udp_descriptors[i] != fd; i++);
    if (i == udp_descriptor_count) abort();
    int result = fwp_socket_close(fd);
    if (result) abort();
    udp_descriptors[i] = udp_descriptors[--udp_descriptor_count];
    return result;
}
static void *udp_buffer_alloc(size_t n) {
    void *p = malloc(n); if (p) udp_buffers++; return p;
}
static void udp_buffer_free(void *p) {
    if (p) { udp_buffers--; free(p); }
}
