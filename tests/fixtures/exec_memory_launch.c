#define _GNU_SOURCE
#include <signal.h>
#include <stdlib.h>
#include <sys/prctl.h>
#include <sys/ptrace.h>
#include <unistd.h>

/* Run only as the observer's child. No application code or registers change. */
int main(int argc, char **argv) {
    if (argc < 3) return 120;
    char *end;
    long parent = strtol(argv[1], &end, 10);
    if (*end || parent <= 1) return 121;
    if (prctl(PR_SET_PDEATHSIG, SIGKILL) || getppid() != parent) return 122;
    if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) || raise(SIGSTOP)) return 123;
    execv(argv[2], argv + 2);
    return 124;
}
