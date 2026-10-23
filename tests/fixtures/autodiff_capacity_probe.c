static void *capacity_owned[16];
static size_t capacity_calls,capacity_fail,capacity_live;
static int capacity_oversized,capacity_exit_code;
static jmp_buf capacity_oom,capacity_trap;
static V capacity_base;
static fwp_tape *capacity_registry;
static fwp_tape_scope capacity_scope = {-1};
static fwp_cleanup capacity_scope_owner;
static void *capacity_realloc(void *old,size_t n) {
    capacity_calls++;
    if(n>4096){capacity_oversized=1;return 0;}
    if(capacity_fail && capacity_calls==capacity_fail)return 0;
    size_t slot=0;
    if(old){while(slot<16 && capacity_owned[slot]!=old)slot++;if(slot==16)abort();}
    else {while(slot<16 && capacity_owned[slot])slot++;if(slot==16)abort();}
    void *next=realloc(old,n);if(!next)abort();
    capacity_owned[slot]=next;if(!old)capacity_live++;
    return next;
}
static void capacity_free(void *p) {
    if(!p)return;
    size_t slot=0;while(slot<16 && capacity_owned[slot]!=p)slot++;
    if(slot==16)abort();capacity_owned[slot]=0;capacity_live--;free(p);
}
static void capacity_exit(int code){capacity_exit_code=code;longjmp(capacity_oom,1);}
static int capacity_recover(void){return 1;}
static void capacity_dispose(void) {
    for(int64_t i=0;i<fwp_ntapes;i++){
        fwp_tape *t=&fwp_tapes[i];fwp_tape_unlink_scope(t);capacity_free(t->pa);capacity_free(t->da);
    }
    capacity_free(fwp_tapes);fwp_tapes=0;fwp_ntapes=fwp_tapes_cap=0;
    fwp_tape_next_slot=0;
    capacity_calls=capacity_fail=0;capacity_exit_code=capacity_oversized=0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    fwp_cleanup_push(&capacity_scope_owner,fwp_tape_scope_release,&capacity_scope);
    fwp_trap_recover=capacity_recover;fwp_trap_jb=&capacity_trap;fwp_trap_cleanup=&capacity_scope_owner;
    static int round;
    for(round=0;round<32;round++) {
    if(fwp_tape_limit()!=INT32_MAX/8)return 180;
    if(!setjmp(capacity_trap)){fwp_p_ad_tape((V)(fwp_tape_limit()+1));return 182;}
    if(strcmp(fwp_trap_msg,"autodiff: too many inputs") || capacity_calls || capacity_live)return 182;
    /* Both paired-buffer failures must free the last owned pointer, including successful
     * earlier reallocs. No giant allocations are performed by this probe. */
    for(capacity_fail=1;capacity_fail<=2;capacity_fail++) {
        size_t selected=capacity_fail;capacity_fail=0;
        capacity_base=fwp_p_ad_tape(1);
        fwp_tape_reserve(fwp_tape_of((int64_t)capacity_base>>32),1);
        capacity_calls=0;capacity_fail=selected;
        if(!setjmp(capacity_oom)){fwp_tape_reserve(fwp_tape_of((int64_t)capacity_base>>32),65);return 183;}
        if(capacity_exit_code!=102 || capacity_oversized || capacity_live!=1 || fwp_tapes[0].live ||
           fwp_tapes[0].pa || fwp_tapes[0].pb || fwp_tapes[0].da || fwp_tapes[0].db)return 184;
        selected=capacity_fail;capacity_dispose();capacity_fail=selected;
    }
    capacity_fail=0;capacity_base=fwp_p_ad_tape(1);capacity_registry=fwp_tapes;
    fwp_tape_reserve(capacity_registry,1);
    capacity_calls=0;capacity_fail=1;
    if(!setjmp(capacity_oom)){fwp_p_ad_tape(1);return 185;}
    if(capacity_exit_code!=102 || fwp_tapes!=capacity_registry || fwp_ntapes!=1 || fwp_tapes_cap!=1 || fwp_tape_next_slot!=1 || capacity_live!=3 ||
       fwp_tape_of((int64_t)capacity_base>>32)!=capacity_registry)return 186;
    capacity_fail=0;capacity_calls=0;
    if(!setjmp(capacity_trap)){fwp_tape_reserve(capacity_registry,fwp_tape_limit()+1);return 187;}
    if(strcmp(fwp_trap_msg,"autodiff: the tape is full") || capacity_calls || capacity_oversized)return 188;
    capacity_dispose();if(capacity_live)return 189;
    if(capacity_scope.head!=-1 || fwp_cleanups!=&capacity_scope_owner)return 190;
    }
    fwp_cleanup_pop(&capacity_scope_owner);fwp_tape_scope_release(&capacity_scope);
    fwp_trap_cleanup=0;fwp_trap_recover=0;fwp_trap_jb=0;
    puts("checked tape capacities and exact realloc failure ownership passed");return 0;
}
