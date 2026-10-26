static int unzip_case,unzip_collect,unzip_x_calls,unzip_y_calls,unzip_scratch_calls,unzip_node_calls;
static jmp_buf unzip_jump;
static int unzip_recover(void){return 1;}
static void unzip_drop_string(V value){if(fwp_rc_release_last(value))fwp_rc_free_obj(value);}
static void unzip_drop_strings(V value){
    while(value){if(!fwp_rc_release_last(value))return;V next=OBJ(value)->f[1];unzip_drop_string(OBJ(value)->f[0]);fwp_rc_free_obj(value);value=next;}
}
static void unzip_drop_input(V value){
    while(value){if(!fwp_rc_release_last(value))return;V next=OBJ(value)->f[1],pair=OBJ(value)->f[0];
        if(fwp_rc_release_last(pair)){unzip_drop_string(OBJ(pair)->f[0]);unzip_drop_string(OBJ(pair)->f[1]);fwp_rc_free_obj(pair);}
        fwp_rc_free_obj(value);value=next;}
}
static void unzip_collect_now(void){
}
static void unzip_dup_x(V value){
    if(unzip_case==1&&++unzip_x_calls==2)fwp_trap("unzip left retain failure");
    fwp_rc_dup(value);unzip_collect_now();
}
static void unzip_dup_y(V value){
    unzip_y_calls++;
    if((unzip_case==2&&unzip_y_calls==1)||(unzip_case==3&&unzip_y_calls==2))fwp_trap("unzip right retain failure");
    fwp_rc_dup(value);
}
static void *unzip_scratch(size_t size){
    unzip_scratch_calls++;unzip_collect_now();
    if((unzip_case==4&&unzip_scratch_calls==1)||(unzip_case==5&&unzip_scratch_calls==2))fwp_trap("unzip scratch failure");
    return fwp_mem_alloc(size);
}
static V unzip_node(V tag,size_t n,const V *fields){
    unzip_node_calls++;unzip_collect_now();
    if((unzip_case==6&&unzip_node_calls==2)||(unzip_case==7&&unzip_node_calls==4))fwp_trap("unzip node failure");
    return fwp_data(tag,n,fields);
}
static V unzip_pair(V x,V y){
    unzip_collect_now();if(unzip_case==8)fwp_trap("unzip pair failure");return fwp_tuple2(x,y);
}
int main(void){
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    V values[4];for(int i=0;i<4;i++)values[i]=fwp_rc_fresh(fwp_cstr("unzip input"));
    V first=fwp_rc_fresh(fwp_tuple2(values[0],values[1]));
    V second=fwp_rc_fresh(fwp_tuple2(values[2],values[3]));
    V ps=fwp_rc_fresh(fwp_cons(first,fwp_rc_fresh(fwp_cons(second,0))));
    for(unzip_collect=0;unzip_collect<2;unzip_collect++)for(unzip_case=0;unzip_case<10;unzip_case++)for(int repeat=0;repeat<16;repeat++){
        unzip_x_calls=unzip_y_calls=unzip_scratch_calls=unzip_node_calls=0;
        if(unzip_case==9){uint8_t *slot=fwp_rc_slot(values[1]);*slot=254;fwp_rc_dup(values[1]);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;}
        size_t before=fwp_heap.live;
        fwp_trap_recover=unzip_recover;fwp_trap_jb=&unzip_jump;fwp_trap_cleanup=fwp_cleanups;
        if(!setjmp(unzip_jump)){
            V result=fwp_p_unzip_owned(ps,unzip_dup_x,unzip_dup_y,unzip_drop_string,unzip_drop_string,unzip_drop_strings,unzip_drop_strings);
            if(unzip_case||fwp_list_len(OBJ(result)->f[0])!=2||fwp_list_len(OBJ(result)->f[1])!=2)return 243;
            V left=OBJ(result)->f[0],right=OBJ(result)->f[1];
            if(OBJ(left)->f[0]!=values[0]||OBJ(OBJ(left)->f[1])->f[0]!=values[2]||OBJ(right)->f[0]!=values[1]||OBJ(OBJ(right)->f[1])->f[0]!=values[3])return 244;
            unzip_drop_strings(left);unzip_drop_strings(right);fwp_rc_free_obj(result);
        }else if(!unzip_case)return 245;
        fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if(fwp_cleanups)return 246;
        for(int i=0;i<4;i++){
            uint8_t *slot=fwp_rc_slot(values[i]);
            if(unzip_case==9&&i==1){if(*slot!=255||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 247;fwp_rc_forget_slot(slot);*slot=1;}
            else if(*slot!=1)return 248;
        }
        if(!unzip_collect&&fwp_heap.live!=before)return 249;
    }
    unzip_case=unzip_collect=0;
    size_t before=fwp_heap.live;
    V empty=fwp_p_unzip_owned(0,NULL,NULL,NULL,NULL,unzip_drop_strings,unzip_drop_strings);
    if(OBJ(empty)->f[0]||OBJ(empty)->f[1])return 250;
    fwp_rc_free_obj(empty);if(fwp_heap.live!=before)return 251;
    unzip_drop_input(ps);return 0;
}
