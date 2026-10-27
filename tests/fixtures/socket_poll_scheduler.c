#define CHECK(x, code) do { if (!(x)) { fprintf(stderr, "socket scheduler check %d\n", code); return code; } } while (0)
static int poll_array_checks(void) {
    fwp_task tasks[40] = {0};
    fwp_poll_wait waits[40];
    fwp_poll_reserve(40);
    for (int i = 39; i >= 0; i--) {
        waits[i] = (fwp_poll_wait){fwp_poll_waits, (fwp_socket_t)(100 + i),
                                 &tasks[i], i % 2 ? POLLWRNORM : POLLRDNORM};
        fwp_poll_waits = &waits[i];
    }
    fwp_io_waiting = 40; poll_probe = 1;
    fwp_poll_events();
    CHECK(poll_calls == 1 && poll_timeout == -1 && poll_count == 40, 41);
    CHECK(fwp_poll_cap >= 40, 42);
    for (int i = 0; i < 40; i++) CHECK(tasks[i].ready == (i % 3 == 0), 43);
    while (fwp_dequeue()) {}
    memset(tasks, 0, sizeof tasks);
    fwp_task timer = {0};
    fwp_timer_add(&timer, INT64_MAX);
    fwp_poll_events();
    CHECK(poll_timeout == INT_MAX && !timer.timed_out, 44);
    fwp_timer_remove(&timer);
    while (fwp_dequeue()) {}
    memset(tasks, 0, sizeof tasks);
    int calls = poll_calls;
    fwp_poll_ready();
    CHECK(poll_calls == calls + 1 && poll_timeout == 0, 46);
    while (fwp_dequeue()) {}
    memset(tasks, 0, sizeof tasks);
    fwp_fd_closing(waits[7].fd);
    CHECK(tasks[7].ready && tasks[7].io_ready, 47);
    fwp_cancel_tree(&tasks[8]);
    CHECK(tasks[8].ready && tasks[8].cancelled, 48);
    fwp_poll_ready();
    CHECK(poll_count == 38, 63); /* do not poll closed/cancelled queued waiters */
    while (fwp_dequeue()) {}
    memset(tasks, 0, sizeof tasks);
    poll_probe = 2; fwp_poll_ready();
    CHECK(!fwp_ready_head, 64); /* interrupted OS wait is not readiness */
    poll_probe = 3; fwp_poll_ready();
    for (int i = 0; i < 40; i++) CHECK(tasks[i].ready && tasks[i].io_ready, 65);
    while (fwp_dequeue()) {}
    for (int i = 0; i < 40; i++) fwp_poll_wait_remove(&waits[i]);
    CHECK(!fwp_poll_waits && !fwp_poll_fds && !fwp_poll_cap, 49);
    fwp_io_waiting = 0; poll_probe = 0;
    return 0;
}
static fwp_socket_t read_fd;
static int read_result;
static int64_t read_deadline;
static jmp_buf reserve_jump;
static int reserve_recover(void) { return 1; }
static void wait_read(void *unused, int cancelled) {
    (void)unused;
    if (cancelled) return;
    read_result = fwp_wait_fd(read_fd, 0, read_deadline);
}
static int socket_pair(fwp_socket_t *a, fwp_socket_t *b) {
    fwp_socket_t listener = fwp_socket_open(AF_INET, SOCK_STREAM, 0);
    CHECK(listener != FWP_INVALID_SOCKET, 50);
    struct sockaddr_in address = {0};
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    CHECK(!fwp_socket_bind(listener, (struct sockaddr *)&address, sizeof address), 51);
    CHECK(!fwp_socket_listen(listener, 4), 52);
    socklen_t length = sizeof address;
    CHECK(!getsockname(listener, (struct sockaddr *)&address, &length), 53);
    *b = fwp_socket_open(AF_INET, SOCK_STREAM, 0);
    CHECK(*b != FWP_INVALID_SOCKET, 54);
    CHECK(!fwp_socket_connect(*b, (struct sockaddr *)&address, length), 55);
    *a = fwp_socket_accept(listener, NULL, NULL);
    CHECK(*a != FWP_INVALID_SOCKET, 56);
    fwp_socket_close(listener);
    CHECK(!fwp_socket_nonblock(*a) && !fwp_socket_nonblock(*b), 57);
    return 0;
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    int result = poll_array_checks();
    if (result) return result;
    fwp_tasks_init();
    for (int mode = 0; mode < 5; mode++) {
        fwp_socket_t peer;
        result = socket_pair(&read_fd, &peer);
        if (result) return result;
        if (!mode) {
            poll_reserve_fail = 1;
            fwp_trap_recover = reserve_recover; fwp_trap_jb = &reserve_jump;
            fwp_trap_cleanup = fwp_cleanups;
            if (!setjmp(reserve_jump)) { fwp_wait_fd(read_fd, 0, 0); return 67; }
            poll_reserve_fail = 0; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
            CHECK(!fwp_poll_waits && !fwp_io_waiting && !fwp_poll_fds && !fwp_cleanups, 66);
        }
        read_result = -1;
        read_deadline = mode == 4 ? fwp_now_ns() + 1000000 : 0;
        fwp_task *task = fwp_spawn_task(0, wait_read, NULL, 0, 0);
        fwp_make_ready(fwp_root); fwp_block();
        if (mode != 4) {
            CHECK(fwp_poll_waits && !task->timed, 58); /* no artificial 10 ms timer */
            if (mode == 0) CHECK(fwp_socket_send(peer, "x", 1, 0) == 1, 59);
            if (mode == 1) { fwp_socket_close(peer); peer = FWP_INVALID_SOCKET; }
            if (mode == 2) { fwp_fd_closing(read_fd); fwp_socket_close(read_fd); read_fd = FWP_INVALID_SOCKET; }
            if (mode == 3) fwp_cancel_tree(task);
        }
        fwp_join_children();
        CHECK(read_result == (mode == 3 ? -1 : mode == 4 ? 0 : 1), 60);
        CHECK(!fwp_poll_waits && !fwp_poll_fds && !fwp_poll_cap && !fwp_io_waiting, 61);
        if (mode <= 1) {
            char byte;
            CHECK(fwp_socket_recv(read_fd, &byte, 1, 0) == (mode == 0 ? 1 : 0), 62);
        }
        if (read_fd != FWP_INVALID_SOCKET) { fwp_fd_closing(read_fd); fwp_socket_close(read_fd); }
        if (peer != FWP_INVALID_SOCKET) fwp_socket_close(peer);
    }
    fwp_tasks_finish(); fwp_sockets_finish();
    puts("socket batches, real deadlines, preemption, close and cancellation passed");
    return 0;
}
