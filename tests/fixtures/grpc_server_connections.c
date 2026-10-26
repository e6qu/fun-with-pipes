/* Accepted connection storage moves to its reader; writer, job and channel
 * users have independent references. A host alias observes closed transport. */
static int accept_calls,accept_attempts,reader_failed;
static fwp_socket_t connection_accept(fwp_socket_t fd,struct sockaddr *address,socklen_t *length){
 if(accept_calls)fwp_trap("accept complete");
 /* A readiness retry is not an accepted connection. Exercise it explicitly. */
 if(!accept_attempts++){errno=EAGAIN;return FWP_INVALID_SOCKET;}
 fwp_socket_t accepted=fwp_socket_accept(fd,address,length);
 if(accepted!=FWP_INVALID_SOCKET)accept_calls++;
 return accepted;
}
static SSL *connection_tls(SSL_CTX *ctx,fwp_socket_t fd){(void)ctx;(void)fd;return NULL;}
static void connection_reader(void *arg,int cancelled){
 if(connection_stage!=4){g_reader(arg,cancelled);return;}
 g_conn *c=arg;jmp_buf failure;jmp_buf *saved=fwp_cur->trap_jb;fwp_cleanup *base=fwp_cur->trap_cleanup;
 int unwinding=fwp_cur->unwinding;
 fwp_cur->trap_jb=&failure;fwp_cur->trap_cleanup=fwp_cleanups;
 if(!setjmp(failure)){g_reader(arg,cancelled);_Exit(251);}
 if(strcmp(fwp_trap_msg,"writer startup trap")||c->refs!=1||*fwp_rc_slot(PTR(c))!=2)_Exit(252);
 reader_failed++;fwp_cur->trap_jb=saved;fwp_cur->trap_cleanup=base;fwp_cur->unwinding=unwinding;fwp_trap_jb=saved;fwp_trap_cleanup=base;
 g_conn_dead(c,"writer startup failed");g_conn_release(c); /* driver's reader owner */
}
static void connection_overflow(V value){uint8_t *slot=fwp_rc_slot(value);*slot=254;fwp_rc_dup(value);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;}
static void connection_restore(V value,unsigned n){uint8_t *slot=fwp_rc_slot(value);fwp_rc_forget_slot(slot);*slot=(uint8_t)n;}
int main(int argc,char **argv){
 if(argc!=2)_Exit(230);connection_stage=atoi(argv[1]);
 fwp_lib_init();fwp_heap_start();fwp_tasks_init();fwp_trap_recover=g_trap_recover;
 if(fwp_sockets_init())_Exit(231);
 fwp_socket_t listener=fwp_socket_open(AF_INET,SOCK_STREAM,0),client=fwp_socket_open(AF_INET,SOCK_STREAM,0);
 if(listener==FWP_INVALID_SOCKET||client==FWP_INVALID_SOCKET)_Exit(232);
 struct sockaddr_in address={0};address.sin_family=AF_INET;address.sin_addr.s_addr=htonl(INADDR_LOOPBACK);
 if(bind(listener,(struct sockaddr *)&address,sizeof address)||listen(listener,1))_Exit(233);
 socklen_t length=sizeof address;if(getsockname(listener,(struct sockaddr *)&address,&length))_Exit(234);
 if(fwp_socket_connect(client,(struct sockaddr *)&address,length))_Exit(235);
 g_server server={0};server.module="probe";server.tls=connection_stage==1?(SSL_CTX *)(uintptr_t)1:NULL;
 jmp_buf failure;fwp_cur->trap_jb=&failure;fwp_cur->trap_cleanup=fwp_cleanups;
 if(!setjmp(failure)){g_accept_loop(listener,&server);_Exit(236);}
 fwp_cur->trap_jb=0;fwp_cur->trap_cleanup=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
 if(strcmp(fwp_trap_msg,connection_stage==0?"accepted startup trap":"accept complete")||fwp_cleanups||!seen_connection){
  fprintf(stderr,"accept recovery: stage=%d trap=%s cleanups=%p connection=%p accepted=%d attempts=%d\n",connection_stage,fwp_trap_msg,(void *)fwp_cleanups,seen_connection,accept_calls,accept_attempts);_Exit(237);
 }
 fwp_fd_closing(listener);fwp_socket_close(listener);
 g_conn *c=seen_connection;g_job *retained=NULL;V channel=0;
 if(connection_stage<2){
  if(connection_finals!=1||seen_reader||fwp_tasks_active)_Exit(238);
 }else{
  if(connection_finals||!seen_reader||c->refs!=1||(connection_stage==9?*fwp_rc_slot(PTR(c))!=0:!fwp_rc_last(PTR(c))))_Exit(239);
  fwp_rc_dup(PTR(c)); /* independently retained host alias */
  if(connection_stage==3)fwp_cancel_tree((fwp_task *)seen_reader);
  if(connection_stage>=6){
   g_stream *s=g_stream_new(c,1);if(connection_stage!=9)fwp_rc_fresh(PTR(s));s->remote_end=1;
   if(connection_stage==8||connection_stage==9){
    static const fwp_desc integer_type={.kind=K_I64,.name="I64"};
    static const int schema[]={PB_MSG,1,1,4,PB_SINT,8};
    g_codec codec={0};codec.ty=&integer_type;codec.schema=schema;
    channel=g_sink_value(c,s,codec,0);
   }else{
    fwp_rc_dup(PTR(s)); /* pending owner transferred to g_start_call */
    if(connection_stage==6){
     connection_overflow(PTR(c));fwp_cur->trap_jb=&failure;fwp_cur->trap_cleanup=fwp_cleanups;
     if(!setjmp(failure)){g_start_call(c,s);_Exit(254);}
     fwp_cur->trap_jb=0;fwp_cur->trap_cleanup=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
     if(strcmp(fwp_trap_msg,"reference count overflow")||fwp_cleanups||s->task||!fwp_rc_last(PTR(s))||(*fwp_rc_wide_link(fwp_rc_slot(PTR(c))))->count!=SIZE_MAX)_Exit(240);
     connection_restore(PTR(c),2);g_unlink(c,s);
    }else{
     g_start_call(c,s);retained=(g_job *)s->task->carg;retained->sv.peer_users++;
    }
   }
  }
 }
 shutdown(client,SHUT_RDWR);fwp_socket_close(client);
 int64_t until=fwp_now_ns()+10000000000LL;
 while(fwp_tasks_active){if(fwp_now_ns()>=until)_Exit(241);fwp_park(0,fwp_now_ns()+1000000LL);fwp_free_zombie();}
 fwp_free_zombie();
 if(connection_stage==9){
  /* Explicit no-reuse compilation leaves the callback graph traced. The
   * channel must remain safe after I/O retirement, without premature disposal. */
  if(connection_finals||c->refs||c->fd!=FWP_INVALID_SOCKET||c->streams||!c->dead||*fwp_rc_slot(PTR(c))||*fwp_rc_slot(channel))_Exit(248);
  if(fwp_p_channel_send_owned(channel,(V)1,NULL)!=FWP_FALSE)_Exit(249);
  FWP_KEEP_ALIVE(channel);
 }else if(connection_stage>=2){
  if(connection_finals||c->refs||c->fd!=FWP_INVALID_SOCKET||c->streams||!c->dead||reader_failed!=(connection_stage==4))_Exit(242);
  if(*fwp_rc_slot(PTR(c))!=((retained||channel)?2:1))_Exit(243);
  g_conn_drop(c);
  if(retained){if(connection_finals||retained->sv.task||retained->s->task||!fwp_rc_last(PTR(retained->s)))_Exit(244);g_serving_peer_release(&retained->sv);}
  if(channel){if(connection_finals)_Exit(245);fwp_channel_drop(channel);}
  if(connection_finals!=1||fwp_cleanups)_Exit(246);
 }
 // All accepted sockets, including startup rejection, must be closed once.
 int type=0;socklen_t size=sizeof type;
 if(getsockopt(seen_fd,SOL_SOCKET,SO_TYPE,(char *)&type,&size)==0)_Exit(247);
 fwp_lib_finish();return 0;
}
