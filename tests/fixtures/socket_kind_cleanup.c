/* Exercise the production tag dispatch with TLS enabled, without OpenSSL.
 * The peers check which destructor is selected; other tests use real sockets. */
#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#define FWP_TLS /* Only the destructor branch; peers provide TLS operations. */
#ifdef _WIN32
typedef uintptr_t fwp_socket_t;
#else
typedef int fwp_socket_t;
#endif
#define FWP_INVALID_SOCKET ((fwp_socket_t)-1)
/* SOCKET_LAYOUT */
struct previous_header { fwp_socket_t fd; int kind; void *tls; };
_Static_assert(sizeof(fwp_sock)==sizeof(struct previous_header),"socket header grew");
_Static_assert(sizeof(fwp_stream)==sizeof(fwp_sock)+sizeof(void *),"TLS adds one pointer in the same allocation");
_Static_assert(offsetof(fwp_sock,refs)%_Alignof(uint64_t)==0,"unaligned owner count");
static int closed, notified, server, session;
static void fwp_fd_closing(fwp_socket_t fd) { if(fd!=41) exit(247); notified++; }
static int fwp_socket_close(fwp_socket_t fd) { if(fd!=41) exit(247); closed++; return 0; }
static void fwp_tls_server_drop(void *p) { if(p!=(void *)(uintptr_t)1) exit(248); server++; }
static void fwp_tls_dispose(void *p) { if(p!=(void *)(uintptr_t)2) exit(248); session++; }
/* SOCKET_FINALIZER */
int main(void) {
    fwp_stream datagram={.socket={.fd=41,.kind=2,.refs=301},.tls=(void *)(uintptr_t)301};
    fwp_sock *udp=&datagram.socket;
    fwp_stream listener={.socket={.fd=41,.kind=0,.refs=1},.tls=(void *)(uintptr_t)1};
    fwp_stream connection={.socket={.fd=41,.kind=1,.refs=1},.tls=(void *)(uintptr_t)2};
    fwp_sock_final(udp); fwp_sock_final(udp);
    if(udp->refs!=301 || server || session || closed!=1 || notified!=1) return 248;
    fwp_sock_final(&listener); fwp_sock_final(&listener);
    fwp_sock_final(&connection); fwp_sock_final(&connection);
    if(server!=1 || session!=1 || closed!=3 || notified!=3) return 248;
    return 0;
}
