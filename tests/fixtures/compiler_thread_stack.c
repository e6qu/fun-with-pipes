/* Isolate pthread stack reservation from Rust and fwp's type checker. */
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

static void *worker(void *value) {
    void *block = malloc(56);
    if (!block) abort();
    *(volatile unsigned char *)block = 1;
    free(block);
    return value;
}

int main(int argc, char **argv) {
    if (argc != 2) return 64;
    char *end;
    unsigned long size = strtoul(argv[1], &end, 10);
    if (*end || (size != 256 && size != 4096)) return 64;
    pthread_attr_t attr;
    int init = pthread_attr_init(&attr);
    if (init) return 1;
    int setting = pthread_attr_setstacksize(&attr, size * 1024 * 1024);
    pthread_t thread;
    int creation = setting ? setting : pthread_create(&thread, &attr, worker, NULL);
    int joining = creation ? -1 : pthread_join(thread, NULL);
    int destroying = pthread_attr_destroy(&attr);
    printf("stack_mib=%zu setting=%d creation=%d joining=%d destroying=%d\n",
           (size_t)size, setting, creation, joining, destroying);
    return creation || joining || destroying ? 2 : 0;
}
