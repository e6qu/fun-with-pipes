static int service_left;
static jmp_buf service_jump;
static int service_recover(void) { return 1; }
static void service_allocation(void) {
    if(service_left>0 && !--service_left) fwp_trap("injected HTTP/2-result allocation failure");
}
static int request_matches(V request) {
    if(OBJ(request)->n!=5||strcmp(STR(OBJ(request)->f[0])->d,"POST")||
       strcmp(STR(OBJ(request)->f[1])->d,"/echo")||strcmp(STR(OBJ(request)->f[3])->d,"remote")||OBJ(request)->f[4]!=FWP_NONE)return 0;
    const char *keys[]={"host","x-a","x-b","x-a"},*values[]={"example.test","one","two","three"};
    V list=OBJ(request)->f[2];
    for(int i=0;i<4;i++) {
        if(!list)return 0;V pair=OBJ(list)->f[0];
        if(strcmp(STR(OBJ(pair)->f[0])->d,keys[i])||strcmp(STR(OBJ(pair)->f[1])->d,values[i]))return 0;
        list=OBJ(list)->f[1];
    }
    return list==0;
}
int main(void) {
    fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();
    char remote[]="remote";g_conn conn={0};conn.authority=remote;
    g_stream stream={0};g_call call={.c=&conn,.s=&stream,.server=1};
    struct {uint32_t tag,n;V f[1];} duration={0,1,{0}};
    h2_hdrs_add(&stream.headers,":method",7,"POST",4);
    h2_hdrs_add(&stream.headers,":path",5,"/echo",5);
    h2_hdrs_add(&stream.headers,":authority",10,"example.test",12);
    h2_hdrs_add(&stream.headers,"x-a",3,"one",3);
    h2_hdrs_add(&stream.headers,"x-b",3,"two",3);
    h2_hdrs_add(&stream.headers,"x-a",3,"three",5);
    static const unsigned char bytes[]={0,255,192,128,10};
    h2b_put(&stream.data,bytes,sizeof bytes);stream.remote_end=1;
    intptr_t budget=fwp_gc.budget;
    V request=fwp_p_http2_request(PTR(&call),REQUEST_TYPE);
    V body=fwp_p_http2_body(64,PTR(&duration),PTR(&call),BODY_TYPE);
    REQUEST_TYPE->dup(request);BODY_TYPE->dup(body);REQUEST_TYPE->drop(request);BODY_TYPE->drop(body);
    stream.headers.v[3].value[0]='X';remote[0]='X';stream.data.d[0]=42;
    if(!request_matches(request)||OBJ(body)->tag!=0||STR(OBJ(body)->f[0])->len!=sizeof bytes||memcmp(STR(OBJ(body)->f[0])->d,bytes,sizeof bytes))return 247;
    REQUEST_TYPE->drop(request);BODY_TYPE->drop(body);
    stream.headers.v[3].value[0]='o';remote[0]='r';stream.data.d[0]=0;
    if(fwp_gc.budget!=budget)return 248;
    for(int operation=0;operation<2;operation++) {
        const fwp_desc *type=operation?BODY_TYPE:REQUEST_TYPE;
        int failed=0,completed=0;
        for(int allocation=1;allocation<64;allocation++) {
            fwp_trap_recover=service_recover;fwp_trap_jb=&service_jump;fwp_trap_cleanup=fwp_cleanups;
            service_left=allocation;
            if(!setjmp(service_jump)) {
                V result=operation?fwp_p_http2_body(64,PTR(&duration),PTR(&call),type):fwp_p_http2_request(PTR(&call),type);
                service_left=0;type->drop(result);completed=1;
            } else failed++;
            service_left=0;fwp_trap_recover=NULL;fwp_trap_jb=NULL;
            if(fwp_cleanups||fwp_gc.budget!=budget)return 248;
            if(completed)break;
        }
        if(!completed||failed!=(operation?2:20))return 247;
        printf("HTTP/2 result %d: %d allocation failures; final charged delta 0\n",operation,failed);
    }
    // Existing host wins over :authority, and duplicate header order is retained.
    h2_hdrs_add(&stream.headers,"host",4,"explicit.test",13);
    request=fwp_p_http2_request(PTR(&call),REQUEST_TYPE);
    V list=OBJ(request)->f[2];int count=0;
    for(;list;list=OBJ(list)->f[1]) {
        V pair=OBJ(list)->f[0];
        if(!strcmp(STR(OBJ(pair)->f[0])->d,"host")&&(count!=3||strcmp(STR(OBJ(pair)->f[1])->d,"explicit.test")))return 247;
        count++;
    }
    REQUEST_TYPE->drop(request);if(count!=4||fwp_gc.budget!=budget)return 248;
    h2_hdrs_free(&stream.headers);h2b_free(&stream.data);
    request=fwp_p_http2_request(PTR(&call),REQUEST_TYPE);
    if(STR(OBJ(request)->f[0])->len||STR(OBJ(request)->f[1])->len||OBJ(request)->f[2])return 247;
    REQUEST_TYPE->drop(request);
    // Empty success and each error return remain owned. Size wins before reset.
    body=fwp_p_http2_body(0,PTR(&duration),PTR(&call),BODY_TYPE);
    if(OBJ(body)->tag||STR(OBJ(body)->f[0])->len)return 247;BODY_TYPE->drop(body);
    for(int error=0;error<4;error++) {
        stream.remote_end=0;stream.reset=error<2?"reset":NULL;conn.dead=error==2?"closed":NULL;
        if(!error)h2b_put(&stream.data,bytes,sizeof bytes);
        body=fwp_p_http2_body(error?-1:1,PTR(&duration),PTR(&call),BODY_TYPE);
        if(OBJ(body)->tag!=1||(int64_t)OBJ(body)->f[0]!=(error==0?413:error==3?408:0))return 247;
        BODY_TYPE->drop(body);h2b_free(&stream.data);
        if(fwp_gc.budget!=budget)return 248;
    }
    if(fwp_gc.ncollect||fwp_cleanups)return 247;
    fwp_lib_finish();return 0;
}
