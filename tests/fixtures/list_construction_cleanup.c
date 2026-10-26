static int generation_operation,generation_case,generation_collect,generation_dups,generation_nodes,generation_scratch_calls,generation_callbacks;
static jmp_buf generation_jump;
static int generation_recover(void){return 1;}
static void generation_drop_text(V value){if(fwp_rc_release_last(value))fwp_rc_free_obj(value);}
static void generation_drop_list(V value){
    while(value){if(!fwp_rc_release_last(value))return;V next=OBJ(value)->f[1];generation_drop_text(OBJ(value)->f[0]);fwp_rc_free_obj(value);value=next;}
}
static void generation_drop_chunks(V value){
    while(value){if(!fwp_rc_release_last(value))return;V next=OBJ(value)->f[1];generation_drop_list(OBJ(value)->f[0]);fwp_rc_free_obj(value);value=next;}
}
static void generation_gc(void){
}
static void generation_dup(V value){
    generation_dups++;
    if((generation_case==1&&generation_dups==(generation_operation<2?2:1))||
       (generation_case==4&&generation_operation<2&&generation_dups==3))fwp_trap("generation retain failure");
    fwp_rc_dup(value);generation_gc();
}
static void generation_initial(V f,V x){(void)f;generation_dup(x);}
static V generation_call(V f,uint32_t n,V *args){
    (void)f;(void)n;
    if(!STR(args[0])->len)fwp_trap("invalid borrowed state");
    generation_gc();
    if(generation_case==4&&++generation_callbacks==2)fwp_trap("generation callback failure");
    return fwp_rc_fresh(fwp_cstr("fresh state"));
}
static void generation_scratch_event(void){
    generation_gc();generation_scratch_calls++;
    if((generation_case==5&&generation_scratch_calls==1)||(generation_case==6&&generation_scratch_calls==2))fwp_trap("generation scratch failure");
}
static V *generation_items(V xs,size_t *n){generation_scratch_event();return fwp_map_items(xs,n);}
static void *generation_scratch(size_t n){generation_scratch_event();return fwp_mem_alloc(n);}
static V generation_node(V *fields){
    generation_gc();generation_nodes++;
    if((generation_case==2&&generation_nodes==1)||(generation_case==3&&generation_nodes==2)||
       (generation_case==7&&generation_nodes==6))fwp_trap("generation node failure");
    return fwp_data(1,2,fields);
}
int main(int argc,char **argv){
    if(argc!=2)return 242;generation_operation=atoi(argv[1]);
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    V values[5];for(int i=0;i<5;i++)values[i]=fwp_rc_fresh(fwp_cstr("input"));
    V xs=0;for(int i=3;i>=0;i--)xs=fwp_rc_fresh(fwp_cons(values[i],xs));
    for(generation_collect=0;generation_collect<2;generation_collect++)for(generation_case=0;generation_case<8;generation_case++)for(int repeat=0;repeat<8;repeat++){
        if((generation_case==5&&generation_operation==0)||
           (generation_case==6&&generation_operation!=1&&generation_operation!=2)||
           (generation_case==7&&generation_operation!=1))continue;
        generation_dups=generation_nodes=generation_scratch_calls=generation_callbacks=0;
        size_t before=fwp_heap.live;
        fwp_trap_recover=generation_recover;fwp_trap_jb=&generation_jump;fwp_trap_cleanup=fwp_cleanups;
        if(!setjmp(generation_jump)){
            V result=0;
            switch(generation_operation){
            case 0:result=fwp_p_repeat_owned(4,values[4],generation_dup,generation_drop_text,generation_drop_list);break;
            case 1:result=fwp_p_chunks_owned(2,xs,generation_dup,generation_drop_text,generation_drop_list,generation_drop_chunks);break;
            case 2:result=fwp_p_scan_owned(0,values[4],xs,generation_drop_text,generation_drop_list);break;
            case 3:result=fwp_p_iterate_owned(4,0,values[4],generation_drop_text,generation_drop_list);break;
            default:return 242;
            }
            if(generation_case||fwp_list_len(result)!=(generation_operation==1?2:generation_operation==2?5:4))return 243;
            if(generation_operation==1)generation_drop_chunks(result);else generation_drop_list(result);
        }else if(!generation_case)return 245;
        fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if(fwp_cleanups)return 246;
        for(int i=0;i<5;i++)if(*fwp_rc_slot(values[i])!=1)return 248;
        if(!generation_collect&&fwp_heap.live!=before)return 249;
    }
    FWP_KEEP_ALIVE(xs);generation_drop_list(xs);generation_drop_text(values[4]);return 0;
}
