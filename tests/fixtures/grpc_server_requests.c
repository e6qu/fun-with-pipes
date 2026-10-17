/* Counted server requests outlive parser batches, serving jobs and retained
 * input sources. Each stage ends with exactly one request finalization. */
static double request_charge(void){return fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget);}
static void overflow_request(g_stream *s){uint8_t *slot=fwp_rc_slot(PTR(s));*slot=254;fwp_rc_dup(PTR(s));(*fwp_rc_wide_link(slot))->count=SIZE_MAX;}
static void restore_request(g_stream *s,unsigned n){uint8_t *slot=fwp_rc_slot(PTR(s));fwp_rc_forget_slot(slot);*slot=(uint8_t)n;}
int main(int argc,char **argv){
 if(argc!=2)_Exit(230);int stage=atoi(argv[1]);
 const char *verify=getenv("FWP_REUSE_VERIFY");int poison=verify&&*verify&&strcmp(verify,"0");
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 double before=request_charge();
 g_server server={0};server.module="probe";
 g_conn *c=g_conn_new(FWP_INVALID_SOCKET,"request-owner",&server);c->preface=1;
 h2_buf headers={0},wire={0};
 h2_hpack_lit(&headers,":method","POST");h2_hpack_lit(&headers,":path","/probe.unknown");
 h2_hpack_lit(&headers,":scheme","http");h2_hpack_lit(&headers,":authority","probe");
 h2_hpack_lit(&headers,"content-type","application/grpc");
 h2_header_frames(&wire,1,&headers,1,c->peer.max_frame);h2b_free(&headers);
 if(stage==1){unsigned char reset[4]={0,0,0,8};h2_frame(&wire,H2_RST_STREAM,0,1,reset,4);}
 g_slist pending={0};char *dead=NULL;g_process(c,wire.d,wire.len,&pending,&dead);h2b_free(&wire);
 if(dead||pending.n!=1)_Exit(231);
 if(request_finals)_Exit(233); /* a reset must not free a pending request */
 g_stream *s=pending.v[0];
 if(*fwp_rc_slot(PTR(s))!=(stage==1?1:2)||s->listed!=(stage!=1))_Exit(232);
 if(stage==2){
  g_conn_dead(c,"closed before dispatch");
  if(request_finals||!fwp_rc_last(PTR(s)))_Exit(235);
  g_slist_release(&pending);
 }else if(stage==5){
  g_incoming *source=g_incoming_new("early input",11);source->server=1;
  fwp_rc_dup(PTR(s));source->s=s;source->c=c;
  g_incoming_drop(source);
  if(request_finals)_Exit(236);
  if(s->abandoned||!s->listed||c->streams!=s||*fwp_rc_slot(PTR(s))!=2)_Exit(236);
  g_unlink(c,s);g_slist_release(&pending);
 }else if(stage==6){
  overflow_request(s);jmp_buf failure;fwp_cur->trap_jb=&failure;fwp_cur->trap_cleanup=fwp_cleanups;
  if(!setjmp(failure)){g_start_call(c,s);_Exit(237);}
  fwp_cur->trap_jb=0;fwp_cur->trap_cleanup=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
  if(strcmp(fwp_trap_msg,"reference count overflow")||fwp_cleanups||s->task||(*fwp_rc_wide_link(fwp_rc_slot(PTR(s))))->count!=SIZE_MAX)_Exit(238);
  restore_request(s,2);g_unlink(c,s);g_slist_release(&pending);
 }else{
  g_start_call(c,s);
  if(request_finals||*fwp_rc_slot(PTR(s))!=(stage==1?2:3)||!s->task)_Exit(234);
  g_incoming *source=NULL;
  if(stage==4){source=g_incoming_new("retained input",14);source->server=1;fwp_rc_dup(PTR(s));source->s=s;source->c=c;}
  if(stage==3)fwp_cancel_tree(s->task);
  g_slist_release(&pending);fwp_tasks_finish();fwp_free_zombie();
  if(stage==4){
   if(request_finals)_Exit(240);
   if(!fwp_rc_last(PTR(s))||s->listed||s->task||strcmp(source->what,"retained input"))_Exit(241);
   g_incoming_drop(source);
  }
 }
 if(request_finals!=1||c->streams||pending.v||pending.n||fwp_cleanups)_Exit(239);
 fwp_gc_forget_finalizer(c);g_conn_final(c);fwp_mem_free(c);
 if(!fwp_gc.enabled&&!poison&&(request_charge()!=before||fwp_gc.ncollect)){
  fprintf(stderr,"request stage %d: managed bytes %.0f -> %.0f\n",stage,before,request_charge());_Exit(243);
 }
 fwp_lib_finish();return 0;
}
