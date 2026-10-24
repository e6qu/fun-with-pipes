/* Test-only observation: selected cleartext HTTP/1 API, eight connections per
   cohort. Charge excludes allocator pages, task stacks and raw C buffers.
   Metric names/table are measured separately; the driver also samples RSS. */
static double http_app_start, http_app_baseline;
static size_t http_app_metric_baseline;
static double http_app_charge(void) {
    return fwp_gc.total_alloc + (double)(fwp_gc.budget_given - fwp_gc.budget);
}
static size_t http_app_metric_bytes(void) {
    size_t bytes = fwp_metrics_cap * sizeof(fwp_metric);
    for (size_t i = 0; i < fwp_nmetrics; i++) bytes += fwp_metrics[i].len + 1;
    return bytes;
}
static void http_app_checkpoint(void) {
    /* Shutdown must drain tasks without waiting for another sampling handshake. */
    if (fwp_shutdown) return;
    if (!http_app_opened || http_app_opened == http_app_sampled || http_app_opened % 8) return;
    size_t tasks = 0;
    for (fwp_task *t = fwp_gc_tasks; t; t = t->gc_next) tasks++;
    /* Only the listener task remains; completed connection tasks have retired. */
    if (tasks != 1) return;
    double charge = http_app_charge() - http_app_start;
    size_t metrics = http_app_metric_bytes();
    if (!http_app_active) {
        http_app_listener = fwp_cur;
        http_app_baseline = charge;
        http_app_metric_baseline = metrics;
    }
    fprintf(stderr, "http-memory\t%llu\t%llu\t%.0f\t%zu\t%zu\t%zu\n",
        http_app_opened, http_app_closed, charge, tasks, metrics, fwp_gc.ncollect);
    fflush(stderr);
    if (http_app_opened != http_app_sampled + 8 || http_app_closed != http_app_opened ||
        charge != http_app_baseline || metrics != http_app_metric_baseline ||
        fwp_gc.enabled || fwp_gc.ncollect) {
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
        http_app_metric_bytes() != http_app_metric_baseline || fwp_gc_tasks || fwp_gc.ncollect) exit(241);
    /* Executable metrics storage is released by its existing atexit callback;
       its separate final record must follow this pre-teardown observation. */
}
