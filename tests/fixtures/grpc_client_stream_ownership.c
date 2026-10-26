#undef free
static void observed_message_free(void *p) {
    if (p && p == probe_message) { probe_message = 0; probe_message_frees++; }
    free(p);
}
static void empty_input_drop(V value) { if(value)_Exit(224); }
static const fwp_remote empty_input_remote={.input_drop=empty_input_drop};
static jmp_buf probe_trap;
static int recover_probe(void) { return 1; }
static double probe_charge(void) {
    return (double)fwp_heap.live;
}
static int still_finalized(void *pointer) {
    for (size_t i=0; i<fwp_heap.nfins; i++) if (fwp_heap.fins[i].obj==pointer) return 1;
    return 0;
}
static void end_response(g_conn *c, g_stream *s, int mode) {
    unsigned char data[8]={0};
    g_slist fresh={0};char *dead=0;
    if (mode==0) {
        h2_buf block={0};
        h2_hpack_lit(&block,":status","200");h2_hpack_lit(&block,"grpc-status","0");
        g_header_block(c,s->id,block.d,block.len,1,&fresh,&dead);
        h2b_free(&block);
    } else if (mode==4) g_conn_dead(c,"test transport ended");
    else {
        h2_fr frame={.stream=s->id,.p=data};
        if(mode==1){frame.type=H2_DATA;frame.flags=H2_END_STREAM;frame.n=0;}
        if(mode==2){frame.type=H2_RST_STREAM;frame.n=4;data[3]=8;}
        if(mode==3){frame.type=H2_GOAWAY;frame.stream=0;frame.n=8;}
        g_on_frame(c,&frame,&fresh,&dead);
    }
    if(dead||fresh.n)_Exit(219);
}
int main(int argc,char **argv) {
    if(argc!=2)return 200;
    int mode=atoi(argv[1]);if(mode<0||mode>10)return 200;
    fwp_lib_init();fwp_heap_start();fwp_tasks_init();
    double before_connection=probe_charge();
    g_conn *c=g_conn_new(FWP_INVALID_SOCKET, "", "local",0);
    fwp_rc_fresh(PTR(c));fwp_rc_dup(PTR(c)); /* fixture and incoming source */
    double before=probe_charge();
    g_stream *s=g_stream_new(c,1);
    fwp_rc_fresh(PTR(s));fwp_rc_dup(PTR(s)); /* source and active list */
    g_incoming *source=g_incoming_new("probe",5);source->c=c;source->s=s;
    g_msg *message=malloc(sizeof(*message)+2);if(!message)return 201;
    memset(message,0,sizeof(*message));message->n=1;message->d[0]=7;
    probe_message=message;s->mhead=s->mtail=message;
    h2b_put(&s->data,"partial",7);
    if(mode==5)fwp_rc_dup(PTR(s)); /* a sender-like independent alias */
    if(mode==6||mode==7) {
        g_spawn_sender(c,s,0,&empty_input_remote);
        if(!probe_sender||*fwp_rc_slot(PTR(s))!=3)return 216;
    }
    if(mode>=8) {
        uint8_t *slot=fwp_rc_slot(mode==10?PTR(c):PTR(s));
        if(mode>=9){*slot=254;fwp_rc_dup(mode==10?PTR(c):PTR(s));(*fwp_rc_wide_link(slot))->count=SIZE_MAX;}
        probe_spawn_fail=mode==8;
        fwp_trap_recover=recover_probe;fwp_trap_jb=&probe_trap;fwp_trap_cleanup=fwp_cleanups;
        if(!setjmp(probe_trap)){g_spawn_sender(c,s,0,&empty_input_remote);return 217;}
        fwp_trap_recover=0;fwp_trap_jb=0;fwp_trap_cleanup=0;probe_spawn_fail=0;
        if(fwp_cleanups||probe_sender||probe_stream_finals)return 217;
        if(mode>=9){
            if(*slot!=255||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 218;
            fwp_rc_forget_slot(slot);*slot=2;
        } else if(*slot!=2)return 218;
        if(*fwp_rc_slot(PTR(c))!=2||*fwp_rc_slot(PTR(s))!=2)return 218;
    }
    size_t outgoing=c->out.len;
    g_incoming_drop(source);
    if(probe_stream_finals)return 210; /* no dereference if a bad release freed s */
    if(probe_message||probe_message_frees!=1||s->data.d||s->mhead||s->mtail)return 211;
    if(!s->listed||!s->abandoned||s->reset||c->out.len!=outgoing)return 211;
    unsigned char ignored[6]={0,0,0,0,1,9};
    h2_fr frame={.type=H2_DATA,.stream=s->id,.p=ignored,.n=sizeof ignored};
    g_slist fresh={0};char *dead=0;
    g_on_frame(c,&frame,&fresh,&dead);
    if(dead||s->mhead||s->data.d||c->out.len<=outgoing)return 211;
    end_response(c,s,mode<5?mode:0);
    if(c->streams)return 212;
    if(mode==5) {
        if(probe_stream_finals||!fwp_rc_last(PTR(s))||!s->remote_end)return 213;
        g_stream_drop(s);
    } else if(mode==6||mode==7) {
        if(probe_stream_finals||!fwp_rc_last(PTR(s)))return 213;
        fwp_task *task=probe_sender;
        if(mode==7)fwp_cancel_tree(task);
        int64_t deadline=fwp_now_ns()+10000000000LL;
        while(fwp_tasks_active){
            if(fwp_now_ns()>=deadline)return 214;
            fwp_park(0,fwp_now_ns()+1000000LL);fwp_free_zombie();
        }
        fwp_free_zombie();
        if(fwp_cleanups)return 214;
    }
    if(probe_stream_finals!=1)return 212;
    if(still_finalized(s))return 215;
#ifndef FWP_RESOURCE_NO_FREE
    if(mode<6&&!fwp_heap.enabled&&!fwp_reuse_verify&&probe_charge()!=before)return 220;
#endif
    if(*fwp_rc_slot(PTR(c))!=1)return 221;
    g_conn_drop(c);
    if(still_finalized(c))return 222;
#ifndef FWP_RESOURCE_NO_FREE
    if(mode<6&&!fwp_heap.enabled&&!fwp_reuse_verify&&probe_charge()!=before_connection)return 223;
#endif
    fwp_lib_finish();
    if(probe_stream_finals!=1)return 215;
    printf("stream_bytes\tstream_alignment\traw_offset\tabandoned_offset\tsource_bytes\tsender_bytes\tconnection_bytes\n%zu\t%zu\t%zu\t%zu\t%zu\t%zu\t%zu\n",
        sizeof(g_stream),_Alignof(g_stream),offsetof(g_stream,raw),offsetof(g_stream,abandoned),
        sizeof(g_incoming),sizeof(g_sender),sizeof(g_conn));
    return 0;
}
