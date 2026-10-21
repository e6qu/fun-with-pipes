/* The sample keeps the service listening. Its socket-wait storage is created
 * lazily, after the readiness baseline. Account only for that actual owner;
 * do not subtract a guessed byte allowance or dispose production owners here. */
static size_t response_listener_charge(void) {
    if(fwp_cur != fwp_root || fwp_io_waiting != 1)_Exit(204);
#ifdef __linux__
    if(response_listener_fd >= fwp_nfdws || fwp_live_fdws != 1)_Exit(204);
    for(size_t i=0;i<fwp_nfdws;i++)
        if(i != response_listener_fd && fwp_fdws[i])_Exit(204);
    fwp_fdw *wait = fwp_fdws[response_listener_fd];
    if(!wait || wait->rd.head != fwp_root || wait->wr.head)_Exit(204);
    return server_storage_charge(fwp_fdws) + server_storage_charge(wait);
#elif !defined(FWP_FIBERS)
    fwp_poll_wait *wait = fwp_poll_waits;
    if(!wait || wait->next || wait->task != fwp_root ||
       (uintptr_t)wait->fd != response_listener_fd || !fwp_poll_fds)_Exit(204);
    return server_storage_charge(fwp_poll_fds);
#else
#error "This probe measures a native gRPC listener"
#endif
}
