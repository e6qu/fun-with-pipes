int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    const fwp_desc element={.kind=K_F64};
    puts("{\"cases\":[");
    for(size_t run=0;run<2;run++) {
        size_t n=run?257:129;
        V input=fwp_rc_fresh(fwp_array_new_packed(n,&element));double reference=0.0;
        for(size_t i=0;i<n;i++) {
            double x=((double)(int)(i%13)-6.0)/4.0;
            fwp_array_store(input,i,fwp_from_f64(x),&element);
            double mapped=x*3.0;mapped=mapped+1.0;reference=reference+mapped;
        }
        uint64_t calls=measured_calls,bytes=measured_bytes;double freed=fwp_gc.freed;
        V result=fREDUCE64(input);
        if(result!=fwp_from_f64(reference))return 170;
        calls=measured_calls-calls;bytes=measured_bytes-bytes;
        if(FUSED && (calls || bytes)){fprintf(stderr,"fused allocated %llu calls and %llu bytes\n",(unsigned long long)calls,(unsigned long long)bytes);return 171;}
        if(!FUSED && calls<2)return 172;
        printf("%s{\"elements\":%zu,\"managedCalls\":%llu,\"managedRequestedBytes\":%llu,\"freedBytes\":%.0f,\"resultBits\":\"%016llx\"}",run?",\n":"",n,(unsigned long long)calls,(unsigned long long)bytes,fwp_gc.freed-freed,(unsigned long long)result);
    }
    puts("]}");return 0;
}
