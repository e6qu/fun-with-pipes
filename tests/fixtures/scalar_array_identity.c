static void identity_drop(V value) { fwp_arg_drop2(&value, 0, 1); }
int main(int argc, char **argv) {
    (void)argv;
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    const fwp_desc scalar = {.kind=K_F64};
    const V words[] = {0, UINT64_C(0x8000000000000000), 1,
        UINT64_C(0x7ff0000000000000), UINT64_C(0xfff8000000000042),
        UINT64_C(0x7ff0000000000042), UINT64_C(0x3ff0000000000000)};
    for (int round=0; round<16; round++) {
        for (int sliced=0; sliced<2; sliced++) for (int alias=0; alias<2; alias++) {
            for (size_t length=0; length<=64; length+=32) {
                size_t baseline=fwp_heap.live;
                size_t live=owner_ledger_live;
                V backing=fwp_array_typed_new(length+32,&scalar);
                for(size_t i=0;i<length+32;i++) fwp_array_store(backing,i,words[i%7],&scalar);
                V input;
                size_t offset;
                if(sliced) {
                    input=fwp_p_array_slice_typed(16,length,backing,NULL,&scalar);
                    offset=16;
                } else {
                    identity_drop(backing); backing=0;
                    input=fwp_array_typed_new(length,&scalar);
                    for(size_t i=0;i<length;i++) fwp_array_store(input,i,words[i%7],&scalar);
                    offset=0;
                }
                if(alias) fwp_rc_dup(input);
                size_t allocations=owner_ledger_allocations, retains=identity_retains;
                V result=f2(input);
                if(IDENTITY_SELECTED) {
                    if(result!=input || owner_ledger_allocations!=allocations || identity_retains!=retains) return 81;
                } else if(result==input || owner_ledger_allocations!=allocations+1) return 82;
                if(fwp_array_len(result)!=length) return 83;
                for(size_t i=0;i<length;i++)
                    if(fwp_array_load(result,i,&scalar)!=words[(i+offset)%7]) return 84;
                if(length) {
                    V changed=fwp_p_array_set_typed(0,UINT64_C(0x4000000000000000),result,NULL,NULL,identity_drop,&scalar);
                    result=OBJ(changed)->f[0]; fwp_rc_free_obj(changed);
                    if(fwp_array_load(result,0,&scalar)!=UINT64_C(0x4000000000000000)) return 85;
                    if(alias && fwp_array_load(input,0,&scalar)!=words[offset%7]) return 86;
                }
                if(argc==1) identity_drop(result); /* missing-release control */
                if(alias) identity_drop(input);
                if(backing) {
                    for(size_t i=0;i<length+32;i++)
                        if(fwp_array_load(backing,i,&scalar)!=words[i%7]) return 87;
                    identity_drop(backing);
                }
                if(fwp_heap.live!=baseline || owner_ledger_live!=live || fwp_heap.rc_wide_len) return 90;
            }
        }
    }
    owner_ledger_finish();
    puts("identity arrays: moves, aliases, slices, updates and cleanup pass");
    return 0;
}
