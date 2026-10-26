static uint64_t buffered_hash(V v, const fwp_desc *d) {
    fwp_buf b = {0}; fwp_encode(&b, v, d);
    uint64_t h = UINT64_C(0xcbf29ce484222325);
    for (size_t i = 0; i < b.len; i++) { h ^= (unsigned char)b.d[i]; h *= UINT64_C(0x100000001b3); }
    free(b.d); return h;
}
static int check_hash(V value, const fwp_desc *desc, int nonempty) {
    hash_tracking = 1; hash_requests = 0;
    uint64_t expected = buffered_hash(value, desc);
    hash_tracking = 0;
    if (nonempty && !hash_requests) return 249;
    hash_tracking = 1; hash_requests = 0;
    uint64_t got = fwp_hash(value, desc);
    hash_tracking = 0;
    if (hash_requests) return 247;
    if (got != expected) return 246;
    return 0;
}
#define HASH_CHECK(value, descriptor, nonempty) do { int code = check_hash(value, descriptor, nonempty); if (code) return code; } while(0)
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    const int kinds[] = {K_I8,K_U8,K_I16,K_U16,K_F16,K_BF16,K_I32,K_U32,K_F32,K_I64,K_U64,K_F64,K_TINT,K_TRIT};
    const V bits[] = {0,1,127,128,255,UINT64_MAX,UINT64_C(0x8000000000000000),UINT64_C(0x7ff8000000000042)};
    for (size_t k = 0; k < sizeof kinds/sizeof *kinds; k++) {
        fwp_desc desc = {.kind=kinds[k]};
        for (size_t i = 0; i < sizeof bits/sizeof *bits; i++) HASH_CHECK(bits[i], &desc, 1);
    }
    u128 wide = ((u128)UINT64_C(0x8877665544332211)<<64)|UINT64_C(0xffeeddccbbaa0099);
    fwp_desc signed_wide={.kind=K_I128}, unsigned_wide={.kind=K_U128};
    HASH_CHECK(PTR(&wide), &signed_wide, 1); HASH_CHECK(PTR(&wide), &unsigned_wide, 1);
#ifdef FWP_EXACT_FLOAT
    float128_t quad={{UINT64_C(0x0123456789abcdef),UINT64_C(0x7fff800000000042)}};
    fwp_desc quad_desc={.kind=K_F128}; HASH_CHECK(PTR(&quad), &quad_desc, 1);
#endif
    struct { uint64_t len; char data[300]; } text={.len=300};
    for (size_t i=0;i<sizeof text.data;i++) text.data[i]=(char)i;
    fwp_desc str={.kind=K_STR},bytes={.kind=K_BYTES},number={.kind=K_I64};
    HASH_CHECK(PTR(&text), &str, 1);HASH_CHECK(PTR(&text), &bytes, 1);
    fwp_desc list={.kind=K_LIST,.elem=&str};
    static fwp_obj tail={1,2,{0,0}}, head={1,2,{0,0}};
    tail.f[0]=PTR(&text);head.f[0]=PTR(&text);head.f[1]=PTR(&tail);
    HASH_CHECK(PTR(&head), &list, 1);HASH_CHECK(0,&list,1);
    struct { uint64_t len; V data[129]; } array={.len=129};
    for(size_t i=0;i<129;i++)array.data[i]=i*17;
    fwp_desc array_desc={.kind=K_ARRAY,.elem=&number};
    HASH_CHECK(PTR(&array),&array_desc,1);
    fwp_array_view view={FWP_ARRAY_VIEW_FLAG|99,PTR(&array),(const unsigned char *)&array.data[2]};
    HASH_CHECK(PTR(&view),&array_desc,1);
    u128 wide_zero=0,wide_one=1;
    struct { uint64_t len; V data[3]; } wide_array={.len=3,.data={PTR(&wide_zero),PTR(&wide_one),PTR(&wide)}};
    fwp_desc wide_array_desc={.kind=K_ARRAY,.elem=&unsigned_wide};
    HASH_CHECK(PTR(&wide_array),&wide_array_desc,1);
#ifdef FWP_EXACT_FLOAT
    struct { uint64_t len; unsigned char data[48]; } quad_array={.len=3};
    memcpy(quad_array.data,&quad,16);memcpy(quad_array.data+16,&quad,16);memcpy(quad_array.data+32,&quad,16);
    fwp_desc quad_array_desc={.kind=K_ARRAY,.elem=&quad_desc};
    HASH_CHECK(PTR(&quad_array),&quad_array_desc,1);
#endif
    const fwp_desc *fields[]={&list,&array_desc};
    fwp_desc record={.kind=K_RECORD,.n=2,.fields=fields}, unit={.kind=K_RECORD,.n=0};
    static fwp_obj pair={0,2,{0,0}};
    pair.f[0]=PTR(&head);pair.f[1]=PTR(&view);
    HASH_CHECK(PTR(&pair),&record,1);HASH_CHECK(0,&unit,0);
    int arities[]={0,2}; const fwp_desc *const *variants[]={NULL,fields};
    fwp_desc variant={.kind=K_ADT,.n=2,.arity=arities,.vfields=variants};
    pair.tag=1;HASH_CHECK(PTR(&pair),&variant,1);HASH_CHECK(0,&variant,1);
    struct { uint64_t len; V data[4]; } map={2,{1,PTR(&head),2,PTR(&head)}};
    fwp_desc map_desc={.kind=K_MAP,.elem=&number,.elem2=&list},set_desc={.kind=K_SET,.elem=&number};
    HASH_CHECK(PTR(&map),&map_desc,1);HASH_CHECK(PTR(&map),&set_desc,1);
    V alias=fwp_rc_fresh(fwp_cstr("retained hash input"));fwp_rc_dup(alias);
    HASH_CHECK(alias,&str,1);
    if(!fwp_rc_slot(alias)||*fwp_rc_slot(alias)!=2||STR(alias)->len!=19)return 248;
    fwp_rc_drop(alias);fwp_rc_free_obj(alias);
    return 0;
}
