/* Observe OS wait arguments rather than imposing a noisy elapsed-time bound. */
static int poll_probe, poll_calls, poll_timeout;
static size_t poll_count;
static int observe_poll(fwp_pollfd *fds, size_t n, int timeout) {
    poll_calls++; poll_timeout = timeout; poll_count = n;
    if (!poll_probe) {
#ifdef _WIN32
        return WSAPoll(fds, (ULONG)n, timeout);
#else
        return poll(fds, (nfds_t)n, timeout);
#endif
    }
    if (poll_probe == 2) {
#ifdef _WIN32
        WSASetLastError(WSAEINTR);
#else
        errno = EINTR;
#endif
        return -1;
    }
    if (poll_probe == 3) {
#ifdef _WIN32
        WSASetLastError(WSAENETDOWN);
#else
        errno = EBADF;
#endif
        return -1;
    }
    int ready = 0;
    for (size_t i = 0; i < n; i++) {
        size_t id = (size_t)fds[i].fd - 100;
        if (id >= 40 || (i && fds[i].fd <= fds[i-1].fd)) _Exit(39);
        short requested = id % 2 ? POLLWRNORM : POLLRDNORM;
        if (fds[i].events != requested || fds[i].revents) _Exit(40);
        fds[i].revents = id % 3 == 0 ? requested : 0;
        ready += !!fds[i].revents;
    }
    return ready;
}
