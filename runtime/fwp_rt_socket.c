/* Socket handles, errors and transfer widths differ from CRT file descriptors
 * on Windows. Normalize only those differences; Unix calls remain direct. */
#ifndef FWP_SOCKET_RUNTIME
#define FWP_SOCKET_RUNTIME
#ifndef __wasi__
#include <errno.h>
#include <limits.h>
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#ifdef _WIN32
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>
#include <sys/types.h>
typedef SOCKET fwp_socket_t;
#define FWP_INVALID_SOCKET INVALID_SOCKET
#define SHUT_RDWR SD_BOTH
#define MSG_NOSIGNAL 0
static int fwp_sockets_ready;
static int fwp_sockets_init(void) {
    if (fwp_sockets_ready) return 0;
    WSADATA data;
    int error = WSAStartup(MAKEWORD(2, 2), &data);
    if (error) { errno = error; return -1; }
    fwp_sockets_ready = 1;
    return 0;
}
static void fwp_sockets_finish(void) {
    if (fwp_sockets_ready) WSACleanup();
    fwp_sockets_ready = 0;
}
static int fwp_socket_result(int result) {
    if (result == SOCKET_ERROR) errno = WSAGetLastError();
    return result;
}
static fwp_socket_t fwp_socket_open(int family, int type, int protocol) {
    if (fwp_sockets_init()) return INVALID_SOCKET;
    SOCKET fd = WSASocketW(family, type, protocol, NULL, 0, WSA_FLAG_NO_HANDLE_INHERIT);
    if (fd == INVALID_SOCKET) errno = WSAGetLastError();
    return fd;
}
static fwp_socket_t fwp_socket_accept(fwp_socket_t fd, struct sockaddr *address, socklen_t *size) {
    SOCKET child = accept(fd, address, size);
    if (child == INVALID_SOCKET) errno = WSAGetLastError();
    else if (!SetHandleInformation((HANDLE)child, HANDLE_FLAG_INHERIT, 0)) {
        int error = (int)GetLastError();
        closesocket(child);
        errno = error;
        return INVALID_SOCKET;
    }
    return child;
}
static int fwp_socket_bind(fwp_socket_t fd, const struct sockaddr *address, socklen_t size) {
    return fwp_socket_result(bind(fd, address, size));
}
static int fwp_socket_listen(fwp_socket_t fd, int backlog) {
    return fwp_socket_result(listen(fd, backlog));
}
static int fwp_socket_connect(fwp_socket_t fd, const struct sockaddr *address, socklen_t size) {
    return fwp_socket_result(connect(fd, address, size));
}
static int fwp_socket_close(fwp_socket_t fd) { return fwp_socket_result(closesocket(fd)); }
static int fwp_socket_nonblock(fwp_socket_t fd) {
    u_long enabled = 1;
    return fwp_socket_result(ioctlsocket(fd, FIONBIO, &enabled));
}
static ssize_t fwp_socket_recv(fwp_socket_t fd, void *data, size_t size, int flags) {
    int n = size > INT_MAX ? INT_MAX : (int)size;
    return fwp_socket_result(recv(fd, (char *)data, n, flags));
}
static ssize_t fwp_socket_send(fwp_socket_t fd, const void *data, size_t size, int flags) {
    int n = size > INT_MAX ? INT_MAX : (int)size;
    return fwp_socket_result(send(fd, (const char *)data, n, flags));
}
static ssize_t fwp_socket_recvfrom(fwp_socket_t fd, void *data, size_t size, int flags,
                                  struct sockaddr *address, socklen_t *length) {
    if (size > INT_MAX) { errno = WSAEMSGSIZE; return -1; }
    return fwp_socket_result(recvfrom(fd, (char *)data, (int)size, flags, address, length));
}
static ssize_t fwp_socket_sendto(fwp_socket_t fd, const void *data, size_t size, int flags,
                                const struct sockaddr *address, socklen_t length) {
    if (size > INT_MAX) { errno = WSAEMSGSIZE; return -1; }
    return fwp_socket_result(sendto(fd, (const char *)data, (int)size, flags, address, length));
}
static int fwp_socket_pending(int error) { return error == WSAEWOULDBLOCK || error == WSAEINPROGRESS; }
static int fwp_socket_again(int error) {
    return error == WSAEWOULDBLOCK || error == WSAEINTR ||
           error == EAGAIN || error == EWOULDBLOCK || error == EINTR;
}
static int fwp_socket_aborted(int error) { return error == WSAECONNABORTED; }
static const char *fwp_socket_message(int error, char *text, size_t size) {
    if (error < WSABASEERR) return strerror(error);
    wchar_t wide[768];
    DWORD n = FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
                            NULL, (DWORD)error, 0, wide, 768, NULL);
    while (n && (wide[n - 1] == L'\r' || wide[n - 1] == L'\n')) wide[--n] = 0;
    if (!n || !WideCharToMultiByte(CP_UTF8, 0, wide, -1, text, (int)size, NULL, NULL))
        snprintf(text, size, "socket error %d", error);
    return text;
}
#else
#include <unistd.h>
#include <fcntl.h>
#include <poll.h>
#include <netdb.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
typedef int fwp_socket_t;
#define FWP_INVALID_SOCKET (-1)
#ifndef MSG_NOSIGNAL
#define MSG_NOSIGNAL 0
#endif
static int fwp_sockets_init(void) { return 0; }
static void fwp_sockets_finish(void) {}
#define fwp_socket_open socket
#define fwp_socket_accept accept
#define fwp_socket_bind bind
#define fwp_socket_listen listen
#define fwp_socket_connect connect
#define fwp_socket_close close
#define fwp_socket_recv recv
#define fwp_socket_send send
#define fwp_socket_recvfrom recvfrom
#define fwp_socket_sendto sendto
static int fwp_socket_nonblock(fwp_socket_t fd) {
    int flags = fcntl(fd, F_GETFL, 0);
    if (flags < 0 || fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0) return -1;
    return fcntl(fd, F_SETFD, FD_CLOEXEC);
}
static int fwp_socket_pending(int error) { return error == EINPROGRESS; }
static int fwp_socket_again(int error) { return error == EAGAIN || error == EWOULDBLOCK || error == EINTR; }
static int fwp_socket_aborted(int error) { return error == ECONNABORTED; }
static const char *fwp_socket_message(int error, char *text, size_t size) {
    (void)text; (void)size;
    return strerror(error);
}
#endif
static int fwp_socket_connect_error(fwp_socket_t fd) {
    int error = 0;
    socklen_t size = sizeof error;
    if (getsockopt(fd, SOL_SOCKET, SO_ERROR, (char *)&error, &size) != 0) {
#ifdef _WIN32
        errno = WSAGetLastError();
#endif
        return -1;
    }
    if (error) { errno = error; return -1; }
    return 0;
}
#else
typedef int fwp_socket_t;
#endif
#endif
