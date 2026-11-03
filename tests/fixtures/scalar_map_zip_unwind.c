static int scalar_recover(void) { return 1; }
static fwp_task scalar_task;
int main(void) {
    fwp_prog_out = stdout;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    for (int round = 0; round < 16; round++) {
        for (volatile int mode = 0; mode < 9; mode++) for (unsigned aliases = 0; aliases < 4; aliases++) {
            double baseline = fwp_heap.live;
            V xs=0, other=0;
            for (int i=3; i>0; i--) {
                xs=fwp_rc_fresh(fwp_cons((V)i,xs));
                other=fwp_rc_fresh(fwp_cons((V)(i*10),other));
            }
            if(aliases&1) fwp_rc_dup(xs);
            if(aliases&2) fwp_rc_dup(other);
            scalar_mode=mode; scalar_stage=scalar_maps=scalar_zips=scalar_nodes=scalar_fail_allocation=0;
            jmp_buf jump;
            fwp_trap_recover=scalar_recover; fwp_trap_jb=&jump; fwp_trap_cleanup=0;
            memset(&scalar_task,0,sizeof scalar_task);
            int cancel=mode==3 || mode==4;
            if(cancel) { scalar_task.base=&jump; fwp_cur=&scalar_task; fwp_budget=1000000; }
            if(!setjmp(jump)) {
                V result=TRANSFORM(mode==1 ? FWP_TRUE : FWP_FALSE,xs,other);
                if(mode!=8) return 240;
                V cursor=result;
                for(int i=1;i<=3;i++) {
                    if(!cursor || OBJ(cursor)->f[0]!=(V)(9*i-1)) return 245;
                    cursor=OBJ(cursor)->f[1];
                }
                if(cursor) return 246;
                DROP_LIST(result);
            } else if(mode==8) return 247;
            fwp_cur=NULL; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
            scalar_fail_allocation=0;
            if(fwp_cleanups || (cancel && !scalar_task.unwinding)) return 241;
            int maps=mode==5 ? 0 : (mode==0 || mode==3) ? 2 : 3;
            int zips=(mode==2 || mode==4) ? 2 : (mode==7 || mode==8) ? 3 : 0;
            if(scalar_maps!=maps || scalar_zips!=zips) return 242;
            if(aliases&1) {
                if(*fwp_rc_slot(xs)!=1 || OBJ(xs)->f[0]!=1) return 243;
                DROP_LIST(xs);
            }
            if(aliases&2) {
                if(*fwp_rc_slot(other)!=1 || OBJ(other)->f[0]!=10) return 244;
                DROP_LIST(other);
            }
            if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len) return 90;
        }
    }
    puts("scalar map, zip, allocation and cancellation cleanup verified");
    return 0;
}
