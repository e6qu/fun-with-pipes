static void identity_drop(V value) { fwp_arg_drop2(&value, 0, 1); }
static int identity_recover(void) { return 1; }
static fwp_task identity_cancel;
static void identity_fail(void) {
    if(identity_fault==2) { fwp_cur->cancelled=1; fwp_check_cancel(); }
    if(identity_fault==3) fwp_heap_oom();
    fwp_trap("identity boundary failure");
}
int main(int argc, char **argv) {
    if(argc!=2) return 93;
    int missing=!strcmp(argv[1],"missing-release");
    int allocation_failure=!strcmp(argv[1],"allocation-failure");
    if(!missing && !allocation_failure && strcmp(argv[1],"complete")) return 94;
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts(); fwp_budget=1000000;
    const fwp_desc scalar = {.kind=K_F64};
    if(allocation_failure) {
        V input=fwp_array_typed_new(32,&scalar);
        for(size_t i=0;i<32;i++) fwp_array_store(input,i,0,&scalar);
        identity_fault=3;
        (void)f5(input);
        return 95;
    }
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
                if(!missing) identity_drop(result); /* missing-release control */
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
    /* The following allocating read borrows the mapped result. Trap,
     * cancellation must release its generated owner. Fatal allocator exhaustion
     * is checked separately for its specified exit 102 and diagnostic. */
    for(volatile int mode=1;mode<=2;mode++) {
        for(int sliced=0;sliced<2;sliced++) for(int alias=0;alias<2;alias++) {
            size_t baseline=fwp_heap.live, live=owner_ledger_live;
            V backing=fwp_array_typed_new(64,&scalar);
            for(size_t i=0;i<64;i++) fwp_array_store(backing,i,words[i%7],&scalar);
            V input=sliced ? fwp_p_array_slice_typed(16,32,backing,NULL,&scalar) : backing;
            if(!sliced) backing=0;
            if(alias) fwp_rc_dup(input);
            jmp_buf jump;
            fwp_trap_recover=identity_recover; fwp_trap_jb=&jump; fwp_trap_cleanup=0;
            memset(&identity_cancel,0,sizeof identity_cancel);
            if(mode==2) { identity_cancel.base=&jump; fwp_cur=&identity_cancel; fwp_budget=1000000; }
            identity_fault=mode;
            if(!setjmp(jump)) { (void)f5(input); return 88; }
            fwp_cur=NULL; fwp_trap_recover=NULL; fwp_trap_jb=NULL; identity_fault=0;
            if(fwp_cleanups || (mode==2 && !identity_cancel.unwinding)) return 89;
            if(alias) {
                if(!owner_ledger_slots[owner_ledger_find((uintptr_t)input)]) return 91;
                if(*fwp_rc_slot(input)!=1 || fwp_array_load(input,0,&scalar)!=words[sliced ? 16%7 : 0]) return 92;
                identity_drop(input);
            }
            if(backing) identity_drop(backing);
            if(fwp_heap.live!=baseline || owner_ledger_live!=live || fwp_heap.rc_wide_len) return 90;
        }
    }
    /* Measure result lifetime separately from allocation savings. A view of
     * one quarter of an array can keep that entire backing owner alive. */
    for(int sliced=0;sliced<2;sliced++) for(int alias=0;alias<2;alias++) {
        size_t baseline=fwp_heap.live, live=owner_ledger_live;
        V backing=fwp_array_typed_new(sliced ? 1024 : 256,&scalar);
        for(size_t i=0;i<(sliced ? 1024u : 256u);i++)
            fwp_array_store(backing,i,words[i%7],&scalar);
        V input=backing;
        if(sliced) {
            input=fwp_p_array_slice_typed(0,256,backing,NULL,&scalar);
            identity_drop(backing);
        }
        int view=fwp_array_is_view(input);
        if(view!=(sliced && FWP_PACKED_ARRAYS)) return 96;
        if(alias) fwp_rc_dup(input);
        size_t before=fwp_heap.live, allocations=owner_ledger_allocations;
        size_t retains=identity_retains;
        double charged=fwp_heap.total_alloc;
        fwp_heap.peak=before;
        V result=f2(input);
        size_t after=fwp_heap.live, peak=fwp_heap.peak;
        size_t new_allocations=owner_ledger_allocations-allocations;
        size_t new_retains=identity_retains-retains;
        double new_charged=fwp_heap.total_alloc-charged;
        if(IDENTITY_SELECTED) {
            if(result!=input || new_allocations || new_retains || new_charged || after!=before || peak!=before) return 97;
        } else {
            if(new_allocations!=1 || new_charged<=0 || peak<=before) return 98;
            if(alias && after<=before) return 99;
            if(!alias && (view ? after>=before : after!=before)) return 100;
        }
        for(size_t i=0;i<256;i++)
            if(fwp_array_load(result,i,&scalar)!=words[i%7]) return 84;
        identity_drop(result);
        if(alias) identity_drop(input);
        if(fwp_heap.live!=baseline || owner_ledger_live!=live || fwp_heap.rc_wide_len) return 90;
        printf("identity storage: slice=%d alias=%d view=%d allocations=%zu retains=%zu charged=%.0f before=%zu result=%zu peak=%zu final=%zu\n",
            sliced,alias,view,new_allocations,new_retains,new_charged,
            before-baseline,after-baseline,peak-baseline,fwp_heap.live-baseline);
    }
    owner_ledger_finish();
    puts("identity arrays: moves, aliases, slices, updates and cleanup pass");
    return 0;
}
