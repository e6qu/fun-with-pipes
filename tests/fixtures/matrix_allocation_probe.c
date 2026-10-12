int main(void){
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    const fwp_desc scalar={.kind=K_F64};
    static const size_t sizes[][3]={{31,35,33},{2,3,2},{0,3,2},{2,0,3},{2,3,0},{1,1,1}};
    puts("{\"cases\":[");
    for(size_t run=0;run<sizeof(sizes)/sizeof(sizes[0]);run++){
        size_t m=sizes[run][0],k=sizes[run][1],n=sizes[run][2];
        V left=fwp_rc_fresh(fwp_array_new_packed(m*k,&scalar)),right=fwp_rc_fresh(fwp_array_new_packed(k*n,&scalar));
        for(size_t i=0;i<m*k;i++)fwp_array_store(left,i,fwp_from_f64(run==5?-0.0:((double)(int)(i%19)-9.0)/4.0),&scalar);
        for(size_t i=0;i<k*n;i++)fwp_array_store(right,i,fwp_from_f64(((double)(int)(i%13)-6.0)/8.0),&scalar);
        /* Independent scalar reference keeps ascending inner index and the
         * language fold's product-plus-accumulator operand order. */
        double reference[31*33];
        for(size_t i=0;i<m;i++)for(size_t j=0;j<n;j++){
            double sum=0.0;
            for(size_t q=0;q<k;q++){
                double x=run==5?-0.0:((double)(int)((i*k+q)%19)-9.0)/4.0;
                double y=((double)(int)((q*n+j)%13)-6.0)/8.0;
                double product=x*y;sum=product+sum;
            }
            reference[i*n+j]=sum;
        }
        V af[]={k,left,m},bf[]={n,right,k};
        V a=fwp_rc_fresh(fwp_record(3,af)),b=fwp_rc_fresh(fwp_record(3,bf));
        uint64_t calls=matrix_calls,bytes=matrix_bytes;double freed=fwp_gc.freed;
        V result=fPRODUCT_DATA(b,a);
        calls=matrix_calls-calls;bytes=matrix_bytes-bytes;
        if(fwp_array_len(result)!=m*n)return 211;
        uint64_t hash=1469598103934665603ULL;
        for(size_t i=0;i<m*n;i++){
            V bits=fwp_array_load(result,i,&scalar);
            if(bits!=fwp_from_f64(reference[i]))return 212;
            hash=(hash^bits)*1099511628211ULL;
        }
        if(BLOCKED && (calls!=1 || bytes!=8+m*n*8)){
            fprintf(stderr,"blocked matrix allocated %llu requests, %llu bytes for %zux%zux%zu\n",(unsigned long long)calls,(unsigned long long)bytes,m,k,n);return 213;
        }
        if(!BLOCKED && m && k && n && calls<=1)return 214;
        if(BLOCKED && fwp_gc.freed<=freed)return 215;
        printf("%s{\"rows\":%zu,\"inner\":%zu,\"columns\":%zu,\"managedCalls\":%llu,\"managedRequestedBytes\":%llu,\"freedBytes\":%.0f,\"resultHash\":\"%016llx\"}",run?",\n":"",m,k,n,(unsigned long long)calls,(unsigned long long)bytes,fwp_gc.freed-freed,(unsigned long long)hash);
        fwp_rc_free_arr(result);
    }
    puts("]}");return 0;
}
