static void *library_owners[64];
static size_t library_live,library_calls;
static void *library_managed[64];
static size_t library_managed_live,library_managed_calls;
static void *library_mem_realloc(void *old,size_t before,size_t bytes){
    size_t i=0;while(i<64 && (old ? library_managed[i]!=old : library_managed[i]!=0))i++;
    if(i==64)abort();void *p=fwp_mem_realloc(old,before,bytes);if(!p)abort();
    if(!old)library_managed_live++;library_managed[i]=p;library_managed_calls++;return p;
}
static void *library_mem_alloc(size_t bytes){return library_mem_realloc(NULL,0,bytes);}
static void library_mem_free(void *p){
    if(!p)return;size_t i=0;while(i<64 && library_managed[i]!=p)i++;
    if(i==64)abort();library_managed[i]=NULL;library_managed_live--;fwp_mem_free(p);
}
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
/* Exercise shutdown with unfinished internal work below language admission.
 * The static scope remains valid until unload; no language tape may escape. */
static fwp_tape_scope library_live_scope = {-1};
#ifdef _WIN32
__declspec(dllexport)
#endif
int64_t library_live_probe(int64_t leaves) {
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_tape_scope_release, &library_live_scope);
    V base = fwp_p_ad_tape((V)leaves);
    fwp_tape_reserve(fwp_tape_of((int64_t)base >> 32), 2);
    static const fwp_desc scalar = {.kind=K_I64};
    V parameters = fwp_rc_fresh(fwp_record(4, (V[4]){0, 0, 0, 0}));
    V owned = fwp_p_ad_tape_owned(parameters, 0, &scalar);
    fwp_tape_reserve(fwp_tape_of((int64_t)owned >> 32), 2);
    fwp_rc_free_obj(parameters);
    fwp_cleanup_pop(&cleanup);
    return 0;
}
static void library_finished(void){
    const char *path=getenv("FWP_AD_LIBRARY_REPORT");if(!path)abort();
    if(!library_managed_calls || fwp_owned_tapes)abort();
    if(library_live_scope.head != -1)exit(186);
    FILE *f=fopen(path,"a");if(!f)abort();fprintf(f,"%zu %zu\n",library_live+library_managed_live,library_calls);fclose(f);
}
