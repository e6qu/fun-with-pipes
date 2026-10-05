/* Transports of the binary pipe protocol (docs/protocol.md#transports;
 * mirrors src/transport.rs).
 *
 * A producer (an executable writing FWP_OUT=bin to a pipe) listens on the
 * abstract Unix socket named after its stdout pipe, `fwp.pipe.<dev>.<ino>`.
 * A consumer that reads a PIPE_V1 header advertising UDS_V1 from its stdin
 * pipe connects to the socket of the same pipe and asks for a transport
 * ("FWPT" and 1 for UDS_V1, 2 for SHM_V1). At its next frame boundary the
 * producer answers on stdout with a switch frame (kind 2, one byte: the
 * transport it chose) and writes the rest of the stream (frames and the
 * end frame, the same bytes) to the socket, or to a ring in shared memory
 * whose descriptor it passes over the socket. Without a listener, a
 * consumer that cannot connect, or an answer, everything stays on stdio.
 *
 * The ring (SHM_V1) is a memfd: a 4096-byte header (little-endian: "FWPS",
 * version 1, capacity; at 64 the bytes written, at 128 the bytes read, at
 * 192 a futex sequence and waiting flag for data, at 256 the same for
 * space, at 320 the producer's end flag) and `capacity` bytes of data. One
 * producer and one consumer, lock-free; a side that waits sets its flag
 * and sleeps on the futex, and the other side wakes it. The socket stays
 * open, so a side that sleeps notices when the other one died. */

#include <stddef.h>
#if defined(__linux__) && !defined(__wasi__)
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <poll.h>
#include <fcntl.h>
#include <unistd.h>
#if __has_include(<linux/futex.h>)
#include <linux/futex.h>
#else
/* musl's headers have no kernel headers */
#define FUTEX_WAIT 0
#define FUTEX_WAKE 1
#endif
#include <sched.h>
#define FWP_PIPE_TRANSPORTS 1
#endif

/* kinds of transport: the stream continues on stdio, a socket, a ring */
enum { FWP_T_STDIO = 0, FWP_T_UDS = 1, FWP_T_SHM = 2 };

#ifdef FWP_PIPE_TRANSPORTS

#define FWP_RING_CAP ((uint64_t)1 << 20)
#define FWP_RING_DATA 4096

typedef struct {
    char magic[4];
    uint32_t version;
    uint64_t cap;
    char pad0[48];
    uint64_t head; /* 64: bytes written */
    char pad1[56];
    uint64_t tail; /* 128: bytes read */
    char pad2[56];
    uint32_t data_seq, cons_wait; /* 192 */
    char pad3[56];
    uint32_t space_seq, prod_wait; /* 256 */
    char pad4[56];
    uint32_t closed; /* 320 */
} fwp_ring;

static long fwp_futex(uint32_t *a, int op, uint32_t v, int ms) {
    struct timespec ts = {ms / 1000, (long)(ms % 1000) * 1000000L};
    return syscall(SYS_futex, a, op, v, ms >= 0 ? &ts : 0, 0, 0);
}

static void fwp_ring_wake(uint32_t *seq, uint32_t *waiting) {
    __atomic_thread_fence(__ATOMIC_SEQ_CST);
    if (__atomic_load_n(waiting, __ATOMIC_RELAXED)) {
        __atomic_fetch_add(seq, 1, __ATOMIC_SEQ_CST);
        fwp_futex(seq, FUTEX_WAKE, INT32_MAX, -1);
    }
}

/* whether the other end of a socket hung up */
static int fwp_sock_gone(int fd) {
    struct pollfd p = {fd, POLLIN, 0};
    if (poll(&p, 1, 0) <= 0) return 0;
    if (p.revents & (POLLHUP | POLLERR)) return 1;
    char c;
    return recv(fd, &c, 1, MSG_PEEK | MSG_DONTWAIT) == 0;
}

/* wait until `ready` holds (re-checked after announcing the wait), the
 * peer on `sock` is gone (0), or it holds (1) */
static int fwp_ring_spin = -1;

static void fwp_cpu_relax(void) {
#if defined(__x86_64__) || defined(__i386__)
    __builtin_ia32_pause();
#elif defined(__aarch64__)
    __asm__ __volatile__("yield");
#endif
}

