static int dns_left;
static jmp_buf dns_jump;
static int dns_recover(void) { return 1; }
static void dns_allocation(void) {
    if(dns_left>0 && !--dns_left) fwp_trap("injected DNS allocation failure");
}
int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    size_t initial_live_bytes=fwp_heap.live;
    V host=fwp_rc_fresh(fwp_cstr("synthetic.invalid"));
    int failures=0,completed=0;
    for(int allocation=1;allocation<=163;allocation++) {
        size_t live_bytes=fwp_heap.live;
        fwp_trap_recover=dns_recover; fwp_trap_jb=&dns_jump;
        fwp_trap_cleanup=fwp_cleanups; dns_left=allocation;
        if(!setjmp(dns_jump)) {
            V result=fwp_p_dns_resolve(host,DNS_ERROR,DNS_LIST);
            dns_left=0;
            V cursor=result;
            for(int i=0;i<81;i++) {
                if(!cursor) return 247;
                char expected[64];
                if(i==80) strcpy(expected,"::1");
                else snprintf(expected,sizeof expected,"127.0.0.%d",i+1);
                V text=OBJ(cursor)->f[0];
                if(STR(text)->len!=strlen(expected) || memcmp(STR(text)->d,expected,strlen(expected))) return 247;
                cursor=OBJ(cursor)->f[1];
            }
            if(cursor) return 247;
            DNS_LIST->drop(result); completed=1;
        } else failures++;
        dns_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        if(dns_os_live || fwp_cleanups || fwp_heap.live!=live_bytes) {
            fprintf(stderr,"DNS request %d: OS live %d, charged delta %lld, pending cleanup %d\n",
                    allocation,dns_os_live,(long long)(fwp_heap.live - live_bytes),fwp_cleanups!=NULL);
            return 248;
        }
        if(!fwp_rc_last(host)) return 249;
        if(completed) break;
    }
    if(!completed || failures!=162) return 247;
    if(fwp_rc_release_last(host)) fwp_rc_resource_free_obj(host);
    if(fwp_heap.live!=initial_live_bytes) return 248;
    printf("DNS: 81 unique addresses; 162 managed requests; all injected failures clean; final managed/native storage 0\n");
    return 0;
}
