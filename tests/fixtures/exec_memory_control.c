#define _GNU_SOURCE
#include <signal.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <unistd.h>

static void *sleeper(void *argument) {
    (void)argument;
    usleep(20000);
    return NULL;
}

int main(int argc, char **argv) {
    if (argc != 2) return 110;
    if (!strcmp(argv[1], "sleep")) { sleep(10); return 0; }
    if (!strcmp(argv[1], "thread") || !strcmp(argv[1], "exit-with-worker")) {
        pthread_t worker;
        if (pthread_create(&worker, NULL, sleeper, NULL)) return 119;
        if (!strcmp(argv[1], "exit-with-worker")) return 0;
        return pthread_join(worker, NULL) ? 120 : 0;
    }
    if (!strcmp(argv[1], "fork")) {
        pid_t child = fork();
        if (child < 0) return 111;
        sleep(10);
        return 0;
    }
    if (!strcmp(argv[1], "signal")) { raise(SIGTERM); return 112; }
    const size_t bytes = 32 * 1024 * 1024;
    volatile unsigned char *data = mmap(NULL, bytes, PROT_READ | PROT_WRITE,
                                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (data == MAP_FAILED) return 113;
    if (strcmp(argv[1], "untouched"))
        for (size_t i = 0; i < bytes; i += 4096) data[i] = 1;
    struct rusage usage;
    if (getrusage(RUSAGE_SELF, &usage)) return 114;
    printf("control-peak-kib\t%ld\n", usage.ru_maxrss);
    if (fflush(stdout)) return 115;
    if (!strcmp(argv[1], "exec")) {
        execl("/bin/true", "true", (char *)NULL);
        return 116;
    }
    if (strcmp(argv[1], "transient") && strcmp(argv[1], "untouched")) return 117;
    if (munmap((void *)data, bytes)) return 118;
    return 0;
}
