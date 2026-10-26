/* Real owning method entries receive controlled decoded strings. Transport
 * hooks let failures happen at specific boundaries without timing races.
 * Stages: 0 returned argument, 1 partial decode, 2 decode trap, 3 encode trap,
 * 4 blocked-send cancellation, 5 typed error, 7 shared arguments, 8 external
 * argument alias, 9 iterator completion, 10 continuation trap, 11 iterator
 * encode trap, 12 iterator cancellation, 13 retained iterator, 14 closed send.
 * Stage 14 stops before exhaustion so normal cursor cleanup has live storage. */
static int stage,decoded,encoded,cancelled,trapped,finished;
static V first,external;
static double before;
static double owned_charge(void){return (double)fwp_heap.live;}
static void owned_no_release(void *arg){(void)arg;}
static void owned_string_drop(V value){if(fwp_rc_release_last(value))fwp_rc_free_obj(value);}
static g_msg *owned_request(void){g_msg *m=calloc(1,sizeof *m);if(!m)_Exit(240);return m;}
static int owned_decode(V *value){
 if(decoded==1&&stage==1)return 0;
 if(decoded==1&&stage==2)fwp_trap("argument decode trap");
 if(decoded==1&&stage==7){fwp_rc_dup(first);*value=first;}
 else *value=fwp_rc_fresh(fwp_cstr(decoded?"discarded":"alpha"));
 if(!decoded){first=*value;if(stage==8){fwp_rc_dup(first);external=first;}}
 decoded++;return 1;
}
static void owned_response(V value,h2_buf *buffer){
 if(strcmp(STR(value)->d,"alpha"))_Exit(241);
 if(stage==8){if(*fwp_rc_slot(value)!=2)_Exit(242);}
 else if(!fwp_rc_last(value))_Exit(242);
 encoded++;h2b_put(buffer,"alpha",5);
 if(stage==3||stage==11)fwp_trap("result encode trap");
}
static int owned_transcode(const char *data,size_t n,h2_buf *out){
 int found=0;for(size_t i=0;i+5<=n;i++)if(!memcmp(data+i,"alpha",5))found=1;
 if(!found)_Exit(243);h2b_put(out,data,n);encoded++;return 1;
}
static void owned_iterator_drop(V node){
 if(!fwp_rc_release_last(node))return;
 if(fwp_tag(node)!=1)_Exit(244);
 owned_string_drop(OBJ(node)->f[0]);fwp_closure_drop(OBJ(node)->f[1]);
 fwp_rc_resource_free_obj(node);
}
static V owned_iterator_method(V *args){
 owned_string_drop(args[1]);
 V next=fwp_rc_fresh(fwp_pap(stage==10?7:6,0,0));
 V node=fwp_rc_fresh(fwp_data(1,2,(V[]){args[0],next}));
 if(stage==13){fwp_rc_dup(node);external=node;}
 return node;
}
static void owned_finish(void){
 if(stage==8){
  if(!external||strcmp(STR(external)->d,"alpha")||!fwp_rc_last(external))_Exit(245);
  fwp_rc_free_obj(external);external=0;
 }
 if(stage==13){
  if(!external||!fwp_rc_last(external)||!OBJ(external)->f[1]||strcmp(STR(OBJ(external)->f[0])->d,"alpha"))_Exit(245);
  owned_iterator_drop(external);external=0;
 }
 if(owned_charge()!=before){fprintf(stderr,"stage %d: managed bytes %.0f -> %.0f\n",stage,before,owned_charge());_Exit(246);}
 if(fwp_cleanups)_Exit(247);finished++;
}
static void owned_serve(void *arg,int stop){
 if(stop){cancelled++;owned_finish();return;}
 before=owned_charge();
 jmp_buf failure;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *saved_cleanup=fwp_cur->trap_cleanup;
 if(!setjmp(failure)){
  fwp_cur->trap_jb=&failure;fwp_cur->trap_cleanup=fwp_cleanups;
  char *message=0;int status=g_run_method(arg,&message);
  if(stage==1){if(status!=GRPC_INVALID_ARGUMENT||!message)_Exit(248);}
  else if(stage==10){if(status!=GRPC_INTERNAL||!message||!strstr(message,"zero"))_Exit(248);}
  else if(status!=-1||message)_Exit(248);
  free(message);
 }else{
  trapped++;
  const char *expected=stage==2?"argument decode trap":"result encode trap";
  if((stage!=2&&stage!=3&&stage!=11)||strcmp(fwp_trap_msg,expected))_Exit(249);
 }
 fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=saved_cleanup;
 owned_finish();
}
int main(int argc,char **argv){
 if(argc!=2)_Exit(250);stage=atoi(argv[1]);
 fwp_lib_init();fwp_heap_start();fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 // Real generated methods return the first argument or raise it as an error.
 // Iterator cases replace only the owning entry with a concrete test producer.
 fwp_fninfo table[sizeof fwp_fn_table/sizeof *fwp_fn_table];memcpy(table,fwp_fn_table,sizeof table);
 fwp_owned_fninfo iterator_types=*table[3].owned;
 if(stage>=9){iterator_types.entry=owned_iterator_method;table[3].owned=&iterator_types;}
 fwp_fns=table;
 const fwp_desc string_type={.kind=K_STR,.name="String",.drop=owned_string_drop};
 const fwp_desc *fields[]={&string_type,&string_type};
 fwp_rpc method={0};method.fn=stage==5?4:3;method.nreq=2;method.req=fields;method.resp=&string_type;
 method.error=stage==5?&string_type:0;method.result_drop=stage>=9?owned_iterator_drop:owned_string_drop;method.output=stage>=9?1:0;
 g_server server={0};server.module="probe";
 g_conn *c=g_conn_new(FWP_INVALID_SOCKET, "", "owned-values",&server);c->conn_window=(stage==4||stage==12)?0:65535;
 g_stream *s=g_stream_new(c,1);s->sent_headers=1;s->remote_end=1;s->local_end=stage==14;
 g_route route={0};route.kind=G_ROUTE_METHOD;route.m=&method;
 g_job job={0};job.c=c;job.s=s;job.srv=&server;job.route=&route;strcpy(job.what,"owned-values");
 fwp_task *task=fwp_spawn_task(0,owned_serve,&job,0,0);
 if(stage==4||stage==12){fwp_p_task_yield();if(task->done||encoded!=1)_Exit(251);fwp_p_task_cancel(PTR(task));}
 fwp_await(task);
 if(finished!=1||cancelled!=((stage==4||stage==12)?1:0)||trapped!=((stage==2||stage==3||stage==11)?1:0))_Exit(252);
 int expected=(stage==1||stage==2||stage==10)?0:1;if(encoded!=expected)_Exit(253);

 fwp_lib_finish();return 0;
}
