static int zip_case,zip_collect,zip_x_calls,zip_y_calls,zip_items_calls,zip_pair_calls,zip_node_calls;
static jmp_buf zip_jump;
static int zip_recover(void){return 1;}
static void zip_drop_string(V value){if(fwp_rc_release_last(value))fwp_rc_free_obj(value);}
static void zip_drop_pair(V value){
    if(!fwp_rc_release_last(value))return;
    zip_drop_string(OBJ(value)->f[0]);zip_drop_string(OBJ(value)->f[1]);fwp_rc_free_obj(value);
}
static void zip_drop_list(V value){
    while(value){if(!fwp_rc_release_last(value))return;V next=OBJ(value)->f[1];zip_drop_pair(OBJ(value)->f[0]);fwp_rc_free_obj(value);value=next;}
}
static void zip_drop_input(V value){
    while(value){if(!fwp_rc_release_last(value))return;V next=OBJ(value)->f[1];zip_drop_string(OBJ(value)->f[0]);fwp_rc_free_obj(value);value=next;}
}
static void zip_dup_x(V value){
    if(zip_case==1&&++zip_x_calls==2)fwp_trap("zip first retain failure");
    fwp_rc_dup(value);
#ifndef FWP_ARC_ONLY
    if(zip_collect)fwp_gc_collect();
#endif
}
static void zip_dup_y(V value){
    zip_y_calls++;
    if((zip_case==2&&zip_y_calls==1)||(zip_case==3&&zip_y_calls==2))fwp_trap("zip second retain failure");
    fwp_rc_dup(value);
}
static V *zip_probe_items(V xs,size_t *n){
    if(zip_case==4&&++zip_items_calls==2)fwp_trap("zip scratch failure");
    return fwp_map_items(xs,n);
}
static V zip_probe_pair(V x,V y){
#ifndef FWP_ARC_ONLY
    if(zip_collect)fwp_gc_collect();
#endif
    if(zip_case==5&&++zip_pair_calls==2)fwp_trap("zip pair failure");
    return fwp_tuple2(x,y);
}
static V zip_probe_node(V *fields){
#ifndef FWP_ARC_ONLY
    if(zip_collect)fwp_gc_collect();
#endif
    if(zip_case==6&&++zip_node_calls==2)fwp_trap("zip list failure");
    return fwp_data(1,2,fields);
}
int main(void){
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    V values[4];for(int i=0;i<4;i++)values[i]=fwp_rc_fresh(fwp_cstr("zip input"));
    V xs=fwp_rc_fresh(fwp_cons(values[0],fwp_rc_fresh(fwp_cons(values[1],0))));
    V ys=fwp_rc_fresh(fwp_cons(values[2],fwp_rc_fresh(fwp_cons(values[3],0))));
    for(zip_collect=0;zip_collect<2;zip_collect++)for(zip_case=0;zip_case<8;zip_case++)for(int repeat=0;repeat<16;repeat++){
        zip_x_calls=zip_y_calls=zip_items_calls=zip_pair_calls=zip_node_calls=0;
        if(zip_case==7){uint8_t *slot=fwp_rc_slot(values[2]);*slot=254;fwp_rc_dup(values[2]);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;}
        intptr_t before=fwp_gc.budget;
        fwp_trap_recover=zip_recover;fwp_trap_jb=&zip_jump;fwp_trap_cleanup=fwp_cleanups;
        if(!setjmp(zip_jump)){
            V result=fwp_p_zip_owned(ys,xs,zip_dup_x,zip_dup_y,zip_drop_string,zip_drop_string,zip_drop_pair,zip_drop_list);
            if(zip_case||fwp_list_len(result)!=2)return 243;
            V first=OBJ(result)->f[0],second=OBJ(OBJ(result)->f[1])->f[0];
            if(OBJ(first)->f[0]!=values[0]||OBJ(first)->f[1]!=values[2]||OBJ(second)->f[0]!=values[1]||OBJ(second)->f[1]!=values[3])return 244;
            zip_drop_list(result);
        }else if(!zip_case)return 245;
        fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if(fwp_cleanups)return 246;
        for(int i=0;i<4;i++){
            uint8_t *slot=fwp_rc_slot(values[i]);
            if(zip_case==7&&i==2){if(*slot!=255||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 247;fwp_rc_forget_slot(slot);*slot=1;}
            else if(*slot!=1)return 248;
        }
        if(!zip_collect&&fwp_gc.budget!=before)return 249;
    }
    FWP_KEEP_ALIVE(xs);FWP_KEEP_ALIVE(ys);zip_drop_input(xs);zip_drop_input(ys);return 0;
}
