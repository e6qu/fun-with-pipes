static int range_recover(void) { return 1; }
static fwp_task range_task;
int main(void) {
    fwp_prog_out=stdout;
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    /* The enormous mathematical ranges are consumed by only three elements.
       No reference implementation is asked to allocate their full lists. */
    const int64_t bounds[][2] = {
        {INT64_MIN, INT64_MAX}, {INT64_MAX-3, INT64_MAX}, {-2, 2}, {5, 2}, {2, 2}
    };
    for(int round=0;round<8;round++) for(unsigned b=0;b<5;b++)
    for(volatile int mode=0;mode<6;mode++) for(unsigned alias=0;alias<2;alias++) {
        /* Empty ranges cannot reach callback or result-construction failures. */
        if(b>=3 && mode!=2 && mode!=5) continue;
        double baseline=fwp_heap.live;
        V xs=0;
        for(int i=3;i>0;i--) xs=fwp_rc_fresh(fwp_cons((V)(i*10),xs));
        if(alias) fwp_rc_dup(xs);
        range_mode=mode; range_stage=range_calls=range_nodes=range_fail_allocation=0;
        jmp_buf jump;
        fwp_trap_recover=range_recover; fwp_trap_jb=&jump; fwp_trap_cleanup=0;
        memset(&range_task,0,sizeof range_task);
        if(mode==1) { range_task.base=&jump; fwp_cur=&range_task; fwp_budget=1000000; }
        if(!setjmp(jump)) {
            V result=TRANSFORM((V)bounds[b][0],(V)bounds[b][1],7,xs);
            if(mode!=5) return 240;
            V cursor=result;
            int count=b>=3 ? 0 : 3;
            for(int i=0;i<count;i++) {
                if(!cursor) return 241;
                V value=OBJ(cursor)->f[0];
                uint64_t expected=(uint64_t)bounds[b][0]+(uint64_t)i;
                if(OBJ(value)->f[0]!=expected || OBJ(value)->f[1]!=(V)((i+1)*10+7)) return 242;
                cursor=OBJ(cursor)->f[1];
            }
            if(cursor) return 243;
            DROP_RESULT(result);
        } else if(mode==5) return 244;
        fwp_cur=NULL; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        range_fail_allocation=0;
        if(fwp_cleanups || (mode==1 && !range_task.unwinding)) return 245;
        int expected_calls=mode==2 || b>=3 ? 0 : (mode<=1 || mode==3) ? 2 : 3;
        if(range_calls!=expected_calls) return 246;
        if(alias) {
            if(*fwp_rc_slot(xs)!=1 || OBJ(xs)->f[0]!=10) return 247;
            DROP_INPUT(xs);
        }
        if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len) return 90;
    }
    puts("range bounds, numeric records, aliases and nonlocal cleanup verified");
    return 0;
}
