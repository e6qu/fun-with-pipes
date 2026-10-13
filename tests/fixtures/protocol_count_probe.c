int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    const fwp_desc unit={.kind=K_RECORD,.n=0};
    const fwp_desc *fields[]={&unit,&unit};
    const fwp_desc pair={.kind=K_RECORD,.n=2,.fields=fields};
    const fwp_desc i8={.kind=K_I8};
    const unsigned char zero_bytes[]={0x81,0x02};
    for(int kind=0;kind<2;kind++)for(int nested=0;nested<2;nested++) {
        const fwp_desc *element=nested?&pair:&unit;
        const fwp_desc container={.kind=kind?K_ARRAY:K_LIST,.elem=element};
        fwp_rd reader={zero_bytes,sizeof zero_bytes,0};V value;
        if(!fwp_decode(&reader,&container,&value) || reader.i!=sizeof zero_bytes)return 154;
        if(kind) {
            if(fwp_array_len(value)!=257)return 156;
            for(size_t i=0;i<257;i++) {
                V item=fwp_array_load(value,i,element);
                if(nested?(OBJ(item)->n!=2 || OBJ(item)->f[0] || OBJ(item)->f[1]):item!=0)return 157;
            }
        }else if(fwp_list_len(value)!=257)return 158;
        FWP_KEEP_ALIVE(value);
    }
    const unsigned char numeric[]={3,0x80,0xff,0x7f};
    const fwp_desc numbers={.kind=K_ARRAY,.elem=&i8};V value;
    uint64_t calls=measured_calls,bytes=measured_bytes;
    fwp_rd reader={numeric,sizeof numeric,0};
    if(!fwp_decode(&reader,&numbers,&value) || fwp_array_len(value)!=3)return 159;
    if(measured_calls-calls!=1 || measured_bytes-bytes!=sizeof(fwp_arr)+3*fwp_array_stride(&i8))return 163;
    const V expected[]={(V)(int64_t)-128,(V)(int64_t)-1,127};
    for(size_t i=0;i<3;i++)if(fwp_array_load(value,i,&i8)!=expected[i])return 160;
    reader=(fwp_rd){numeric,3,0};
    if(fwp_decode(&reader,&numbers,&value))return 161;
    /* Wide counts still decode directly into the packed payload: no V vector. */
    unsigned char large[259]={0x81,0x02};
    for(size_t i=0;i<257;i++)large[i+2]=(unsigned char)(i%128);
    calls=measured_calls;bytes=measured_bytes;
    reader=(fwp_rd){large,sizeof large,0};
    if(!fwp_decode(&reader,&numbers,&value) || fwp_array_len(value)!=257)return 164;
    if(measured_calls-calls!=1 || measured_bytes-bytes!=sizeof(fwp_arr)+257*fwp_array_stride(&i8))return 165;
    for(size_t i=0;i<257;i++)if(fwp_array_load(value,i,&i8)!=(V)(i%128))return 166;
    const unsigned char huge[]={255,255,255,255,255,255,255,255,255,1};
    reader=(fwp_rd){huge,sizeof huge,0};uint64_t count;
    if(fwp_decode_count(&reader,&unit,0,&count))return 155;
    const unsigned char duplicate[]={2};
    reader=(fwp_rd){duplicate,sizeof duplicate,0};
    if(fwp_decode_count(&reader,&unit,1,&count))return 162;
    const fwp_desc trit={.kind=K_TRIT};
    for(unsigned i=0;i<256;i++) {
        unsigned char byte=(unsigned char)i;
        reader=(fwp_rd){&byte,1,0};
        if(fwp_decode(&reader,&trit,&value)!=(i==0 || i==1 || i==255))return 167;
    }
    const int widths[]={0,1,3,40};
    for(size_t i=0;i<4;i++) {
        fwp_desc tint={.kind=K_TINT,.width=widths[i]};
        int64_t max=(int64_t)fwp_tint_max(widths[i]);
        int64_t values[]={INT64_MIN,-max-1,-max,0,max,max+1,INT64_MAX};
        for(size_t j=0;j<7;j++) {
            unsigned char bytes[8];uint64_t bits=(uint64_t)values[j];
            for(size_t k=0;k<8;k++)bytes[k]=(unsigned char)(bits>>(8*k));
            reader=(fwp_rd){bytes,8,0};
            if(fwp_decode(&reader,&tint,&value)!=(values[j]>=-max && values[j]<=max))return 168;
        }
    }
    return 0;
}
