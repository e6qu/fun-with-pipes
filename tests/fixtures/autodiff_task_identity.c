/* Exercise task identity below language admission, with real tape construction
 * and task IDs. An ordinary program cannot send these derivatives to a worker. */
static const fwp_desc identity_element={.kind=K_I64};
int main(int argc,char **argv) {
#ifdef _WIN32
    if (_setmode(_fileno(stderr), _O_BINARY) < 0) return 193;
#endif
    if(argc!=2)return 190;
    int mode=atoi(argv[1]); /* 0: root startup, 1: cross-task, 2: retired task */
    if(mode<0 || mode>2)return 190;
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    if(mode)fwp_tasks_init();
    size_t baseline=fwp_heap.live;
    fwp_tape_scope scope={-1};fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup,fwp_tape_scope_release,&scope);
    fwp_task *worker=NULL;
    if(mode==2){worker=fwp_task_new();fwp_cur=worker;}
    V parameters=fwp_rc_fresh(fwp_record(4,(V[4]){0,0,0,0}));
    V inputs=fwp_rc_fresh(fwp_cons(0,0));
    V base=fwp_p_ad_tape_owned(parameters,inputs,&identity_element);
    V tuple=fwp_rc_fresh(fwp_record(4,(V[4]){base,1,(V)(int64_t)-1,0}));
    if(mode==0){
        /* The root has identity zero even before a scheduler exists. */
        size_t before=fwp_heap.live;fwp_tasks_init();
        baseline+=fwp_heap.live-before;
    } else {
        /* No suspended stack or resource belongs to these raw task records.
         * Free the first record before allocating another: never read it later. */
        fwp_cur=fwp_root;fwp_mem_free(worker);
        worker=fwp_task_new();fwp_cur=worker;
    }
    V result=fwp_p_ad_push_owned(tuple,&identity_element);
    if(result!=base+1)return 191;
    fwp_cur=fwp_root;fwp_mem_free(worker);
    fwp_rc_free_obj(tuple);fwp_rc_free_obj(inputs);fwp_rc_free_obj(parameters);
    fwp_cleanup_pop(&cleanup);fwp_tape_scope_release(&scope);fwp_tape_finish();
    if(fwp_cleanups || fwp_owned_tapes || fwp_heap.live!=baseline)return 192;
    return 0;
}
