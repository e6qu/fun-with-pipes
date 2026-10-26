static int capture_left,capture_alias;
static V capture_input;
static jmp_buf capture_jump;
static int capture_recover(void){return 1;}
static void capture_allocation(void){if(capture_left>0&&!--capture_left)fwp_trap("injected capture allocation failure");}
static V capture_callback(void){
 h2_hdrs *headers=g_ctx_of()->capture;
 h2_hdrs_add(headers,"x-a",3,"one",3);
 h2_hdrs_add(headers,"x-b",3,"two",3);
 h2_hdrs_add(headers,"x-a",3,"three",5);
 if(capture_alias){CAPTURE_TYPE->fields[0]->dup(capture_input);return capture_input;}
 return fwp_rc_fresh(fwp_cstr("callback result"));
}
static int capture_matches(V result){
 if(strcmp(STR(OBJ(result)->f[0])->d,"callback result"))return 0;
 const char *names[]={"x-a","x-b","x-a"},*values[]={"one","two","three"};
 V list=OBJ(result)->f[1];
 for(int i=0;i<3;i++){
  if(!list)return 0;V pair=OBJ(list)->f[0];
  if(strcmp(STR(OBJ(pair)->f[0])->d,names[i])||strcmp(STR(OBJ(pair)->f[1])->d,values[i]))return 0;
  list=OBJ(list)->f[1];
 }
 return list==0;
}
int main(void){
 fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 capture_input=fwp_rc_fresh(fwp_cstr("callback result"));
 size_t live_bytes=fwp_heap.live;
 for(capture_alias=0;capture_alias<2;capture_alias++){
  /* Check each request directly; do not carry a second loop tally across longjmp. */
  const int failures=capture_alias?13:14;
  for(int allocation=1;allocation<=failures+1;allocation++){
   fwp_trap_recover=capture_recover;fwp_trap_jb=&capture_jump;fwp_trap_cleanup=fwp_cleanups;capture_left=allocation;
   if(!setjmp(capture_jump)){
    V result=fwp_p_grpc_with_response_metadata(0,CAPTURE_TYPE);capture_left=0;
    if(!capture_matches(result)||capture_live)return 247;
    CAPTURE_TYPE->dup(result);CAPTURE_TYPE->drop(result);
    if(!capture_matches(result))return 247;
    CAPTURE_TYPE->drop(result);
    if(allocation<=failures){
     fprintf(stderr,"capture alias %d: allocation %d did not fail\n",capture_alias,allocation);return 247;
    }
   }else if(allocation>failures||capture_left||strcmp(fwp_trap_msg,"injected capture allocation failure")){
    fprintf(stderr,"capture alias %d: unexpected trap at allocation %d: %s\n",capture_alias,allocation,fwp_trap_msg);return 247;
   }
   capture_left=0;fwp_trap_recover=NULL;fwp_trap_jb=NULL;
   if(fwp_heap.live!=live_bytes||fwp_cleanups||capture_live||fwp_cur->gctx)return 248;
   if(!fwp_rc_last(capture_input))return 248;
  }
  printf("capture alias %d: %d allocation failures; final charged delta 0; capture owners 0\n",capture_alias,failures);
 }
 CAPTURE_TYPE->fields[0]->drop(capture_input);return 0;
}
