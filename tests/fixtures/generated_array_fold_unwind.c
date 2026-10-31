static int generated_interrupt,generated_steps;
static fwp_task generated_task;
static jmp_buf generated_jump;
static fwp_value_owner generated_outer;
static fwp_cleanup generated_cleanup;
static V generated_alias;
static void generated_drop(V value) {
    if(fwp_rc_release_last(value))fwp_rc_free_obj(value);
}
static int generated_recover(void) { return 1; }
static void generated_interrupt_step(void) {
    if(generated_steps++!=2)return;
    if(generated_interrupt==1)fwp_trap("injected generated fold failure");
    generated_task.cancelled=1;fwp_check_cancel();
}
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    const size_t baseline=fwp_heap.live;
    for(generated_interrupt=1;generated_interrupt<=2;generated_interrupt++) {
        generated_alias=fwp_rc_fresh(fwp_cstr("outer"));
        fwp_rc_dup(generated_alias);
        generated_outer=(fwp_value_owner){generated_alias,generated_drop};
        fwp_cleanup_push(&generated_cleanup,fwp_value_release,&generated_outer);
        generated_steps=0;
        if(generated_interrupt==1) {
            fwp_trap_recover=generated_recover;fwp_trap_jb=&generated_jump;fwp_trap_cleanup=0;
            if(!setjmp(generated_jump)){(void)fGENERATED(4);return 180;}
            fwp_trap_recover=0;fwp_trap_jb=0;
            if(strcmp(fwp_trap_msg,"injected generated fold failure"))return 181;
        } else {
            memset(&generated_task,0,sizeof generated_task);
            generated_task.base=&generated_jump;fwp_cur=&generated_task;fwp_budget=1000000;
            if(!setjmp(generated_jump)){(void)fGENERATED(4);return 182;}
            fwp_cur=0;generated_task.base=0;
            if(!generated_task.unwinding)return 183;
        }
        if(generated_steps!=3)return 184;
        if(fwp_cleanups || generated_outer.value || *fwp_rc_slot(generated_alias)!=1)
            return generated_interrupt==1?185:186;
        if(STR(generated_alias)->len!=5 || memcmp(STR(generated_alias)->d,"outer",5))return 187;
        generated_drop(generated_alias);generated_alias=0;
        if(fwp_heap.live!=baseline)return 188;
    }
    return 0;
}
