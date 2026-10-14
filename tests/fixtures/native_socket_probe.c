#ifdef _WIN32
#define _WIN32_WINNT 0x0a00
#endif
#include <stdio.h>
#include <string.h>
/* SOCKET_RUNTIME */
#define CHECK(condition, code) do { if (!(condition)) { fprintf(stderr, "probe %d: errno %d\n", code, errno); return code; } } while (0)
#ifdef _WIN32
_Static_assert(sizeof(fwp_socket_t) == sizeof(SOCKET), "full-width socket handle");
_Static_assert(sizeof(fwp_socket_t) == sizeof(void *), "native handle width");
#endif

int main(void) {
    for (int iteration = 0; iteration < 8; iteration++) {
        CHECK(fwp_sockets_init() == 0 && fwp_sockets_init() == 0, 10);
        fwp_socket_t listener = fwp_socket_open(AF_INET, SOCK_STREAM, 0);
        CHECK(listener != FWP_INVALID_SOCKET, 11);
        struct sockaddr_in address = {0};
        address.sin_family = AF_INET;
        address.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
        CHECK(fwp_socket_bind(listener, (struct sockaddr *)&address, sizeof address) == 0, 12);
        CHECK(fwp_socket_listen(listener, 4) == 0, 13);
        socklen_t length = sizeof address;
        CHECK(getsockname(listener, (struct sockaddr *)&address, &length) == 0, 14);
        fwp_socket_t client = fwp_socket_open(AF_INET, SOCK_STREAM, 0);
        CHECK(client != FWP_INVALID_SOCKET && fwp_socket_nonblock(client) == 0, 15);
        int connected = fwp_socket_connect(client, (struct sockaddr *)&address, sizeof address);
        CHECK(connected == 0 || fwp_socket_pending(errno), 16);
#ifdef _WIN32
        WSAPOLLFD waiting = {client, POLLWRNORM, 0};
        CHECK(WSAPoll(&waiting, 1, 5000) == 1, 17);
#else
        struct pollfd waiting = {client, POLLOUT, 0};
        CHECK(poll(&waiting, 1, 5000) == 1, 17);
#endif
        CHECK(fwp_socket_connect_error(client) == 0, 18);
        fwp_socket_t server = fwp_socket_accept(listener, NULL, NULL);
        CHECK(server != FWP_INVALID_SOCKET && fwp_socket_nonblock(server) == 0, 19);
#ifdef _WIN32
        DWORD flags;
        CHECK(GetHandleInformation((HANDLE)listener, &flags) && !(flags & HANDLE_FLAG_INHERIT), 20);
        CHECK(GetHandleInformation((HANDLE)server, &flags) && !(flags & HANDLE_FLAG_INHERIT), 21);
#endif
        char buffer[64];
        CHECK(fwp_socket_recv(server, buffer, sizeof buffer, 0) < 0 && fwp_socket_again(errno), 22);
        const char payload[] = {'a', '\0', '\r', '\n', (char)0xff};
        CHECK(fwp_socket_send(client, payload, sizeof payload, 0) == sizeof payload, 23);
#ifdef _WIN32
        waiting.fd = server; waiting.events = POLLRDNORM;
        CHECK(WSAPoll(&waiting, 1, 5000) == 1, 24);
#else
        waiting.fd = server; waiting.events = POLLIN;
        CHECK(poll(&waiting, 1, 5000) == 1, 24);
#endif
        size_t received = 0;
        while (received < sizeof payload) {
            ssize_t n = fwp_socket_recv(server, buffer + received, sizeof payload - received, 0);
            if (n < 0 && fwp_socket_again(errno)) continue;
            CHECK(n > 0, 25);
            received += (size_t)n;
        }
        CHECK(!memcmp(buffer, payload, sizeof payload), 26);
        CHECK(fwp_socket_close(client) == 0 && fwp_socket_close(server) == 0, 27);
        CHECK(fwp_socket_close(listener) == 0, 28);

        fwp_socket_t datagram = fwp_socket_open(AF_INET, SOCK_DGRAM, 0);
        CHECK(datagram != FWP_INVALID_SOCKET, 30);
        address.sin_port = 0;
        CHECK(fwp_socket_bind(datagram, (struct sockaddr *)&address, sizeof address) == 0, 31);
        length = sizeof address;
        CHECK(getsockname(datagram, (struct sockaddr *)&address, &length) == 0, 32);
#ifdef _WIN32
        CHECK(fwp_socket_sendto(datagram, payload, (size_t)INT_MAX + 1, 0,
                               (struct sockaddr *)&address, length) == -1 && errno == WSAEMSGSIZE, 33);
#endif
        CHECK(fwp_socket_sendto(datagram, payload, sizeof payload, 0,
                               (struct sockaddr *)&address, length) == sizeof payload, 34);
        CHECK(fwp_socket_recvfrom(datagram, buffer, sizeof buffer, 0, NULL, NULL) == sizeof payload, 35);
        CHECK(!memcmp(buffer, payload, sizeof payload), 36);
        CHECK(fwp_socket_close(datagram) == 0, 37);
        errno = 0;
        CHECK(fwp_socket_recv(FWP_INVALID_SOCKET, buffer, sizeof buffer, 0) == -1 && errno, 38);
        char error_text[768];
        CHECK(*fwp_socket_message(errno, error_text, sizeof error_text), 39);
        fwp_sockets_finish();
    }
    return 0;
}
