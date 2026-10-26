static int matrix_mode;
static jmp_buf matrix_recovered;
static fwp_task matrix_cancelled;
static int matrix_recover(void){return 1;}
static void matrix_probe_tick(void){
    if(matrix_mode==1)fwp_trap("matrix unwind control");
    if(matrix_mode==2)fwp_check_cancel();
}
int main(void){
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_trap_recover=matrix_recover;fwp_trap_jb=&matrix_recovered;fwp_trap_cleanup=0;
    const fwp_desc scalar={.kind=K_F64};
    V left=fwp_rc_fresh(fwp_array_new_packed(33*35,&scalar));
    V right=fwp_rc_fresh(fwp_array_new_packed(35*31,&scalar));
    for(size_t i=0;i<33*35;i++)fwp_array_store(left,i,fwp_from_f64(1.0),&scalar);
    for(size_t i=0;i<35*31;i++)fwp_array_store(right,i,fwp_from_f64(2.0),&scalar);
    for(matrix_mode=1;matrix_mode<=2;matrix_mode++){
        double freed=fwp_heap.freed;
        if(matrix_mode==1){
            if(!setjmp(matrix_recovered)){fwp_p_matrix_mul_f64(33,35,31,left,right);return 216;}
            if(strcmp(fwp_trap_msg,"matrix unwind control"))return 218;
        }else{
            memset(&matrix_cancelled,0,sizeof(matrix_cancelled));matrix_cancelled.cancelled=1;fwp_cur=&matrix_cancelled;
#ifdef _WIN32
            /* This synthetic task executes on the main thread stack. */
            matrix_cancelled.ctx.top=fwp_heap.main_top;
#endif
            jmp_buf matrix_cancelled_base; matrix_cancelled.base = &matrix_cancelled_base;
            if (!setjmp(matrix_cancelled_base)){fwp_p_matrix_mul_f64(33,35,31,left,right);return 219;}
            matrix_cancelled.base=NULL;fwp_cur=0;if(!matrix_cancelled.unwinding)return 220;
        }
        if(fwp_heap.freed-freed<8+33*31*8)return 217;
        if(fwp_cleanups || fwp_array_len(left)!=33*35 || fwp_array_len(right)!=35*31)return 221;
        if(fwp_f64(fwp_array_load(left,0,&scalar))!=1.0 || fwp_f64(fwp_array_load(right,0,&scalar))!=2.0)return 222;
    }
    fwp_rc_free_arr(left);fwp_rc_free_arr(right);return 0;
}
