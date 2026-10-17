/* A native output channel borrows sent values and independently owns the
 * request/connection it may outlive. Stages: success, closed channel, blocked
 * send cancellation, encode trap, request retain overflow, connection retain
 * overflow, and an independently retained value. */
/* The six native targets had this 96-byte channel header before context cleanup. */
_Static_assert(sizeof(fwp_chan)==96,"native channel header grew");
static int channel_stage,channel_encoded,channel_cancelled,channel_trapped;
static V channel_value,channel_handle;
static double channel_charge(void){return fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget);}
static void channel_text_drop(V value){if(fwp_rc_release_last(value))fwp_rc_free_obj(value);}
static void channel_encode(V value,h2_buf *buffer){
 unsigned expected=channel_stage==6?2:1;
 if(*fwp_rc_slot(value)!=expected||strcmp(STR(value)->d,"payload"))_Exit(231);
 channel_encoded++;h2b_put(buffer,"payload",7);
 if(channel_stage==3)fwp_trap("channel encode trap");
}
static void channel_worker(void *arg,int cancelled){
 (void)arg;
 if(cancelled){channel_cancelled++;return;}
 jmp_buf failure;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;
 if(!setjmp(failure)){
  fwp_cur->trap_jb=&failure;fwp_cur->trap_cleanup=fwp_cleanups;
  fwp_value_owner channel={channel_handle,fwp_channel_drop},value={channel_value,channel_text_drop};
  fwp_cleanup channel_cleanup,value_cleanup;
  fwp_value_protect(&channel,&channel_cleanup);fwp_value_protect(&value,&value_cleanup);
  V result=fwp_p_channel_send_owned(channel_handle,channel_value,fwp_rc_dup);
  if(result!=(channel_stage==1?FWP_FALSE:FWP_TRUE))_Exit(233);
  channel_text_drop(fwp_value_finish(&value,&value_cleanup));
  fwp_channel_drop(fwp_value_finish(&channel,&channel_cleanup));
 }else{
  channel_trapped++;
  if(channel_stage!=3||strcmp(fwp_trap_msg,"channel encode trap"))_Exit(235);
 }
 fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;
}
static void channel_overflow(V value){
 uint8_t *slot=fwp_rc_slot(value);*slot=254;fwp_rc_dup(value);
 (*fwp_rc_wide_link(slot))->count=SIZE_MAX;
}
static void channel_restore(V value,unsigned count){uint8_t *slot=fwp_rc_slot(value);fwp_rc_forget_slot(slot);*slot=(uint8_t)count;}
int main(int argc,char **argv){
 if(argc!=2)_Exit(230);channel_stage=atoi(argv[1]);
 const char *verify=getenv("FWP_REUSE_VERIFY");int poison=verify&&*verify&&strcmp(verify,"0");
 fwp_lib_init();fwp_gc_start(__builtin_frame_address(0));fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 double before=channel_charge();
 g_server server={0};server.module="probe";
 g_conn *c=g_conn_new(FWP_INVALID_SOCKET,"channel-owner",&server);fwp_rc_fresh(PTR(c));
 g_stream *s=g_stream_new(c,1);fwp_rc_fresh(PTR(s));fwp_rc_dup(PTR(s)); /* caller and active list */
 s->sent_headers=1;s->remote_end=1;c->conn_window=channel_stage==2?0:65535;
 const fwp_desc string_type={.kind=K_STR,.name="String",.drop=channel_text_drop};
 g_codec codec={0};codec.ty=&string_type;
 if(channel_stage==4||channel_stage==5){
  V overflow=channel_stage==4?PTR(s):PTR(c);channel_overflow(overflow);
  double pending=channel_charge();
  jmp_buf failed;fwp_cur->trap_jb=&failed;fwp_cur->trap_cleanup=fwp_cleanups;
  if(!setjmp(failed)){g_sink_value(c,s,codec,0);_Exit(236);}
  fwp_cur->trap_jb=0;fwp_cur->trap_cleanup=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
  if(strcmp(fwp_trap_msg,"reference count overflow")||fwp_cleanups)_Exit(237);
  channel_restore(overflow,channel_stage==4?2:1);
  if(*fwp_rc_slot(PTR(c))!=1||*fwp_rc_slot(PTR(s))!=2)_Exit(232);
  if(!fwp_gc.enabled&&!poison&&channel_charge()!=pending)_Exit(238);
 }else{
  channel_handle=g_sink_value(c,s,codec,0);
  if(*fwp_rc_slot(PTR(c))!=2||*fwp_rc_slot(PTR(s))!=3||!fwp_rc_last(channel_handle))_Exit(234);
  fwp_rc_dup(channel_handle); /* worker and independent caller alias */
  channel_value=fwp_rc_fresh(fwp_cstr("payload"));
  if(channel_stage==6)fwp_rc_dup(channel_value);
  if(channel_stage==1)fwp_p_channel_close(channel_handle);
  fwp_task *task=fwp_spawn_task(0,channel_worker,0,0,0);
  task->ownership=FWP_TASK_SHARED;fwp_rc_fresh(PTR(task));fwp_rc_dup(PTR(task)); /* scheduler and caller */
  if(channel_stage==2){fwp_p_task_yield();if(task->done||channel_encoded!=1)_Exit(239);fwp_p_task_cancel(PTR(task));}
  fwp_await(task);fwp_free_zombie();
  if(!task->done||!fwp_rc_last(PTR(task))||channel_cancelled!=(channel_stage==2)||channel_trapped!=(channel_stage==3)||channel_encoded!=(channel_stage==1?0:1))_Exit(240);
  fwp_task_drop(PTR(task));
  if(!fwp_rc_last(channel_handle)||*fwp_rc_slot(PTR(c))!=2||*fwp_rc_slot(PTR(s))!=3)_Exit(241);
  if(channel_stage==6){if(!fwp_rc_last(channel_value)||strcmp(STR(channel_value)->d,"payload"))_Exit(242);channel_text_drop(channel_value);}
  fwp_channel_drop(channel_handle);
  if(*fwp_rc_slot(PTR(c))!=1||*fwp_rc_slot(PTR(s))!=2||fwp_cleanups)_Exit(232);
 }
 g_unlink(c,s);g_stream_drop(s);g_conn_drop(c);
 if(!fwp_gc.enabled&&!poison&&(channel_charge()!=before||fwp_gc.ncollect)){
  fprintf(stderr,"channel stage %d: managed bytes %.0f -> %.0f\n",channel_stage,before,channel_charge());_Exit(243);
 }
 fwp_lib_finish();return 0;
}
