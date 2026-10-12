static void *library_owners[64];
static size_t library_live,library_calls;
static void *library_realloc(void *old,size_t bytes){
    size_t i=0;while(i<64 && (old ? library_owners[i]!=old : library_owners[i]!=0))i++;
    if(i==64)abort();void *p=realloc(old,bytes?bytes:1);if(!p)abort();
    if(!old)library_live++;library_owners[i]=p;library_calls++;return p;
}
static void *library_calloc(size_t n,size_t size){
    if(n && size>SIZE_MAX/n)abort();void *p=library_realloc(0,n*size);memset(p,0,n*size);return p;
}
static void library_free(void *p){
    if(!p)return;size_t i=0;while(i<64 && library_owners[i]!=p)i++;
    if(i==64)abort();library_owners[i]=0;library_live--;free(p);
}
static void library_finished(void){
    const char *path=getenv("FWP_AD_LIBRARY_REPORT");if(!path)abort();
    FILE *f=fopen(path,"a");if(!f)abort();fprintf(f,"%zu %zu\n",library_live,library_calls);fclose(f);
}
