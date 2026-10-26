static V zip_input(size_t n, int64_t offset) {
    V result=0;
    for(size_t i=n;i;i--)result=fwp_rc_fresh(fwp_cons((V)(offset+(int64_t)i-1),result));
    return result;
}
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
    const size_t sizes[][2]={{0,0},{0,7},{7,0},{1,1},{7,3},{3,7},{129,129}};
    for(size_t test=0;test<7;test++)for(int alias=0;alias<2;alias++) {
        size_t n=sizes[test][0],m=sizes[test][1],length=n<m?n:m;
        size_t live_bytes=fwp_heap.live;
        V ys=zip_input(n,100),xs=zip_input(m,10);
        if(alias)fwp_rc_dup(xs);
        uint64_t calls=zip_calls,bytes=zip_bytes,retains=zip_retains;
        V result=fTRANSFORM(ys,xs);
        calls=zip_calls-calls;bytes=zip_bytes-bytes;retains=zip_retains-retains;
        size_t count=0;
        for(V at=result;at;at=OBJ(at)->f[1]) {
            if((int64_t)OBJ(at)->f[0]!=90)return 239;
            count++;
        }
        if(count!=length)return 240;
        /* negative control: remove the result's last-owner destruction */
        fDROP(result);
        if(alias) {
            count=0;
            for(V at=xs;at;at=OBJ(at)->f[1]) {
                if((int64_t)OBJ(at)->f[0]!=10+(int64_t)count)return 241;
                count++;
            }
            if(count!=m)return 242;
            fDROP(xs);
        }
        if(fwp_heap.live!=live_bytes)return 238;
        printf("%zu %llu %llu %llu\n",length,(unsigned long long)calls,(unsigned long long)bytes,(unsigned long long)retains);
    }
    return 0;
}
