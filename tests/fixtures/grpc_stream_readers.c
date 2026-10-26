/* Two tasks request the same unread position before a producer supplies data.
 * This forces scheduler handoffs without depending on socket timing. */
typedef struct {
    g_cell *cell;
    V value;
    int started, completed, cancelled;
} stream_reader;
typedef struct {
    g_stream *stream;
    fwp_task *cancel;
    stream_reader *first, *second;
    int during_decode;
} stream_producer;
static int recover_recursive_read(void) { return 1; }
static void read_position(void *p, int cancelled) {
    stream_reader *reader = p;
    if (cancelled) { reader->cancelled++; return; }
    reader->started++;
    g_failure failure = {0}; V error = 0; const fwp_desc *type = 0;
    reader->value = g_force(reader->cell, 0, &failure, &error, &type);
    reader->completed++;
}
static void queue_message(g_stream *stream, int index) {
    g_msg *message = malloc(sizeof *message + 3);
    if(!message)_Exit(42);
    message->next=0; message->n=3;
    message->d[0]=10; message->d[1]=1; message->d[2]=(unsigned char)('a'+index);
    if(stream->mtail)stream->mtail->next=message;
    else stream->mhead=message;
    stream->mtail=message;
}
static void publish_messages(void *p, int cancelled) {
    if (cancelled) _Exit(40);
    stream_producer *producer = p;
    if(producer->first->started!=1||producer->second->started!=1)_Exit(41);
    if(producer->cancel && !producer->during_decode) {
        fwp_cancel_tree(producer->cancel);
        /* Let the cancelled task unwind before publishing any message. */
        fwp_preempt();
    }
    for(int i=0;i<(producer->during_decode==5?1:2);i++)
        queue_message(producer->stream,i);
    producer->stream->remote_end=1;
    fwp_wake_all(&producer->stream->waiters);
    if(producer->during_decode) {
        fwp_preempt(); /* receiver takes 'a', then yields from the decoder */
        if(!decode_started)_Exit(51);
        fwp_cancel_tree(producer->cancel);
        fwp_preempt();
        if(producer->during_decode==5) {
            if(producer->first->cancelled!=1)_Exit(52);
            /* The restored message must become the tail of an empty queue. */
            queue_message(producer->stream,1);
        }
    }
}
int main(int argc, char **argv) {
    if(argc!=2)return 30;
    int mode=atoi(argv[1]); /* 0: both; 1/2: cancel receiver/waiter; 3: recursion; 4/5: decode with queued/later data */
    if(mode<0||mode>5)return 31;
    fwp_lib_init(); fwp_heap_start(); fwp_tasks_init();
    fwp_cur->deadline=fwp_now_ns()+10000000000LL; /* bound a broken wakeup */
    g_server server={0}; server.module="readers";
    g_conn *connection=g_conn_new(FWP_INVALID_SOCKET, "", "queued",&server);
    g_stream *stream=g_stream_new(connection,1);
    const int schema[]={PB_MSG,1,1,4,PB_STR};
    const fwp_desc string_type={.kind=K_STR,.name="String",.drop=fwp_rc_free_obj};
    g_incoming *source=g_incoming_new("queued.string",13);
    source->c=connection; source->s=stream; source->server=1;
    source->dec.schema=schema; source->dec.ty=&string_type;
    g_cell *cell=fwp_mem_alloc(sizeof *cell); cell->src=source;
    if(mode==3) {
        jmp_buf recursive;
        source->reader=fwp_cur;
        fwp_trap_recover=recover_recursive_read;
        fwp_trap_jb=&recursive;
        fwp_trap_cleanup=fwp_cleanups;
        if(!setjmp(recursive)) {
            g_failure failure={0}; V error=0; const fwp_desc *type=0;
            (void)g_force(cell,0,&failure,&error,&type);
            return 49;
        }
        fwp_trap_recover=0; fwp_trap_jb=0; fwp_trap_cleanup=0;
        if(strcmp(fwp_trap_msg,"recursive stream read")||cell->forced||cell->src!=source||
           source->reader!=fwp_cur||source->read_waiters.head)return 50;
        source->reader=0;
        FWP_KEEP_ALIVE(PTR(cell)); FWP_KEEP_ALIVE(PTR(source));
        fwp_lib_finish(); return 0;
    }
    stream_reader first={cell,0,0,0,0}, second={cell,0,0,0,0};
    fwp_task *a=fwp_spawn_task(0,read_position,&first,0,0);
    fwp_task *b=fwp_spawn_task(0,read_position,&second,0,0);
    pause_decode=mode>=4;
    stream_producer producer={stream,(mode==1||mode>=4)?a:mode==2?b:0,&first,&second,mode>=4?mode:0};
    fwp_spawn_task(0,publish_messages,&producer,0,0);
    fwp_join_children();
    if(fwp_cur->cancelled)return 48;
    if(mode==0) {
        if(first.completed!=1||second.completed!=1||first.value!=second.value)return 43;
    } else {
        stream_reader *cancelled=(mode==1||mode>=4)?&first:&second, *survived=(mode==1||mode>=4)?&second:&first;
        if(cancelled->completed||cancelled->cancelled!=1||survived->completed!=1||survived->cancelled)return 44;
    }
    if(!cell->forced||source->reader||source->read_waiters.head)return 45;
    if(!stream->mhead||stream->mhead!=stream->mtail||stream->mhead->d[2]!='b')return 46;
    V text=OBJ(OBJ(cell->memo)->f[0])->f[0];
    if(STR(text)->len!=1||STR(text)->d[0]!='a')return 47;
    FWP_KEEP_ALIVE(PTR(a)); FWP_KEEP_ALIVE(PTR(b));
    FWP_KEEP_ALIVE(PTR(cell)); FWP_KEEP_ALIVE(PTR(source)); FWP_KEEP_ALIVE(PTR(connection));
    fwp_lib_finish(); return 0;
}