static int fwp_ring_wait(fwp_ring *r, uint32_t *seq, uint32_t *waiting, int (*ready)(fwp_ring *), int sock) {
    /* the other side is usually about to catch up: spin for a while (on
     * machines with more than one processor) before sleeping, so that
     * neither side needs a system call for each record */
    if (fwp_ring_spin < 0) fwp_ring_spin = sysconf(_SC_NPROCESSORS_ONLN) > 1;
    if (fwp_ring_spin) {
        int64_t until = 0;
        for (unsigned i = 1;; i++) {
            if (ready(r)) return 1;
            fwp_cpu_relax();
            if ((i & 63) == 0) {
                /* let the other side have this processor if it waits */
                sched_yield();
                int64_t now = fwp_now_ns();
                if (!until) until = now + 50000;
                else if (now > until) break;
            }
        }
    }
    for (;;) {
        uint32_t s = __atomic_load_n(seq, __ATOMIC_SEQ_CST);
        __atomic_store_n(waiting, 1, __ATOMIC_SEQ_CST);
        __atomic_thread_fence(__ATOMIC_SEQ_CST);
        if (ready(r)) { __atomic_store_n(waiting, 0, __ATOMIC_RELAXED); return 1; }
        long rc = fwp_futex(seq, FUTEX_WAIT, s, 100);
        __atomic_store_n(waiting, 0, __ATOMIC_RELAXED);
        if (ready(r)) return 1;
        if (rc != 0 && errno == ETIMEDOUT && fwp_sock_gone(sock)) return 0;
    }
}

static int fwp_ring_has_space(fwp_ring *r) {
    return r->cap - (r->head - __atomic_load_n(&r->tail, __ATOMIC_ACQUIRE)) > 0;
}

static int fwp_ring_has_data(fwp_ring *r) {
    return __atomic_load_n(&r->head, __ATOMIC_ACQUIRE) != r->tail || __atomic_load_n(&r->closed, __ATOMIC_ACQUIRE);
}

/* ----- producer */

static int fwp_po_kind = FWP_T_STDIO, fwp_po_listen = -1, fwp_po_sock = -1, fwp_po_gone = 0;
static int64_t fwp_po_next_check = 0, fwp_po_give_up = 0;
static unsigned fwp_po_frames = 0;
static fwp_ring *fwp_po_ring = 0;
static unsigned char fwp_po_buf[1 << 16];
static size_t fwp_po_len = 0;

/* the abstract socket name of a pipe */
static socklen_t fwp_pipe_addr(struct sockaddr_un *a, struct stat *st) {
    memset(a, 0, sizeof *a);
    a->sun_family = AF_UNIX;
    int n = snprintf(a->sun_path + 1, sizeof a->sun_path - 1, "fwp.pipe.%llu.%llu", (unsigned long long)st->st_dev,
                     (unsigned long long)st->st_ino);
    return (socklen_t)(offsetof(struct sockaddr_un, sun_path) + 1 + n);
}

static int fwp_transport_off(void) {
    const char *t = getenv("FWP_TRANSPORT");
    return t && strcmp(t, "stdio") == 0;
}

