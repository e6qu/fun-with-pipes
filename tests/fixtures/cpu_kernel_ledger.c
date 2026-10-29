/* Test-only requested native bytes, excluding these accounting headers. */
#include <stdatomic.h>
typedef union { max_align_t align; size_t bytes; } kernel_header;
static _Atomic size_t kernel_live, kernel_peak, kernel_requests;
static int kernel_managed_requests, kernel_managed_left;
static int kernel_thread_attempts, kernel_thread_fail, kernel_thread_started, kernel_thread_joined;
static void *kernel_malloc(size_t bytes) {
    size_t n=bytes ? bytes : 1;
    kernel_header *h=malloc(sizeof *h+n);
    if(!h) exit(102);
    h->bytes=n;
    atomic_fetch_add(&kernel_requests,1);
    size_t live=atomic_fetch_add(&kernel_live,n)+n, peak=atomic_load(&kernel_peak);
    while(live>peak && !atomic_compare_exchange_weak(&kernel_peak,&peak,live)) {}
    return h+1;
}
static void kernel_free(void *p) {
    if(p) { kernel_header *h=(kernel_header *)p-1;atomic_fetch_sub(&kernel_live,h->bytes);free(h); }
}
static void kernel_allocation(void) {
    kernel_managed_requests++;
    if(kernel_managed_left>0 && !--kernel_managed_left) fwp_trap("injected kernel allocation failure");
}
#ifdef _WIN32
static HANDLE kernel_create(LPSECURITY_ATTRIBUTES attr, SIZE_T size, LPTHREAD_START_ROUTINE entry,
        LPVOID arg, DWORD flags, LPDWORD id) {
    if(++kernel_thread_attempts==kernel_thread_fail) return NULL;
    HANDLE thread=CreateThread(attr,size,entry,arg,flags,id);
    if(thread) kernel_thread_started++;
    return thread;
}
static DWORD kernel_join(HANDLE thread, DWORD timeout) {
    DWORD result=WaitForSingleObject(thread,timeout);
    if(result==WAIT_OBJECT_0) kernel_thread_joined++;
    return result;
}
#else
static int kernel_create(pthread_t *thread, const pthread_attr_t *attr,
        void *(*entry)(void *), void *arg) {
    if(++kernel_thread_attempts==kernel_thread_fail) return EAGAIN;
    int result=pthread_create(thread,attr,entry,arg);
    if(!result) kernel_thread_started++;
    return result;
}
static int kernel_join(pthread_t thread, void **result) {
    int status=pthread_join(thread,result);
    if(!status) kernel_thread_joined++;
    return status;
}
#endif
#if defined(FWP_STATIC_MEMORY) && !defined(_WIN32)
static int kernel_attr_attempts, kernel_attr_failure, kernel_attr_live, kernel_attr_destroyed;
static int kernel_attr_init(pthread_attr_t *attribute) {
    if (++kernel_attr_attempts == 2 && kernel_attr_failure == 1) return ENOMEM;
    int status = pthread_attr_init(attribute);
    if (!status) kernel_attr_live++;
    return status;
}
static int kernel_attr_setstack(pthread_attr_t *attribute, void *address, size_t size) {
    if (kernel_attr_attempts == 2 && kernel_attr_failure == 2) return EINVAL;
    return pthread_attr_setstack(attribute, address, size);
}
static int kernel_attr_destroy(pthread_attr_t *attribute) {
    int status = pthread_attr_destroy(attribute);
    if (!status) { kernel_attr_live--; kernel_attr_destroyed++; }
    return status;
}
#endif
