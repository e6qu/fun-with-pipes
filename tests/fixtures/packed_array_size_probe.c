#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
typedef uint64_t V;
typedef struct { uint64_t len; V d[]; } fwp_arr;
typedef struct { size_t width; int numeric; } fwp_desc;
#define PTR(p) ((V)(uintptr_t)(p))
static size_t requested;
static void *fwp_alloc(size_t n) {
    if(n>256)exit(130);
    requested=n;void *p=malloc(256);if(!p)exit(102);return p;
}
static void *fwp_alloc_leaf(size_t n) { return fwp_alloc(n); }
static size_t fwp_array_stride(const fwp_desc *elem) { return elem->width; }
static int fwp_array_numeric(const fwp_desc *elem) { return elem->numeric; }
static void fwp_trap(const char *message) {
    if(strcmp(message,"array too large"))exit(131);exit(1);
}
/* ARRAY_CONSTRUCTOR */
int main(int argc,char **argv) {
    if(argc!=2)return 133;
    fwp_desc elem={(size_t)strtoul(argv[1],0,10),1};
    fwp_arr *a=(fwp_arr *)(uintptr_t)fwp_array_new_packed(3,&elem);
    if(a->len!=3 || requested!=sizeof(fwp_arr)+3*elem.width)return 132;
    free(a);
    size_t limit_width=elem.width>sizeof(V)?elem.width:sizeof(V);
    a=(fwp_arr *)(uintptr_t)fwp_array_new_packed((SIZE_MAX-sizeof(fwp_arr))/limit_width+1,&elem);
    free(a);return 129;
}