/* before the header: offer the transports when stdout is a pipe */
static void fwp_pipe_out_start(void) {
    struct stat st;
    if (fstat(1, &st) != 0 || !S_ISFIFO(st.st_mode)) return;
    /* a larger pipe (F_SETPIPE_SZ, up to the system's limit) means fewer
     * switches between the processes, even without a transport */
    fcntl(1, 1031, 1 << 20);
    if (fwp_transport_off()) return;
    int fd = socket(AF_UNIX, SOCK_STREAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
    if (fd < 0) return;
    struct sockaddr_un a;
    socklen_t len = fwp_pipe_addr(&a, &st);
    if (bind(fd, (struct sockaddr *)&a, len) != 0 || listen(fd, 1) != 0) { close(fd); return; }
    fwp_po_listen = fd;
    fwp_po_give_up = fwp_now_ns() + 5000000000LL;
}

static void fwp_po_write_raw(int fd, const unsigned char *p, size_t n) {
    while (n && !fwp_po_gone) {
        ssize_t k = send(fd, p, n, MSG_NOSIGNAL);
        if (k < 0 && errno == EINTR) continue;
        if (k <= 0) { fwp_po_gone = 1; return; }
        p += k;
        n -= (size_t)k;
    }
}

static void fwp_ring_put(const unsigned char *p, size_t n) {
    fwp_ring *r = fwp_po_ring;
    unsigned char *d = (unsigned char *)r + FWP_RING_DATA;
    while (n && !fwp_po_gone) {
        uint64_t head = r->head, tail = __atomic_load_n(&r->tail, __ATOMIC_ACQUIRE);
        uint64_t space = r->cap - (head - tail);
        if (!space) {
            if (!fwp_ring_wait(r, &r->space_seq, &r->prod_wait, fwp_ring_has_space, fwp_po_sock)) fwp_po_gone = 1;
            continue;
        }
        size_t k = n < space ? n : (size_t)space;
        size_t off = (size_t)(head & (r->cap - 1)), first = k < r->cap - off ? k : (size_t)(r->cap - off);
        memcpy(d + off, p, first);
        memcpy(d, p + first, k - first);
        __atomic_store_n(&r->head, head + k, __ATOMIC_RELEASE);
        fwp_ring_wake(&r->data_seq, &r->cons_wait);
        p += k;
        n -= k;
    }
}

static void fwp_po_flush_sock(void) {
    if (fwp_po_len) fwp_po_write_raw(fwp_po_sock, fwp_po_buf, fwp_po_len);
    fwp_po_len = 0;
}

static void fwp_pipe_write(const void *p, size_t n) {
    const unsigned char *b = (const unsigned char *)p;
    switch (fwp_po_kind) {
    case FWP_T_SHM: fwp_ring_put(b, n); return;
    case FWP_T_UDS:
        if (fwp_po_len + n > sizeof fwp_po_buf) fwp_po_flush_sock();
        if (n > sizeof fwp_po_buf) { fwp_po_write_raw(fwp_po_sock, b, n); return; }
        memcpy(fwp_po_buf + fwp_po_len, b, n);
        fwp_po_len += n;
        return;
    default: fwrite(b, 1, n, stdout);
    }
}

/* a ring in a fresh memfd, sent over the socket; 0 if that fails */
static int fwp_po_make_ring(void) {
#ifdef FWP_STATIC_MEMORY
    /* a ring would be new memory: static programs stay on the socket */
    return 0;
#endif
    int fd = (int)syscall(SYS_memfd_create, "fwp-ring", 1 /* MFD_CLOEXEC */);
    if (fd < 0) return 0;
    size_t size = FWP_RING_DATA + (size_t)FWP_RING_CAP;
    void *m = MAP_FAILED;
    if (ftruncate(fd, (off_t)size) == 0) m = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (m == MAP_FAILED) { close(fd); return 0; }
    fwp_ring *r = (fwp_ring *)m;
    memcpy(r->magic, "FWPS", 4);
    r->version = 1;
    r->cap = FWP_RING_CAP;
    char one = 'S';
    struct iovec iov = {&one, 1};
    union { struct cmsghdr h; char b[CMSG_SPACE(sizeof(int))]; } u;
    memset(&u, 0, sizeof u);
    struct msghdr msg;
    memset(&msg, 0, sizeof msg);
    msg.msg_iov = &iov;
    msg.msg_iovlen = 1;
    msg.msg_control = u.b;
    msg.msg_controllen = sizeof u.b;
    struct cmsghdr *c = CMSG_FIRSTHDR(&msg);
    c->cmsg_level = SOL_SOCKET;
    c->cmsg_type = SCM_RIGHTS;
    c->cmsg_len = CMSG_LEN(sizeof(int));
    memcpy(CMSG_DATA(c), &fd, sizeof(int));
    ssize_t k = sendmsg(fwp_po_sock, &msg, MSG_NOSIGNAL);
    close(fd);
    if (k != 1) { munmap(m, size); return 0; }
    fwp_po_ring = r;
    return 1;
}

/* a frame boundary: if a consumer connected, switch to what it asked for */
static void fwp_pipe_poll(void) {
    if (fwp_po_listen < 0) return;
    int64_t now = fwp_now_ns();
    if (now < fwp_po_next_check) return;
    fwp_po_next_check = now + 1000000;
    int fd = accept(fwp_po_listen, 0, 0);
    if (fd < 0) {
        if (now > fwp_po_give_up) { close(fwp_po_listen); fwp_po_listen = -1; }
        return;
    }
    close(fwp_po_listen);
    fwp_po_listen = -1;
    fcntl(fd, F_SETFD, FD_CLOEXEC);
    fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) & ~O_NONBLOCK);
    /* only a process of the same user, asking within a second */
    struct { int pid; unsigned uid, gid; } cred;
    socklen_t cl = sizeof cred;
    unsigned char hello[5];
    struct pollfd p = {fd, POLLIN, 0};
    size_t got = 0;
    int ok = getsockopt(fd, SOL_SOCKET, 17 /* SO_PEERCRED */, &cred, &cl) == 0 && cred.uid == (unsigned)getuid();
    while (ok && got < 5) {
        if (poll(&p, 1, 1000) <= 0) { ok = 0; break; }
        ssize_t k = recv(fd, hello + got, 5 - got, 0);
        if (k <= 0) { ok = 0; break; }
        got += (size_t)k;
    }
    /* a consumer that declines (0) leaves the stream on stdio */
    if (!ok || memcmp(hello, "FWPT", 4) != 0 || (hello[4] != FWP_T_UDS && hello[4] != FWP_T_SHM)) {
        close(fd);
        return;
    }
    fwp_po_sock = fd;
    int kind = FWP_T_UDS;
    if (hello[4] == FWP_T_SHM && fwp_po_make_ring()) kind = FWP_T_SHM;
    unsigned char sw[6] = {2, 1, 0, 0, 0, (unsigned char)kind};
    fwrite(sw, 1, 6, stdout);
    fflush(stdout);
    fwp_po_kind = kind;
}

