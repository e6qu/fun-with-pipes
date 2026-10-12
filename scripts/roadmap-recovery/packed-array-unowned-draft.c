/* Descriptor-directed immutable boundaries when counted reuse is disabled. */
static V fwp_array_from_words(const V *words, size_t n, const fwp_desc *elem) {
    V r = fwp_array_new_packed(n, elem);
    for (size_t i=0;i<n;i++) fwp_array_store(r,i,words[i],elem);
    FWP_KEEP_ALIVE(words); return r;
}
static V fwp_p_array_from_list_with_elem(V xs, const fwp_desc *elem) {
    V source=xs, r=fwp_array_new_packed(fwp_list_len(xs),elem);
    for(size_t i=0;xs;i++,xs=OBJ(xs)->f[1]) fwp_array_store(r,i,OBJ(xs)->f[0],elem);
    FWP_KEEP_ALIVE(source);return r;
}
static V fwp_p_array_to_list_with_elem(V a,const fwp_desc *elem) {
    V r=0;for(size_t i=fwp_array_len(a);i;i--)r=fwp_cons(fwp_array_load(a,i-1,elem),r);
    FWP_KEEP_ALIVE(a);return r;
}
static V fwp_p_array_get_with_elem(V i,V a,const fwp_desc *elem) {
    if((int64_t)i<0 || (uint64_t)i>=fwp_array_len(a))return FWP_NONE;
    V r=fwp_some(fwp_array_load(a,(size_t)i,elem));FWP_KEEP_ALIVE(a);return r;
}
static V fwp_array_copy_with_elem(V a,size_t extra,const fwp_desc *elem) {
    size_t n=fwp_array_len(a);if(extra>SIZE_MAX-n)fwp_trap("array too large");
    V r=fwp_array_new_packed(n+extra,elem);
    for(size_t i=0;i<n;i++)fwp_array_store(r,i,fwp_array_load(a,i,elem),elem);
    FWP_KEEP_ALIVE(a);return r;
}
static V fwp_p_array_set_with_elem(V i,V x,V a,const fwp_desc *elem) {
    if((int64_t)i<0 || (uint64_t)i>=fwp_array_len(a))return FWP_NONE;
    V r=fwp_array_copy_with_elem(a,0,elem);fwp_array_store(r,(size_t)i,x,elem);
    V result=fwp_some(r);FWP_KEEP_ALIVE(x);return result;
}
static V fwp_p_array_push_with_elem(V x,V a,const fwp_desc *elem) {
    size_t n=fwp_array_len(a);V r=fwp_array_copy_with_elem(a,1,elem);
    fwp_array_store(r,n,x,elem);FWP_KEEP_ALIVE(x);return r;
}
static V fwp_p_array_make_with_elem(V n,V x,const fwp_desc *elem) {
    size_t k=fwp_count_arg(n);V r=fwp_array_new_packed(k,elem);
    for(size_t i=0;i<k;i++)fwp_array_store(r,i,x,elem);
    FWP_KEEP_ALIVE(x);return r;
}
static V fwp_p_array_generate_with_elem(V n,V f,const fwp_desc *elem) {
    size_t k=fwp_count_arg(n);V r=fwp_array_new_packed(k,elem);
    for(size_t i=0;i<k;i++)fwp_array_store(r,i,fwp_apply1(f,(V)i),elem);
    FWP_KEEP_ALIVE(f);return r;
}
static V fwp_p_array_map_with_elem(V f,V a,const fwp_desc *elem,const fwp_desc *input) {
    size_t n=fwp_array_len(a);V r=fwp_array_new_packed(n,elem);
    for(size_t i=0;i<n;i++)fwp_array_store(r,i,fwp_apply1(f,fwp_array_load(a,i,input)),elem);
    FWP_KEEP_ALIVE(f);FWP_KEEP_ALIVE(a);return r;
}
static V fwp_p_array_fold_with_elem(V f,V z,V a,const fwp_desc *elem) {
    for(size_t i=0;i<fwp_array_len(a);i++)z=fwp_apply2(f,z,fwp_array_load(a,i,elem));
    FWP_KEEP_ALIVE(f);FWP_KEEP_ALIVE(a);return z;
}
static V fwp_p_array_slice_with_elem(V start,V len,V a,const fwp_desc *elem) {
    size_t n=fwp_array_len(a),first=fwp_count_arg(start);if(first>n)first=n;
    size_t count=fwp_count_arg(len);if(count>n-first)count=n-first;
#if FWP_PACKED_ARRAYS
    if(count && fwp_array_numeric(elem)) {
        V owner=fwp_array_owner(a);const unsigned char *data=fwp_array_data(a)+first*fwp_array_stride(elem);
        fwp_array_view *view=(fwp_array_view *)fwp_alloc_init(sizeof *view);
        view->len=FWP_ARRAY_VIEW_FLAG|count;view->owner=owner;view->data=data;
        fwp_rc_dup(owner);FWP_KEEP_ALIVE(a);return PTR(view);
    }
#endif
    V r=fwp_array_new_packed(count,elem);
    for(size_t i=0;i<count;i++)fwp_array_store(r,i,fwp_array_load(a,first+i,elem),elem);
    FWP_KEEP_ALIVE(a);return r;
}
static V fwp_p_array_append_with_elem(V b,V a,const fwp_desc *elem) {
    size_t n=fwp_array_len(a),m=fwp_array_len(b);if(m>SIZE_MAX-n)fwp_trap("array too large");
    V r=fwp_array_new_packed(n+m,elem);
    for(size_t i=0;i<n+m;i++)fwp_array_store(r,i,i<n?fwp_array_load(a,i,elem):fwp_array_load(b,i-n,elem),elem);
    FWP_KEEP_ALIVE(a);FWP_KEEP_ALIVE(b);return r;
}
static V fwp_p_array_sort_with_elem(V a,const fwp_desc *elem) {
    V r=fwp_array_copy_with_elem(a,0,elem);size_t n=fwp_array_len(a);
    if(n>1){V *keys=(V *)fwp_mem_alloc((n+1)*sizeof(V));V *tk=(V *)fwp_mem_alloc((n+1)*sizeof(V));V *tv=(V *)fwp_mem_alloc((n+1)*sizeof(V));
        for(size_t i=0;i<n;i++)keys[i]=fwp_array_load(r,i,elem);
        fwp_msort(keys,keys,n,elem,tk,tv);
        for(size_t i=0;i<n;i++)fwp_array_store(r,i,keys[i],elem);
        FWP_KEEP_ALIVE(keys);FWP_KEEP_ALIVE(tk);FWP_KEEP_ALIVE(tv);
        fwp_mem_free(tv);fwp_mem_free(tk);fwp_mem_free(keys);}
    FWP_KEEP_ALIVE(a);return r;
}
