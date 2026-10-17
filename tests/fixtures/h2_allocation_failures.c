/* SOCKET_RUNTIME */
#include <stdlib.h>
#include <stdint.h>
#include <setjmp.h>
static void *allocation_malloc(size_t);
static void *allocation_realloc(void *,size_t);
static void allocation_free(void *);
static void allocation_exit(int);
#define malloc allocation_malloc
#define realloc allocation_realloc
#define free allocation_free
#define _Exit allocation_exit
/* H2_RUNTIME */
#undef malloc
#undef realloc
#undef free
#undef _Exit
static void *live[128];
static int fail_at,allocations,caught;
static jmp_buf failure;
static int slot(void *p) { for(int i=0;i<128;i++)if(live[i]==p)return i;_Exit(246); }
static void *allocation_malloc(size_t n) {
    if(++allocations==fail_at)return NULL;
    void *p=malloc(n);if(!p)_Exit(245);live[slot(NULL)]=p;return p;
}
static void *allocation_realloc(void *p,size_t n) {
    if(++allocations==fail_at)return NULL;
    int i=slot(p);void *q=realloc(p,n);if(!q)_Exit(245);live[i]=q;return q;
}
static void allocation_free(void *p) { if(p){live[slot(p)]=NULL;free(p);} }
static void allocation_exit(int code) { if(code!=102)_Exit(247);caught++;longjmp(failure,1); }
static int none_live(void) {for(int i=0;i<128;i++)if(live[i])return 0;return 1;}
int main(void) {
    for(int existing=0;existing<2;existing++)for(int nth=1;nth<=3;nth++) {
        static h2_hdrs h;memset(&h,0,sizeof h);fail_at=0;
        if(existing)for(int i=0;i<8;i++)h2_hdrs_add(&h,"old",3,"value",5);
        allocations=caught=0;fail_at=nth;
        if(!setjmp(failure)){h2_hdrs_add(&h,"new",3,"copy",4);return 247;}
        if(caught!=1||h.n!=(existing?8:0))return 247;
        for(size_t i=0;i<h.n;i++)if(strcmp(h.v[i].name,"old")||strcmp(h.v[i].value,"value"))return 247;
        fail_at=0;h2_hdrs_free(&h);if(!none_live())return 248;
    }
    // A failed resize preserves the old allocation and its contents.
    static h2_buf b;allocations=fail_at=0;h2b_put(&b,"kept",4);
    unsigned char *before=b.d;size_t capacity=b.cap;allocations=0;fail_at=1;caught=0;
    if(!setjmp(failure)){h2b_reserve(&b,1024);return 247;}
    if(caught!=1||b.d!=before||b.cap!=capacity||b.len!=4||memcmp(b.d,"kept",4))return 247;
    fail_at=0;h2b_free(&b);if(!none_live())return 248;
    // Synthetic impossible sizes fail before reading input or asking the allocator.
    for(int which=0;which<4;which++) {
        allocations=caught=0;
        h2_hdrs h={0};h2_buf huge={.len=SIZE_MAX-7,.cap=SIZE_MAX-7};
        if(which==2)h.n=h.cap=SIZE_MAX/sizeof(h2_hdr);
        if(!setjmp(failure)) {
            if(which==3)h2b_reserve(&huge,8);
            else h2_hdrs_add(&h,"",which==0?SIZE_MAX:0,"",which==1?SIZE_MAX:0);
            return 247;
        }
        if(caught!=1||allocations||!none_live())return 248;
    }
    puts("6 header allocation failures, 1 resize failure and 4 size overflows: preserved storage, no temporary leaks");
    return 0;
}
