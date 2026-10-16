static int service_left;
static jmp_buf service_jump;
static int service_recover(void) { return 1; }
static void service_allocation(void) {
    if(service_left>0 && !--service_left) fwp_trap("injected service-result allocation failure");
}
static int metadata_matches(V list) {
    const char *keys[]={"x-a","x-b","x-a"},*values[]={"one","two","three"};
    for(int i=0;i<3;i++) {
        if(!list)return 0;V pair=OBJ(list)->f[0];
        if(strcmp(STR(OBJ(pair)->f[0])->d,keys[i])||strcmp(STR(OBJ(pair)->f[1])->d,values[i]))return 0;
        list=OBJ(list)->f[1];
    }
    return list==0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
    if(fwp_p_grpc_metadata(METADATA_TYPE)||fwp_p_grpc_peer_subject(SUBJECT_TYPE)!=FWP_NONE)return 247;
    h2_hdrs headers={0};
    h2_hdrs_add(&headers,":method",7,"POST",4);
    h2_hdrs_add(&headers,"x-a",3,"one",3);
    h2_hdrs_add(&headers,"content-type",12,"application/grpc",16);
    h2_hdrs_add(&headers,"x-b",3,"two",3);
    h2_hdrs_add(&headers,"x-a",3,"three",5);
    char peer[]="CN=client";g_serving serving={0};serving.headers=&headers;serving.peer=peer;
    g_ctx ctx={0};ctx.serving=&serving;fwp_cur->gctx=&ctx;
    intptr_t budget=fwp_gc.budget;
    V metadata=fwp_p_grpc_metadata(METADATA_TYPE),subject=fwp_p_grpc_peer_subject(SUBJECT_TYPE);
    METADATA_TYPE->dup(metadata);SUBJECT_TYPE->dup(subject);
    METADATA_TYPE->drop(metadata);SUBJECT_TYPE->drop(subject);
    headers.v[1].value[0]='X';peer[0]='X';
    if(!metadata_matches(metadata)||subject==FWP_NONE||OBJ(subject)->tag!=1||strcmp(STR(OBJ(subject)->f[0])->d,"CN=client"))return 247;
    METADATA_TYPE->drop(metadata);SUBJECT_TYPE->drop(subject);
    headers.v[1].value[0]='o';peer[0]='C';
    if(fwp_gc.budget!=budget)return 248;
    for(int operation=0;operation<2;operation++) {
        const fwp_desc *type=operation?SUBJECT_TYPE:METADATA_TYPE;
        int failed=0,completed=0;
        for(int allocation=1;allocation<32;allocation++) {
            fwp_trap_recover=service_recover;fwp_trap_jb=&service_jump;fwp_trap_cleanup=fwp_cleanups;
            service_left=allocation;
            if(!setjmp(service_jump)) {
                V result=operation?fwp_p_grpc_peer_subject(type):fwp_p_grpc_metadata(type);
                service_left=0;type->drop(result);completed=1;
            } else failed++;
            service_left=0;fwp_trap_recover=NULL;fwp_trap_jb=NULL;
            if(fwp_cleanups||fwp_gc.budget!=budget)return 248;
            if(completed)break;
        }
        if(!completed||failed!=(operation?2:12))return 247;
        printf("service result %d: %d allocation failures; final charged delta 0\n",operation,failed);
    }
    serving.peer=NULL;
    if(fwp_p_grpc_peer_subject(SUBJECT_TYPE)!=FWP_NONE||fwp_gc.budget!=budget)return 247;
    fwp_cur->gctx=NULL;h2_hdrs_free(&headers);
    if(fwp_gc.ncollect)return 247;
    return 0;
}
