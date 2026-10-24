/* Isolate pthread stack reservation from Rust and fwp's type checker. */
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

static void *worker(void *value) {
    void *block = malloc(56);
    if (!block) abort();
    free(block);
    return value;
}

int main(void) {
    const size_t sizes[] = {64, 256, 1024, 2048, 4096};
    for (size_t i = 0; i < sizeof(sizes) / sizeof(sizes[0]); ++i) {
        pthread_attr_t attr;
        int init = pthread_attr_init(&attr);
        if (init) return 1;
        int setting = pthread_attr_setstacksize(&attr, sizes[i] * 1024 * 1024);
        pthread_t thread;
        int creation = setting ? setting : pthread_create(&thread, &attr, worker, NULL);
        int joining = creation ? -1 : pthread_join(thread, NULL);
        int destroying = pthread_attr_destroy(&attr);
        printf("stack_mib=%zu setting=%d creation=%d joining=%d destroying=%d\n",
               sizes[i], setting, creation, joining, destroying);
        if (destroying || (!creation && joining)) return 2;
    }
    return 0;
}
