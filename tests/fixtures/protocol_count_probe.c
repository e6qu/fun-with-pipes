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
    const unsigned char huge[]={255,255,255,255,255,255,255,255,255,1};
    reader=(fwp_rd){huge,sizeof huge,0};uint64_t count;
    if(fwp_decode_count(&reader,&unit,0,&count))return 155;
    const unsigned char duplicate[]={2};
    reader=(fwp_rd){duplicate,sizeof duplicate,0};
    if(fwp_decode_count(&reader,&unit,1,&count))return 162;
    return 0;
}
