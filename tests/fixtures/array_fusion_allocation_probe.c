int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    const fwp_desc element={.kind=K_F64};
    puts("{\"cases\":[");
    for(size_t run=0;run<5;run++) {
        size_t n=run==0?129:run==1?257:run==2?0:run==3?7:1;
        V input=fwp_rc_fresh(fwp_array_new_packed(n,&element));double reference=-0.0;
        for(size_t i=0;i<n;i++) {
            double x=((double)(int)(i%13)-6.0)/4.0;
            static const V edge[]={0x7ff8000000000001ULL,0x3ff0000000000000ULL,0x7ff8000000000012ULL,0x8000000000000000ULL,0xfff0000000000000ULL,0x7ff0000000000000ULL,0x4000000000000000ULL};
            V bits=run==3?edge[i]:run==4?0x8000000000000000ULL:fwp_from_f64(x);
            fwp_array_store(input,i,bits,&element);
            double mapped=x*3.0;mapped=mapped+1.0;reference=mapped+reference;
        }
        uint64_t calls=measured_calls,bytes=measured_bytes,retains=measured_retains,scopes=measured_scopes;double freed=fwp_gc.freed;
        V result=fREDUCE64(input);
        if(run<3 && result!=fwp_from_f64(reference))return 170;
        calls=measured_calls-calls;bytes=measured_bytes-bytes;retains=measured_retains-retains;
        scopes=measured_scopes-scopes;
        /* The bounded internal index cannot overflow; cleanup is constant work. */
        if(FUSED && scopes>16)return 175;
        if(FUSED && retains)return 174;
        if(FUSED && (calls || bytes)){fprintf(stderr,"fused allocated %llu calls and %llu bytes\n",(unsigned long long)calls,(unsigned long long)bytes);return 171;}
        if(!FUSED && calls<2)return 172;
        if(fwp_gc.freed<=freed)return 173;
        printf("%s{\"elements\":%zu,\"managedCalls\":%llu,\"managedRequestedBytes\":%llu,\"retains\":%llu,\"cleanupScopes\":%llu,\"freedBytes\":%.0f,\"resultBits\":\"%016llx\"}",run?",\n":"",n,(unsigned long long)calls,(unsigned long long)bytes,(unsigned long long)retains,(unsigned long long)scopes,fwp_gc.freed-freed,(unsigned long long)result);
    }
    puts("]}");return 0;
}
