/* Change the host environment after ARC startup, before generated code runs. */
static void arc_corpus_late_option(void) {
    const char *late = getenv("FWP_CORPUS_LATE_POISON");
    if (!late || (strcmp(late, "0") && strcmp(late, "1"))) exit(194);
    if (!strcmp(late, "0")) return;
#ifdef _WIN32
    if (_putenv_s("FWP_REUSE_VERIFY", "1")) exit(195);
#else
    if (setenv("FWP_REUSE_VERIFY", "1", 1)) exit(195);
#endif
}
