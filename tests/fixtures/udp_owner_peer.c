/* Count real OS descriptors and receive scratch storage. No mocked I/O. */
static fwp_socket_t udp_descriptors[16];
static size_t udp_descriptor_count;
static int udp_buffers, udp_left;
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
