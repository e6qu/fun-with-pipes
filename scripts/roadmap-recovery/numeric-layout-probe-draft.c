
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    V result=fSTEP(257);
    const char *names[]={"I8","U8","I16","U16","I32","U32","F32","F64"};
    const int kinds[]={K_I8,K_U8,K_I16,K_U16,K_I32,K_U32,K_F32,K_F64};
    const size_t widths[]={1,1,2,2,4,4,4,8};
    const V words[]={UINT64_C(0xffffffffffffff80),UINT64_C(255),UINT64_C(0xffffffffffff8000),UINT64_C(65535),UINT64_C(0xffffffff80000000),UINT64_C(4294967295),UINT64_C(0x80000000),UINT64_C(0x8000000000000000)};
    if (OBJ(result)->n!=8) return 120;
    if (sizeof(fwp_arr)!=8 || offsetof(fwp_arr,d)!=8 || sizeof(V)!=8) return 121;
    printf("{\"headerBytes\":%zu,\"payloadOffset\":%zu,\"wordBytes\":%zu,\"wordAlignment\":%zu,\"arrays\":[",sizeof(fwp_arr),offsetof(fwp_arr,d),sizeof(V),_Alignof(V));
    for (size_t k=0;k<8;k++) {
        V a=OBJ(result)->f[k];
        const fwp_desc elem={.kind=kinds[k]};
        size_t width=fwp_array_stride(&elem);
        if (width!=widths[k] || fwp_array_len(a)!=257 || ((uintptr_t)fwp_array_data(a))%width) return 122;
        for (size_t i=0;i<257;i++) {
            if (fwp_array_load(a,i,&elem)!=words[k]) return 123;
            if (memcmp(fwp_array_data(a)+i*width,&words[k],width)) return 133;
        }
        printf("%s{\"type\":\"%s\",\"length\":257,\"elementBytes\":%zu,\"firstWord\":\"%016llx\",\"storageRequestBytes\":%zu}",k?",":"",names[k],width,(unsigned long long)fwp_array_load(a,0,&elem),sizeof(fwp_arr)+257*width);
    }
    puts("]}");
    if (!fwp_rc_release_last(result)) return 124;
    for (size_t k=0;k<8;k++) {V a=OBJ(result)->f[k];if (!fwp_rc_release_last(a)) return 125;fwp_rc_free_arr(a);}
    fwp_rc_free_obj(result);return 0;
}
