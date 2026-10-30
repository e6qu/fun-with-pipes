//! Linux pipe endpoints release actual descriptors and mappings on every exit.
#![cfg(target_os = "linux")]
use std::process::Command;

#[test]
fn pipe_transports_release_fds_and_complete_mappings() {
    let runtime = include_str!("../runtime/fwp_rt_pipe.c");
    let missing_mapping = runtime.replace(
        "munmap(fwp_pi_ring, fwp_pi_mapping);",
        "/* omit consumer unmapping */",
    );
    let missing_socket = runtime.replace("if (fwp_pi_sock >= 0) close(fwp_pi_sock);", "");
    let invalid_header = runtime.replace("munmap(m, (size_t)st.st_size);", "");
    let extra_descriptor = runtime.replace("else close(next);", "else (void)next;");
    for omitted in [
        &missing_mapping,
        &missing_socket,
        &invalid_header,
        &extra_descriptor,
    ] {
        assert_ne!(omitted, runtime);
    }
    let prefix = r#"
#define _GNU_SOURCE
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <time.h>
#include <dirent.h>
static const int fwp_static_memory = 0;
static int64_t fwp_now_ns(void) {
    struct timespec t; if (clock_gettime(CLOCK_MONOTONIC, &t) != 0) { fputs("clock_gettime failed\n", stderr); exit(1); }
    return (int64_t)t.tv_sec * 1000000000 + t.tv_nsec;
}
"#;
    let probe = r#"
static int mappings(void) {
    FILE *file = fopen("/proc/self/maps", "r");
    if (!file) exit(190);
    char line[1024]; int n = 0;
    while (fgets(line, sizeof line, file)) if (strstr(line, "memfd:fwp-ring")) n++;
    fclose(file); return n;
}
static int descriptors(void) {
    DIR *directory = opendir("/proc/self/fd");
    if (!directory) exit(190);
    int n = 0; struct dirent *entry;
    while ((entry = readdir(directory))) if (entry->d_name[0] != '.') n++;
    closedir(directory); return n;
}
static int gone(void *address) {
    unsigned char resident;
    errno = 0;
    return mincore(address, 4096, &resident) == -1 && errno == ENOMEM;
}
int main(void) {
    int initial_fds = descriptors(), initial_maps = mappings();
    for (int repeat = 0; repeat < 129; repeat++) {
        int sockets[2];
        if (socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, sockets)) return 190;
        fwp_po_sock = sockets[0]; fwp_pi_sock = sockets[1];
        fwp_po_listen = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
        if (fwp_po_listen < 0 || !fwp_po_make_ring()) return 190;
        unsigned char kind = FWP_T_SHM;
        if (!fwp_pipe_in_switch(&kind, 1)) return 191;
        fwp_po_kind = FWP_T_SHM;
        const char payload[] = "owned transport";
        unsigned char output[sizeof payload];
        fwp_pipe_write(payload, sizeof payload);
        if (fwp_pipe_read(output, sizeof output) != sizeof output || memcmp(payload, output, sizeof output)) return 192;
        char *producer = (char *)fwp_po_ring, *consumer = (char *)fwp_pi_ring;
        size_t length = fwp_pi_mapping;
        /* Peer-owned header fields must not determine teardown's map length. */
        fwp_pi_ring->cap = 1;
        fwp_pipe_finish();
        fwp_pipe_finish();
        if (!gone(producer) || !gone(consumer) || !gone(consumer + length - 4096)) return 23;
        if (descriptors() != initial_fds) return 24;
        if (mappings() != initial_maps) return 23;

        if (socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, sockets)) return 190;
        fwp_po_sock = sockets[0]; fwp_pi_sock = sockets[1];
        if (!fwp_po_make_ring()) return 190;
        fwp_po_ring->magic[0] = 'X';
        if (fwp_pipe_in_switch(&kind, 1)) return 191;
        if (mappings() != initial_maps + 1) return 25;
        fwp_pipe_finish();
        if (descriptors() != initial_fds || mappings() != initial_maps) return 26;
    }
    for (int count = 2; count <= 3; count++) {
        int sockets[2];
        if (socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, sockets)) return 190;
        fwp_po_sock = sockets[0]; fwp_pi_sock = sockets[1];
        int fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
        if (fd < 0) return 190;
        char one = 'S'; struct iovec iov = {&one, 1};
        union { struct cmsghdr h; char bytes[CMSG_SPACE(3 * sizeof(int))]; } u = {0};
        struct msghdr message = {0};
        message.msg_iov = &iov; message.msg_iovlen = 1;
        message.msg_control = u.bytes; message.msg_controllen = CMSG_SPACE((size_t)count * sizeof(int));
        struct cmsghdr *c = CMSG_FIRSTHDR(&message);
        c->cmsg_level = SOL_SOCKET; c->cmsg_type = SCM_RIGHTS;
        c->cmsg_len = CMSG_LEN((size_t)count * sizeof(int));
        for (int i = 0; i < count; i++) memcpy(CMSG_DATA(c) + i * sizeof(int), &fd, sizeof fd);
        if (sendmsg(sockets[0], &message, MSG_NOSIGNAL) != 1) return 190;
        close(fd);
        unsigned char kind = FWP_T_SHM;
        if (fwp_pipe_in_switch(&kind, 1)) return 191;
        fwp_pipe_finish();
        if (descriptors() != initial_fds) return 27;
    }
    return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("pipe-ownership").unwrap();
    let binary = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [
            (runtime, 0),
            (missing_mapping.as_str(), 23),
            (missing_socket.as_str(), 24),
            (invalid_header.as_str(), 25),
            (extra_descriptor.as_str(), 27),
        ] {
            fwp::cgen::compile_c(&format!("{prefix}{code}{probe}"), &binary, opt).unwrap();
            let output = Command::new(&binary)
                .env_remove("FWP_TRANSPORT_REPORT")
                .output()
                .unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
    }
}
