static int file_events,file_fail_at,file_collect,file_write_error_mode;
static int file_buffer_frees;
static void file_buffer_free(void *p){if(p)file_buffer_frees++;free(p);}
static size_t file_write_probe(const void *p,size_t size,size_t count,FILE *stream){
 (void)p;(void)size;(void)stream;
 if(file_write_error_mode==1){errno=ENOSPC;return 0;}
 return count;
}
static int file_close_probe(FILE *stream){
 int result=fclose(stream);if(result)return result;
 errno=file_write_error_mode==1?EINVAL:EACCES;
 return file_write_error_mode==1?0:EOF;
}
static jmp_buf file_failure;
static int file_recover(void){return 1;}
static void file_event(void){
#if !FWP_ARC_ONLY
 if(file_collect)fwp_gc_collect();
#endif
 if(++file_events==file_fail_at)fwp_trap("file metadata probe");
}
static V file_duration(int64_t ns){file_event();return fwp_duration(ns);}
static V file_record(size_t n,const V *fields){file_event();return fwp_record(n,fields);}
static void file_drop_text(V value){if(value && fwp_rc_release_last(value))fwp_rc_free_obj(value);}
static void file_drop_info(V value){
 if(value && fwp_rc_release_last(value)){file_drop_text(OBJ(value)->f[1]);fwp_rc_free_obj(value);}
}
static volatile V file_path,file_output,file_data;
int main(int argc,char **argv){
 if(argc!=3)return 181;
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 file_path=fwp_rc_fresh(fwp_cstr(argv[1]));intptr_t budget=fwp_gc.budget;
 const char *setting=getenv("FWP_FILE_COLLECTION");file_collect=setting&&!strcmp(setting,"1");
 for(int i=0;i<128;i++){
  file_events=0;V info=fwp_p_file_info(file_path,NULL);
  if(*fwp_rc_slot(info)!=1 || *fwp_rc_slot(OBJ(info)->f[1])!=1)return 182;
  if(OBJ(info)->f[0]!=FWP_FALSE || OBJ(info)->f[2]!=70000)return 183;
  file_drop_info(info);
  V bytes=fwp_rc_fresh(fwp_p_file_read_bytes(file_path,NULL));
  if(STR(bytes)->len!=70000 || (unsigned char)STR(bytes)->d[0]!=255)return 184;
  file_drop_text(bytes);
  file_buffer_frees=0;
  /* The same buffer must be released when UTF-8 validation rejects the text. */
  fwp_handler handler={0};handler.prev=fwp_handlers;handler.cleanup=fwp_cleanups;fwp_handlers=&handler;
  if(!setjmp(handler.jb)){(void)fwp_p_file_read(file_path,NULL);return 196;}
  fwp_handlers=handler.prev;V error=handler.value;
  if(strcmp(STR(OBJ(error)->f[0])->d,"read") ||
     !strstr(STR(OBJ(error)->f[1])->d,"stream did not contain valid UTF-8"))return 197;
  if(!fwp_rc_release_last(error))return 198;
  file_drop_text(OBJ(error)->f[0]);file_drop_text(OBJ(error)->f[1]);fwp_rc_free_obj(error);
  handler.value=0;
  if(file_buffer_frees!=1)return 199;
  if(*fwp_rc_slot(file_path)!=1 || fwp_cleanups)return 185;
  if(!file_collect && fwp_gc.budget!=budget)return 186;
 }
 fwp_trap_recover=file_recover;fwp_trap_jb=&file_failure;fwp_trap_cleanup=fwp_cleanups;
 for(file_fail_at=1;file_fail_at<=2;file_fail_at++){
  file_events=0;
  if(!setjmp(file_failure)){(void)fwp_p_file_info(file_path,NULL);return 187;}
  if(fwp_cleanups!=fwp_trap_cleanup)return 188;
  if(!file_collect && fwp_gc.budget!=budget)return 189;
 }
 file_fail_at=0;fwp_trap_recover=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
 file_output=fwp_rc_fresh(fwp_cstr(argv[2]));file_data=fwp_rc_fresh(fwp_cstr("data"));
 budget=fwp_gc.budget;
 for(int kind=0;kind<3;kind++)for(file_write_error_mode=1;file_write_error_mode<=2;file_write_error_mode++){
  fwp_handler handler={0};handler.prev=fwp_handlers;handler.cleanup=fwp_cleanups;fwp_handlers=&handler;
  if(!setjmp(handler.jb)){
   if(kind==2)fwp_p_file_write_new(file_output,file_data,NULL);
   else if(kind==1)fwp_p_file_write_bytes(file_output,file_data,NULL);
   else fwp_p_file_append(file_output,file_data,NULL);
   return 191;
  }
  fwp_handlers=handler.prev;V error=handler.value;
  const char *expected=strerror(file_write_error_mode==1?ENOSPC:EACCES);
  if(!strstr(STR(OBJ(error)->f[1])->d,expected))return 192;
  if(!fwp_rc_release_last(error))return 193;
  file_drop_text(OBJ(error)->f[0]);file_drop_text(OBJ(error)->f[1]);fwp_rc_free_obj(error);
  handler.value=0;
  if(!file_collect && fwp_gc.budget!=budget)return 194;
 }
 file_drop_text(file_data);file_drop_text(file_output);file_drop_text(file_path);
 if(file_collect && !fwp_gc.ncollect)return 190;
 return 0;
}
