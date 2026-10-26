int main(void) {
    fwp_heap_start();
    const size_t baseline=fwp_heap.live;
    V child=fwp_rc_fresh(fwp_record(1,(V[]){7}));
    V parent=fwp_rc_fresh(fwp_record(1,&child));
    V aliases[255];
    for(int i=0;i<255;i++){aliases[i]=parent;fwp_rc_dup(parent);}
    uint8_t *count=fwp_rc_slot(parent);
    if(!count || *count!=255 || (*fwp_rc_wide_link(count))->count!=256)return 1;
    /* An independently returned child acquires an owner before its caller
     * attempts an update. The parent's aliases still observe the original. */
    V reachable=OBJ(aliases[0])->f[0];
    fwp_rc_dup(reachable);
    V updated=reachable;
    if(fwp_rc_unique(reachable)!=1)
        updated=fwp_rc_fresh(fwp_record(1,OBJ(reachable)->f));
    OBJ(updated)->f[0]=9;
    if(OBJ(OBJ(aliases[254])->f[0])->f[0]!=7)return 2;
    if(OBJ(updated)->f[0]!=9)return 3;
    if(!fwp_rc_release_last(updated))return 4;
    fwp_rc_free_obj(updated);
    if(fwp_rc_release_last(reachable))return 5;
    for(int i=0;i<255;i++)if(fwp_rc_release_last(aliases[i]))return 6;
    if(!fwp_rc_release_last(parent) || !fwp_rc_release_last(child))return 7;
    fwp_rc_free_obj(child);fwp_rc_free_obj(parent);

    V first=fwp_rc_fresh(fwp_record(1,(V[]){11}));
    V second=fwp_rc_fresh(fwp_record(1,(V[]){12}));
    V pair=fwp_rc_fresh(fwp_record(2,(V[]){first,second}));
    if(fwp_rc_slot(PTR(&OBJ(pair)->f[1]))!=fwp_rc_slot(pair))return 8;
    fwp_rc_dup(first);fwp_rc_dup(second);
    if(fwp_rc_unique(first)==1 || fwp_rc_unique(second)==1)return 9;
    if(!fwp_rc_release_last(pair))return 10;
    if(fwp_rc_release_last(first) || fwp_rc_release_last(second))return 11;
    fwp_rc_free_obj(pair);
    if(OBJ(first)->f[0]!=11 || OBJ(second)->f[0]!=12)return 12;
    if(!fwp_rc_release_last(first) || !fwp_rc_release_last(second))return 13;
    fwp_rc_free_obj(first);fwp_rc_free_obj(second);

    V branches[70];
    for(int i=0;i<70;i++) {
        V leaf=fwp_rc_fresh(fwp_record(1,(V[]){(V)i}));
        branches[i]=fwp_rc_fresh(fwp_record(1,&leaf));
    }
    V wide=fwp_rc_fresh(fwp_record(70,branches));
    fwp_rc_dup(wide);
    if(fwp_rc_release_last(wide))return 14;
    for(int i=0;i<70;i++) {
        V branch=OBJ(wide)->f[i],leaf=OBJ(branch)->f[0];
        fwp_rc_dup(leaf);
        if(fwp_rc_unique(leaf)==1 || OBJ(leaf)->f[0]!=(V)i)return 15;
        if(fwp_rc_release_last(leaf))return 16;
    }
    if(!fwp_rc_release_last(wide))return 17;
    for(int i=0;i<70;i++) {
        V branch=OBJ(wide)->f[i],leaf=OBJ(branch)->f[0];
        if(!fwp_rc_release_last(branch) || !fwp_rc_release_last(leaf))return 18;
        fwp_rc_free_obj(leaf);fwp_rc_free_obj(branch);
    }
    fwp_rc_free_obj(wide);
    if(fwp_heap.live!=baseline || fwp_heap.rc_wide_len)return 19;
    puts("counted descendants protected");
    return 0;
}
