static void *wasm_arc_leaf,*wasm_arc_pair;
static unsigned wasm_arc_leaf_frees,wasm_arc_pair_frees;
static void wasm_arc_observe_free(void *p){
    if(p==wasm_arc_leaf)wasm_arc_leaf_frees++;
    if(p==wasm_arc_pair)wasm_arc_pair_frees++;
    free(p);
}
/* The harness places this observer before the generated runtime's frees. */
static int wasm_arc_recover(void){return 1;}
static jmp_buf wasm_arc_jump;
static void wasm_arc_drop_leaf(V value){if(fwp_rc_release_last(value))fwp_rc_free_obj(value);}
static void wasm_arc_drop_pair(V value){
    if(!fwp_rc_release_last(value))return;
    wasm_arc_drop_leaf(OBJ(value)->f[0]);wasm_arc_drop_leaf(OBJ(value)->f[1]);fwp_rc_free_obj(value);
}
int main(void){
    fwp_gc_start(__builtin_frame_address(0));
    for(int i=0;i<128;i++){
        V leaf=fwp_rc_fresh(fwp_cstr("counted WASI data"));fwp_rc_dup(leaf);
        V pair=fwp_rc_fresh(fwp_tuple2(leaf,leaf));
        wasm_arc_leaf=(void *)(uintptr_t)leaf;wasm_arc_pair=(void *)(uintptr_t)pair;
        wasm_arc_leaf_frees=wasm_arc_pair_frees=0;
        for(int j=0;j<300;j++)fwp_rc_dup(pair);
        for(int j=0;j<300;j++)wasm_arc_drop_pair(pair);
        if(!fwp_rc_last(pair)||wasm_arc_leaf_frees||wasm_arc_pair_frees)return 236;
        wasm_arc_drop_pair(pair);
        if(wasm_arc_leaf_frees!=1||wasm_arc_pair_frees!=1)return 237;
        if(fwp_wasm_counts_live)return 238;
        wasm_arc_leaf=wasm_arc_pair=NULL;
    }
    V value=fwp_rc_fresh(fwp_cstr("keep counted"));
    fwp_trap_recover=wasm_arc_recover;fwp_trap_jb=&wasm_arc_jump;
    if(!setjmp(wasm_arc_jump)){fwp_rc_share(value);return 239;}
    fwp_trap_recover=NULL;fwp_trap_jb=NULL;
    if(!fwp_rc_last(value)||fwp_wasm_counts_live!=1)return 240;
    fwp_wasm_rc *entry=*fwp_wasm_count_link(value);
    fwp_wasm_set_count(entry,UINT64_MAX);
    fwp_trap_recover=wasm_arc_recover;fwp_trap_jb=&wasm_arc_jump;
    if(!setjmp(wasm_arc_jump)){fwp_rc_dup(value);return 241;}
    fwp_trap_recover=NULL;fwp_trap_jb=NULL;
    if(fwp_wasm_count(entry)!=UINT64_MAX)return 242;
    fwp_wasm_set_count(entry,1);fwp_rc_free_obj(value);
    V bits[]={0,1,4096,UINT64_MAX};
    for(size_t i=0;i<sizeof bits/sizeof *bits;i++){
        fwp_rc_dup(bits[i]);fwp_rc_drop(bits[i]);fwp_rc_share(bits[i]);fwp_rc_free_obj(bits[i]);
        if(fwp_rc_slot(bits[i]))return 243;
    }
    return fwp_wasm_counts_live?244:0;
}