/* after the header: with FWP_TRANSPORT_WAIT=ms (which `fwp pipe` sets,
 * knowing that the consumer is an fwp program too), wait that long for
 * the consumer to ask, unless it is gone */
static void fwp_pipe_out_ready(void) {
    const char *w = getenv("FWP_TRANSPORT_WAIT");
    if (fwp_po_listen < 0 || !w || !*w) return;
    long ms = strtol(w, 0, 10);
    struct pollfd p[2] = {{fwp_po_listen, POLLIN, 0}, {1, 0, 0}};
    if (ms > 0 && poll(p, 2, ms > INT32_MAX ? INT32_MAX : (int)ms) > 0 && (p[0].revents & POLLIN)) {
        fwp_po_next_check = 0;
        fwp_pipe_poll();
    }
}

static void fwp_pipe_frame_done(void) {
    if (fwp_po_listen >= 0 && (++fwp_po_frames & 63) == 0) fwp_pipe_poll();
}

static void fwp_pipe_flush(void) {
    if (fwp_po_kind == FWP_T_UDS) fwp_po_flush_sock();
    else if (fwp_po_kind == FWP_T_STDIO) {
        fflush(stdout);
        fwp_pipe_poll();
    }
}

/* after the end frame */
static void fwp_pipe_out_end(void) {
    if (fwp_po_kind == FWP_T_UDS) {
        fwp_po_flush_sock();
        shutdown(fwp_po_sock, SHUT_WR);
    } else if (fwp_po_kind == FWP_T_SHM) {
        __atomic_store_n(&fwp_po_ring->closed, 1, __ATOMIC_RELEASE);
        fwp_ring_wake(&fwp_po_ring->data_seq, &fwp_po_ring->cons_wait);
    } else {
        fflush(stdout);
    }
    if (fwp_po_listen >= 0) { close(fwp_po_listen); fwp_po_listen = -1; }
}

/* ----- consumer */

static int fwp_pi_kind = FWP_T_STDIO, fwp_pi_sock = -1;
static fwp_ring *fwp_pi_ring = 0;
static unsigned char fwp_pi_buf[1 << 16];
static size_t fwp_pi_pos = 0, fwp_pi_len = 0;

/* after a header that offers UDS_V1: ask the producer of the stdin pipe */
static void fwp_pipe_in_offer(void) {
    struct stat st;
    if (fstat(0, &st) != 0 || !S_ISFIFO(st.st_mode)) return;
    int fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
    if (fd < 0) return;
    struct sockaddr_un a;
    socklen_t len = fwp_pipe_addr(&a, &st);
    const char *t = getenv("FWP_TRANSPORT");
    /* FWP_TRANSPORT=stdio declines (0), so that a waiting producer goes on */
    int off = fwp_transport_off();
    unsigned char hello[5] = {'F', 'W', 'P', 'T', off ? FWP_T_STDIO : fwp_static_memory || (t && strcmp(t, "uds") == 0) ? FWP_T_UDS : FWP_T_SHM};
    if (connect(fd, (struct sockaddr *)&a, len) != 0 || send(fd, hello, 5, MSG_NOSIGNAL) != 5 || off) {
        close(fd);
        return;
    }
    fwp_pi_sock = fd;
}

/* FWP_TRANSPORT_REPORT=1: say on stderr where the stream continues */
static void fwp_pipe_report(const char *name) {
    const char *r = getenv("FWP_TRANSPORT_REPORT");
    if (r && *r && strcmp(r, "0") != 0) fprintf(stderr, "fwp: input continues on %s\n", name);
}

