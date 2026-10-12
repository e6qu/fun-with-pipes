/* Only records can encode no bytes; constructor tags and counts occupy bytes.
 * Avoid following a recursive descriptor graph indefinitely. */
typedef struct fwp_wire_path { const fwp_desc *desc; const struct fwp_wire_path *parent; } fwp_wire_path;
static int fwp_wire_empty_inner(const fwp_desc *d,const fwp_wire_path *path) {
    if(!d || d->kind!=K_RECORD)return 0;
    for(const fwp_wire_path *p=path;p;p=p->parent)if(p->desc==d)return 0;
    const fwp_wire_path here={d,path};
    for(int i=0;i<d->n;i++)if(!fwp_wire_empty_inner(d->fields[i],&here))return 0;
    return 1;
}
static int fwp_decode_count(fwp_rd *r,const fwp_desc *elem,int unique,uint64_t *count) {
    if(!rd_leb(r,count) || *count>(SIZE_MAX-sizeof(fwp_arr))/sizeof(V))return 0;
    if(fwp_wire_empty_inner(elem,0))return !unique || *count<=1;
    return *count<=r->n;
}
