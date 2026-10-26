#undef free
#undef TlsFree
#undef DeleteFiber
#undef SetConsoleCtrlHandler
static BOOL WINAPI observe_key_delete(DWORD key) {
 BOOL result=TlsFree(key);if(result&&observed)observed->key_deleted++;return result;
}
static void WINAPI observe_fiber_delete(void *fiber) {
 if(observed)for(int i=0;i<3;i++)if(fiber==observed->fibers[i])observed->fibers_deleted++;
 DeleteFiber(fiber);
}
static BOOL WINAPI observe_signal(PHANDLER_ROUTINE handler,BOOL add) {
 BOOL result=SetConsoleCtrlHandler(handler,add);
 if(result&&observed){if(add)observed->signal_added++;else observed->signal_removed++;}
 return result;
}
static void observe_free(void *p) {
 if(observed&&p) {
  if(p==observed->wide)observed->wide_freed++;
  if(p==observed->fins)observed->fins_freed++;
  if(p==observed->marks)observed->marks_freed++;
  if(p==observed->metrics)observed->metrics_freed++;
  if(p==observed->name)observed->name_freed++;
 }
 free(p);
}
static void observe_finished(void) {
 if(!observed)return;
 observed->finished++;
 if(observed->wide_freed!=1||observed->fins_freed!=1||observed->marks_freed!=1||
    observed->metrics_freed!=1||observed->name_freed!=1||observed->key_deleted!=1||
    observed->fibers_deleted!=3||observed->signal_added!=1||observed->signal_removed!=1||
    fwp_heap.ready||fwp_heap.reservation||fwp_closure_drop_key!=TLS_OUT_OF_INDEXES)
     observed->order_error=1;
 if(observed->static_exit)puts(observed->order_error?"bad cleanup":"finished");
}
static void blocked(void *arg,int cancelled) {
 struct snapshot *s=arg;
 if(cancelled){s->cancelled++;return;}
 ULONG_PTR low,high;GetCurrentThreadStackLimits(&low,&high);
 s->stacks[s->entered++]=(void *)(high-1);
 fwp_check_cancel();(void)fwp_wait_fd((SOCKET)s->socket,0,0);s->order_error=1;
}
static void completed(void *arg,int cancelled) {
 struct snapshot *s=arg;
 if(cancelled)s->order_error=1;
 else {ULONG_PTR low,high;GetCurrentThreadStackLimits(&low,&high);s->stacks[2]=(void *)(high-1);s->completed++;}
}
static void finalize(void *p) {
 if(*(uint64_t *)p!=0x12345678||observed->entered!=2||observed->completed!=1||observed->cancelled!=2||
    fwp_root||fwp_tasks_active||fwp_caf_state0||fwp_lib_ready)observed->order_error=1;
 fwp_lib_finish(); /* Finishing twice must not repeat destruction. */
 observed->finalized++;
 if(observed->static_exit)puts(observed->order_error?"bad finalization":"finalized");
}
__declspec(dllexport) void setup(struct snapshot *s) {
 fwp_lib_init();observed=s;
 s->heap=fwp_heap.reservation;s->meta=fwp_heap.meta;
 V wide=fwp_rc_fresh(fwp_str_new("wide",4));
 for(int i=0;i<256;i++)fwp_rc_dup(wide);
 s->wide=*fwp_rc_wide_link(fwp_rc_slot(wide));
 fwp_heap.mstack=malloc(8*sizeof(heap_range));fwp_heap.mcap=8;s->marks=fwp_heap.mstack;
 uint64_t *marker=fwp_mem_alloc(sizeof(uint64_t));*marker=0x12345678;
 fwp_heap_finalizer(marker,finalize);s->fins=fwp_heap.fins;
 fwp_metric *metric=fwp_metric_get("probe",5,"",0,"gauge");s->metrics=fwp_metrics;s->name=metric->name;
 if(fwp_sockets_init())abort();
 (void)fwp_p_shutdown_requested();
 fwp_task *child=fwp_spawn_task(0,blocked,s,0,0);
 fwp_task *detached=fwp_spawn_task(0,blocked,s,0,1);
 s->fibers[0]=child->ctx.fiber;s->fibers[1]=detached->ctx.fiber;
 (void)fwp_p_task_yield();
 fwp_task *done=fwp_spawn_task(0,completed,s,0,0);s->fibers[2]=done->ctx.fiber;
 (void)fwp_await(done);
 if(s->entered!=2||s->completed!=1||s->cancelled||fwp_heap.armed||fwp_heap.ncollect)s->order_error=1;
}
