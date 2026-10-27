static jmp_buf projection_failure;
static int projection_recover(void) { return 1; }
static double projection_charge(void) {
    return (double)fwp_heap.live;
}
static V projection_input(void) {
    V text=fwp_rc_fresh(fwp_cstr("kept"));
    /* Scalar bits deliberately resemble a managed pointer. */
    V pair=fwp_rc_fresh(fwp_record(2,(V[]){text,text}));
    return fwp_rc_fresh(fwp_data(0,1,&pair));
}
static void projection_drop_text(V text) {
    if(fwp_rc_release_last(text))fwp_rc_free_arr(text);
}
static int projection_text(V text) {
    return STR(text)->len==4&&!memcmp(STR(text)->d,"kept",4);
}
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
    if(!fwp_fns[0].owned||!fwp_fns[0].owned->drop_arguments)return 200;
    double before=projection_charge();
    for(int shared=0;shared<2;shared++)for(int repeat=0;repeat<64;repeat++) {
        V input=projection_input();if(shared)fwp_rc_dup(input);
        projection_retains=0;
        V result=f0(input);
        if(!projection_text(result))return 201;
        if(projection_retains!=(size_t)(shared?2:1)) {
            fprintf(stderr,"shared=%d retains=%zu\n",shared,projection_retains);return 202;
        }
        if(*fwp_rc_slot(result)!=(shared?2:1))return 203;
        projection_drop_text(result);
        if(shared) {
            V pair=OBJ(input)->f[0],text=OBJ(pair)->f[1];
            if(*fwp_rc_slot(text)!=1||!projection_text(text))return 204;
            fwp_fns[0].owned->drop_arguments(&input,0,1);
        }
        if(projection_charge()!=before)return 205;
        if(fwp_cleanups)return 206;
    }
    fwp_trap_recover=projection_recover;fwp_trap_jb=&projection_failure;fwp_trap_cleanup=fwp_cleanups;
    for(int repeat=0;repeat<64;repeat++) {
        V input=projection_input();
        if(!setjmp(projection_failure)){(void)f2(input);return 207;}
        if(fwp_cleanups||strcmp(fwp_trap_msg,"kept"))return 208;
        if(projection_charge()!=before)return 209;
    }
    return 0;
}
