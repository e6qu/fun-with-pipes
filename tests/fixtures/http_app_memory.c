/* Test-only observation: selected cleartext HTTP/1 API, eight connections per
   cohort. Charge excludes allocator pages, task stacks and raw C buffers.
   Metric names/table are measured separately; the driver also samples RSS. */
static double http_app_start, http_app_baseline;
static size_t http_app_metric_baseline;
static unsigned http_app_busy;
static double http_app_charge(void) {
    return (double)fwp_heap.live;
}
static size_t http_app_metric_bytes(void) {
    size_t bytes = fwp_metrics_cap * sizeof(fwp_metric);
    for (size_t i = 0; i < fwp_nmetrics; i++) bytes += fwp_metrics[i].len + 1;
    return bytes;
}
static void http_app_checkpoint(void) {
    /* Shutdown must drain tasks without waiting for another sampling handshake. */
    if (fwp_shutdown) return;
    if (!http_app_opened || http_app_opened == http_app_sampled) return;
    size_t tasks = 0;
    for (fwp_task *t = fwp_tasks_active; t; t = t->all_next) tasks++;
    /* Only the listener task remains; completed connection tasks have retired. */
    if (tasks != 1 || http_app_opened % 8) {
        if (++http_app_busy % 10 == 0) {
            fprintf(stderr, "http-wait\t%llu\t%llu\t%zu\n", http_app_opened, http_app_closed, tasks);
            int64_t now = fwp_now_ns();
            for (fwp_task *t = fwp_tasks_active; t; t = t->all_next) {
                if (t == http_app_listener) continue;
                fprintf(stderr, "http-wait-task\tdone=%d cancelled=%d ready=%d timed=%d timed_out=%d io_ready=%d children=%d wait_list=%d deadline_ms=%lld wake_ms=%lld\n",
                    t->done, t->cancelled, t->ready, t->timed, t->timed_out, t->io_ready,
                    t->first_child != NULL, t->wl != NULL,
                    (long long)(t->deadline ? (t->deadline-now)/1000000 : 0),
                    (long long)(t->wake_at ? (t->wake_at-now)/1000000 : 0));
            }
#if !defined(__linux__) && !defined(FWP_FIBERS)
            for (fwp_poll_wait *w = fwp_poll_waits; w; w = w->next) {
                if (w->task == http_app_listener) continue;
                fprintf(stderr, "http-wait-io\tfd=%llu events=%d ready=%d\n",
                    (unsigned long long)w->fd, w->events, w->task->ready);
            }
#endif
            fflush(stderr);
        }
        return;
    }
    http_app_busy = 0;
    double charge = http_app_charge() - http_app_start;
    size_t metrics = http_app_metric_bytes();
    if (!http_app_active) {
        http_app_listener = fwp_cur;
        http_app_baseline = charge;
        http_app_metric_baseline = metrics;
    }
    fprintf(stderr, "http-memory\t%llu\t%llu\t%.0f\t%zu\t%zu\t%zu\n",
        http_app_opened, http_app_closed, charge, tasks, metrics, fwp_heap.ncollect);
    fflush(stderr);
    if (http_app_opened != http_app_sampled + 8 || http_app_closed != http_app_opened ||
        charge != http_app_baseline || metrics != http_app_metric_baseline ||
        fwp_heap.enabled || fwp_heap.ncollect) {
        fprintf(stderr, "http-memory changed\n");
        exit(241);
    }
    http_app_sampled = http_app_opened;
    http_app_active = 1;
    /* The driver samples resident memory before releasing the next cohort. */
    if (getchar() != '\n') exit(240);
}
static void http_app_finish(void) {
    double charge = http_app_charge() - http_app_start;
    fprintf(stderr, "http-shutdown\t%u\n", http_app_shutdown_cancelled);
    fprintf(stderr, "http-final\t%llu\t%llu\t%.0f\t%zu\n",
        http_app_opened, http_app_closed, charge, http_app_metric_bytes());
    if (!http_app_active || http_app_shutdown_cancelled != 1 || http_app_opened != http_app_closed || charge ||
        http_app_metric_bytes() != http_app_metric_baseline || fwp_tasks_active || fwp_heap.ncollect) exit(241);
    /* Executable metrics storage is released by its existing atexit callback;
       its separate final record must follow this pre-teardown observation. */
}
