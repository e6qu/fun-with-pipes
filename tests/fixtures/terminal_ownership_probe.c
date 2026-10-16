static int terminal_test_failure;
static jmp_buf terminal_test_jump;
static int terminal_test_recover(void) { return 1; }
static int terminal_test_echo(void) {
#ifdef _WIN32
    DWORD mode;
    if (!GetConsoleMode((HANDLE)_get_osfhandle(0), &mode)) _Exit(246);
    return (mode & ENABLE_ECHO_INPUT) != 0;
#else
    struct termios mode;
    if (tcgetattr(0, &mode)) _Exit(246);
    return (mode.c_lflag & ECHO) != 0;
#endif
}
static V terminal_test_read(void) {
    if (terminal_test_echo()) _Exit(247);
    if (terminal_test_failure) fwp_trap("terminal read construction failure");
    return FWP_NONE;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
#ifdef _WIN32
    FreeConsole();
    if (!AllocConsole()) return 248;
    HANDLE input = CreateFileW(L"CONIN$", GENERIC_READ | GENERIC_WRITE,
        FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL);
    if (input == INVALID_HANDLE_VALUE) return 249;
    int fd = _open_osfhandle((intptr_t)input, _O_BINARY);
    if (fd < 0 || _dup2(fd, 0)) return 250;
    if (fd != 0) _close(fd);
    DWORD mode;
    if (!GetConsoleMode((HANDLE)_get_osfhandle(0), &mode) ||
        !SetConsoleMode((HANDLE)_get_osfhandle(0), mode | ENABLE_ECHO_INPUT)) return 251;
#else
    int master = posix_openpt(O_RDWR | O_NOCTTY);
    if (master < 0 || grantpt(master) || unlockpt(master)) return 248;
    char *name = ptsname(master);
    if (!name) return 249;
    int input = open(name, O_RDWR | O_NOCTTY);
    if (input < 0 || dup2(input, 0) < 0) return 250;
    if (input != 0) close(input);
    struct termios mode;
    if (tcgetattr(0, &mode)) return 251;
    mode.c_lflag |= ECHO;
    if (tcsetattr(0, TCSAFLUSH, &mode)) return 251;
#endif
    if (fwp_p_term_is_tty((V)INT64_C(4294967296)) != FWP_FALSE ||
        fwp_p_term_is_tty((V)INT64_C(4294967297)) != FWP_FALSE ||
        fwp_p_term_is_tty((V)-1) != FWP_FALSE || fwp_p_term_is_tty(0) != FWP_TRUE) return 252;
    for (int repeat = 0; repeat < 16; repeat++) {
        terminal_test_failure = 0;
        if (fwp_p_term_read_secret() != FWP_NONE || !terminal_test_echo() || fwp_cleanups) return 253;
        terminal_test_failure = 1;
        fwp_trap_recover = terminal_test_recover; fwp_trap_jb = &terminal_test_jump; fwp_trap_cleanup = fwp_cleanups;
        if (!setjmp(terminal_test_jump)) { (void)fwp_p_term_read_secret(); return 254; }
        fwp_trap_recover = 0; fwp_trap_jb = 0; fwp_trap_cleanup = 0;
        if (!terminal_test_echo()) return 245;
        if (fwp_cleanups) return 253;
    }
#ifdef _WIN32
    _close(0); FreeConsole();
#else
    close(0); close(master);
#endif
    return 0;
}
