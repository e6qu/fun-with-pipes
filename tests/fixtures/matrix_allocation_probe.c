int main(void){
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    const fwp_desc scalar={.kind=K_F64};
    static const size_t sizes[][3]={{31,35,33},{2,3,2},{0,3,2},{2,0,3},{2,3,0},{1,1,1},{17,17,17},{17,17,17},{17,17,17},{3,3,5},{4,1,3},{1,3,3}};
    static const char *const labels[]={"tile-edges","small","zero-rows","zero-inner","zero-columns","negative-zero","same-view","separate-views","overlapping-views","nan-arithmetic","floating-edges","reduction-order"};
    static const uint64_t edges[]={0,UINT64_C(0x8000000000000000),1,UINT64_C(0x7ff0000000000000),UINT64_C(0xfff0000000000000),UINT64_C(0x7ff8000000000042),UINT64_C(0x7fefffffffffffff)};
    static const size_t single_edges[]={1,2,6,3};
    static const double ordered_right[]={1e16,1e16,-1e16,-1e16,1.0,1e16,1.0,-1e16,1.0};
    puts("{\"cases\":[");
    for(size_t run=0;run<sizeof(sizes)/sizeof(sizes[0]);run++){
        size_t m=sizes[run][0],k=sizes[run][1],n=sizes[run][2];
        size_t live_before=fwp_heap.live,offset=run>=6 && run<=8?3:0;
        double left_values[31*35],right_values[35*33];
        V left=fwp_rc_fresh(fwp_array_new_packed(m*k+offset+(run==8),&scalar)),right=0;
        for(size_t i=0;i<m*k+(run==8);i++){
            V bits=run==9?edges[i%7]:fwp_from_f64(run==5?-0.0:((double)(int)(i%19)-9.0)/4.0);
            if(run==10)bits=edges[single_edges[i]];
            if(run==11)bits=fwp_from_f64(1.0);
            fwp_array_store(left,i+offset,bits,&scalar);
            if(i<m*k)left_values[i]=fwp_f64(bits);
            if(run==8 && i)right_values[i-1]=fwp_f64(bits);
        }
        if(offset){
            V backing=left;
            left=fwp_p_array_slice_typed(offset,m*k,backing,NULL,&scalar);
            if(!fwp_array_is_view(left))return 218;
            if(run==8){
                right=fwp_p_array_slice_typed(offset+1,k*n,backing,NULL,&scalar);
                if(!fwp_array_is_view(right) || fwp_array_data(right)!=fwp_array_data(left)+sizeof(double))return 218;
            }
            if(fwp_rc_release_last(backing))fwp_rc_free_arr(backing);
        }
        if(run==6){right=left;fwp_rc_dup(right);memcpy(right_values,left_values,k*n*sizeof(double));}
        else if(run!=8){
            right=fwp_rc_fresh(fwp_array_new_packed(k*n+offset,&scalar));
            for(size_t i=0;i<k*n;i++){
                V bits=run==9?edges[(i+2)%7]:fwp_from_f64(((double)(int)(i%13)-6.0)/8.0);
                if(run==10)bits=fwp_from_f64(i==0?-1.0:(double)i);
                if(run==11)bits=fwp_from_f64(ordered_right[i]);
                fwp_array_store(right,i+offset,bits,&scalar);right_values[i]=fwp_f64(bits);
            }
            if(offset){V backing=right;right=fwp_p_array_slice_typed(offset,k*n,backing,NULL,&scalar);if(!fwp_array_is_view(right))return 218;if(fwp_rc_release_last(backing))fwp_rc_free_arr(backing);}
        }
        /* Independent scalar reference keeps ascending inner index and the
         * language fold's product-plus-accumulator operand order. */
        double reference[31*33];
        for(size_t i=0;i<m;i++)for(size_t j=0;j<n;j++){
            double sum=0.0;
            for(size_t q=0;q<k;q++){
                double x=left_values[i*k+q],y=right_values[q*n+j];
                double product=x*y;sum=product+sum;
            }
            reference[i*n+j]=sum;
        }
        if(run==11 && (reference[0]!=1.0 || reference[1]!=0.0 || reference[2]!=1.0))return 220;
        V af[]={k,left,m},bf[]={n,right,k};
        V a=fwp_rc_fresh(fwp_record(3,af)),b=fwp_rc_fresh(fwp_record(3,bf));
        uint64_t calls=matrix_calls,bytes=matrix_bytes;double freed=fwp_heap.freed;
        V result=fPRODUCT_DATA(b,a);
        calls=matrix_calls-calls;bytes=matrix_bytes-bytes;
        if(fwp_array_len(result)!=m*n)return 211;
        uint64_t hash=1469598103934665603ULL;
        for(size_t i=0;i<m*n;i++){
            V bits=fwp_array_load(result,i,&scalar);
            /* Arithmetic NaN payload/sign is not a language guarantee. All
             * other results, including signed zero and infinity, are exact. */
            if(isnan(reference[i])){
                if(!isnan(fwp_f64(bits)))return 212;
                bits=UINT64_C(0x7ff8000000000000);
            }else if(bits!=fwp_from_f64(reference[i]))return 212;
            hash=(hash^bits)*1099511628211ULL;
        }
        if(BLOCKED && (calls!=1 || bytes!=8+m*n*8)){
            fprintf(stderr,"blocked matrix allocated %llu requests, %llu bytes for %zux%zux%zu\n",(unsigned long long)calls,(unsigned long long)bytes,m,k,n);return 213;
        }
        if(!BLOCKED && m && k && n && calls<=1)return 214;
        if(BLOCKED && fwp_heap.freed<=freed)return 215;
        printf("%s{\"case\":\"%s\",\"rows\":%zu,\"inner\":%zu,\"columns\":%zu,\"managedCalls\":%llu,\"managedRequestedBytes\":%llu,\"freedBytes\":%.0f,\"resultHash\":\"%016llx\"}",run?",\n":"",labels[run],m,k,n,(unsigned long long)calls,(unsigned long long)bytes,fwp_heap.freed-freed,(unsigned long long)hash);
        fwp_rc_free_arr(result); /* final-result-release control */
        if(fwp_heap.live!=live_before){
            fprintf(stderr,"matrix case %s retained %zu bytes above its entry storage\n",labels[run],fwp_heap.live-live_before);return 219;
        }
    }
    puts("]}");return 0;
}