/* a switch frame: 1 if the stream continues on the transport it names */
static int fwp_pipe_in_switch(const unsigned char *pl, size_t len) {
    if (len != 1 || fwp_pi_sock < 0 || fwp_pi_kind != FWP_T_STDIO) return 0;
    if (pl[0] == FWP_T_UDS) {
        fwp_pi_kind = FWP_T_UDS;
        fwp_pipe_report("UDS_V1");
        return 1;
    }
    if (pl[0] != FWP_T_SHM) return 0;
    char one;
    struct iovec iov = {&one, 1};
    union { struct cmsghdr h; char b[CMSG_SPACE(sizeof(int))]; } u;
    struct msghdr msg;
    memset(&msg, 0, sizeof msg);
    msg.msg_iov = &iov;
    msg.msg_iovlen = 1;
    msg.msg_control = u.b;
    msg.msg_controllen = sizeof u.b;
    if (recvmsg(fwp_pi_sock, &msg, MSG_CMSG_CLOEXEC) != 1) return 0;
    struct cmsghdr *c = CMSG_FIRSTHDR(&msg);
    if (!c || c->cmsg_type != SCM_RIGHTS) return 0;
    int fd;
    memcpy(&fd, CMSG_DATA(c), sizeof fd);
    struct stat st;
    void *m = MAP_FAILED;
    if (fstat(fd, &st) == 0 && (size_t)st.st_size > FWP_RING_DATA)
        m = mmap(0, (size_t)st.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    close(fd);
    if (m == MAP_FAILED) return 0;
    fwp_ring *r = (fwp_ring *)m;
    uint64_t cap = r->cap;
    if (memcmp(r->magic, "FWPS", 4) != 0 || r->version != 1 || !cap || (cap & (cap - 1)) ||
        cap > (uint64_t)st.st_size - FWP_RING_DATA)
        return 0;
    fwp_pi_ring = r;
    fwp_pi_kind = FWP_T_SHM;
    fwp_pipe_report("SHM_V1");
    return 1;
}

/* up to n bytes of the stream; 0 at its end */
static size_t fwp_pipe_read(unsigned char *buf, size_t n) {
    if (fwp_pi_kind == FWP_T_SHM) {
        fwp_ring *r = fwp_pi_ring;
        uint64_t head;
        while ((head = __atomic_load_n(&r->head, __ATOMIC_ACQUIRE)) == r->tail) {
            if (__atomic_load_n(&r->closed, __ATOMIC_ACQUIRE) && __atomic_load_n(&r->head, __ATOMIC_ACQUIRE) == r->tail)
                return 0;
            if (!fwp_ring_wait(r, &r->data_seq, &r->cons_wait, fwp_ring_has_data, fwp_pi_sock)) return 0;
        }
        uint64_t avail = head - r->tail;
        size_t k = n < avail ? n : (size_t)avail;
        size_t off = (size_t)(r->tail & (r->cap - 1)), first = k < r->cap - off ? k : (size_t)(r->cap - off);
        const unsigned char *d = (const unsigned char *)r + FWP_RING_DATA;
        memcpy(buf, d + off, first);
        memcpy(buf + first, d, k - first);
        __atomic_store_n(&r->tail, r->tail + k, __ATOMIC_RELEASE);
        fwp_ring_wake(&r->space_seq, &r->prod_wait);
        return k;
    }
    if (fwp_pi_kind == FWP_T_UDS) {
        if (fwp_pi_pos == fwp_pi_len) {
            ssize_t k;
            do k = recv(fwp_pi_sock, fwp_pi_buf, sizeof fwp_pi_buf, 0);
            while (k < 0 && errno == EINTR);
            if (k <= 0) return 0;
            fwp_pi_pos = 0;
            fwp_pi_len = (size_t)k;
        }
        size_t k = fwp_pi_len - fwp_pi_pos;
        if (k > n) k = n;
        memcpy(buf, fwp_pi_buf + fwp_pi_pos, k);
        fwp_pi_pos += k;
        return k;
    }
    return fread(buf, 1, n, stdin);
}

#else /* no transports: the stream stays on stdio */

static void fwp_pipe_out_start(void) {}
static void fwp_pipe_out_ready(void) {}
static void fwp_pipe_write(const void *p, size_t n) { fwrite(p, 1, n, stdout); }
static void fwp_pipe_frame_done(void) {}
static void fwp_pipe_flush(void) { fflush(stdout); }
static void fwp_pipe_out_end(void) { fflush(stdout); }
static void fwp_pipe_in_offer(void) {}
static int fwp_pipe_in_switch(const unsigned char *pl, size_t len) { (void)pl; (void)len; return 0; }
static size_t fwp_pipe_read(unsigned char *buf, size_t n) { return fread(buf, 1, n, stdin); }

#endif
