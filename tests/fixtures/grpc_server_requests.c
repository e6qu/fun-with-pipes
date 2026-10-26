/* Counted server requests outlive parser batches, serving jobs and retained
 * input sources. Each stage ends with exactly one request finalization. */
static const g_server *request_server;
static h2_buf *request_wire;
static ssize_t request_receive(g_conn *c,void *data,size_t n,int *wait){
 if(request_stage!=7)return g_io_recv(c,data,n,wait);
 if(!request_wire||request_wire->len>n)_Exit(245);
 c->server=request_server;memcpy(data,request_wire->d,request_wire->len);
 return (ssize_t)request_wire->len;
}
static double request_charge(void){return (double)fwp_heap.live;}
static void overflow_owner(V value){uint8_t *slot=fwp_rc_slot(value);*slot=254;fwp_rc_dup(value);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;}
static void restore_owner(V value,unsigned n){uint8_t *slot=fwp_rc_slot(value);fwp_rc_forget_slot(slot);*slot=(uint8_t)n;}
int main(int argc,char **argv){
 if(argc!=2)_Exit(230);int stage=atoi(argv[1]);request_stage=stage;
 const char *verify=getenv("FWP_REUSE_VERIFY");int poison=verify&&*verify&&strcmp(verify,"0");
 fwp_lib_init();fwp_heap_start();fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 double before=request_charge();
 g_server server={0};server.module="probe";
 g_conn *c=g_conn_new(FWP_INVALID_SOCKET, "", "request-owner",&server);c->preface=1;
 h2_buf headers={0},wire={0};
 h2_hpack_lit(&headers,":method","POST");h2_hpack_lit(&headers,":path","/probe.unknown");
 h2_hpack_lit(&headers,":scheme","http");h2_hpack_lit(&headers,":authority","probe");
 h2_hpack_lit(&headers,"content-type","application/grpc");
 h2_header_frames(&wire,1,&headers,1,c->peer.max_frame);
 if(stage==7)h2_header_frames(&wire,3,&headers,1,c->peer.max_frame);h2b_free(&headers);
 if(stage==1){unsigned char reset[4]={0,0,0,8};h2_frame(&wire,H2_RST_STREAM,0,1,reset,4);}
 g_slist pending={0};char *dead=NULL;
 if(stage==7){
  request_server=&server;request_wire=&wire;c->server=NULL;
  int saved_unwinding=fwp_cur->unwinding;
  jmp_buf failure;fwp_cur->trap_jb=&failure;fwp_cur->trap_cleanup=fwp_cleanups;
  if(!setjmp(failure)){g_reader(c,0);_Exit(246);}
  fwp_cur->trap_jb=0;fwp_cur->trap_cleanup=0;fwp_trap_jb=0;fwp_trap_cleanup=0;fwp_cur->unwinding=saved_unwinding;
  if(strcmp(fwp_trap_msg,"pending dispatch trap")||fwp_cleanups||request_finals||!c->streams||!c->streams->next||!fwp_rc_last(PTR(c->streams))||!fwp_rc_last(PTR(c->streams->next)))_Exit(244);
  h2b_free(&wire);while(c->streams)g_unlink(c,c->streams);goto finish;
 }
 g_process(c,wire.d,wire.len,&pending,&dead);h2b_free(&wire);
 if(dead||pending.n!=1)_Exit(231);
 if(request_finals)_Exit(233); /* a reset must not free a pending request */
 g_stream *s=pending.v[0];
 if(*fwp_rc_slot(PTR(s))!=(stage==1?1:2)||s->listed!=(stage!=1))_Exit(232);
 if(stage>=8){
  fwp_rc_fresh(PTR(c));
  const fwp_desc integer_type={.kind=K_I64,.name="I64"};const fwp_desc *fields[]={&integer_type};
  fwp_rpc method={0};method.input=1;method.nreq=1;method.req=fields;
  g_route route={0};route.kind=G_ROUTE_METHOD;route.m=&method;
  g_job job={0};job.c=c;job.s=s;job.srv=&server;job.route=&route;strcpy(job.what,"source-owner");
  V overflow=stage==8?PTR(s):PTR(c);if(stage!=10)overflow_owner(overflow);
  double pending_bytes=request_charge();
  jmp_buf failure;fwp_cur->trap_jb=&failure;fwp_cur->trap_cleanup=fwp_cleanups;
  if(!setjmp(failure)){char *message=NULL;g_run_method(&job,&message);_Exit(250);}
  fwp_cur->trap_jb=0;fwp_cur->trap_cleanup=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
  if(strcmp(fwp_trap_msg,stage==10?"source construction trap":"reference count overflow")||fwp_cleanups)_Exit(251);
  if(stage!=10){if((*fwp_rc_wide_link(fwp_rc_slot(overflow)))->count!=SIZE_MAX)_Exit(252);restore_owner(overflow,stage==8?2:1);}
  if(*fwp_rc_slot(PTR(s))!=2||!fwp_rc_last(PTR(c)))_Exit(247);
  if(!fwp_heap.enabled&&!poison&&request_charge()!=pending_bytes)_Exit(248);
  g_unlink(c,s);g_slist_release(&pending);
 }else if(stage==2){
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
  pending.v[0]=NULL; /* transfer to the job, including startup failure */
  jmp_buf failure;fwp_cur->trap_jb=&failure;fwp_cur->trap_cleanup=fwp_cleanups;
  if(!setjmp(failure)){g_start_call(c,s);_Exit(237);}
  fwp_cur->trap_jb=0;fwp_cur->trap_cleanup=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
  if(strcmp(fwp_trap_msg,"job startup trap")||fwp_cleanups||s->task||!fwp_rc_last(PTR(s)))_Exit(238);
  g_unlink(c,s);g_slist_release(&pending);
 }else{
  pending.v[0]=NULL;g_start_call(c,s);
  if(request_finals||*fwp_rc_slot(PTR(s))!=(stage==1?1:2)||!s->task)_Exit(234);
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
 finish:
 if(request_finals!=(stage==7?2:1)||c->streams||pending.v||pending.n||fwp_cleanups)_Exit(239);
 if(stage>=8)g_conn_drop(c);else{fwp_heap_forget_finalizer(c);g_conn_final(c);fwp_mem_free(c);}
 if(!fwp_heap.enabled&&!poison&&(request_charge()!=before)){
  fprintf(stderr,"request stage %d: managed bytes %.0f -> %.0f\n",stage,before,request_charge());_Exit(243);
 }
 fwp_lib_finish();return 0;
}
