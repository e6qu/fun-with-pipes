static int cwd_mode, cwd_live, cwd_collect;
static jmp_buf cwd_failure;
static int cwd_recover(void) { return 1; }
static void cwd_event(void) {
#if !FWP_ARC_ONLY
    if(cwd_collect)fwp_gc_collect();
#endif
    if(cwd_mode==3)fwp_trap("working directory string failure");
}
static V cwd_string(const char *p,size_t n){cwd_event();return fwp_str_lossy(p,n);}
#ifdef _WIN32
static DWORD cwd_read_wide(DWORD size,wchar_t *path) {
    if(cwd_mode==1 || (cwd_mode==4 && size)) {SetLastError(ERROR_PATH_NOT_FOUND);return 0;}
    if(cwd_mode==2) {
        if(!size)return 6001;
        if(size!=6001)_Exit(227);
        for(int i=0;i<6000;i++)path[i]=L'x';path[6000]=0;return 6000;
    }
    return GetCurrentDirectoryW(size,path);
}
static void *cwd_alloc(size_t size){void *p=malloc(size);if(p)cwd_live++;return p;}
static void cwd_free(void *p){if(p){free(p);cwd_live--;}}
static V cwd_string_wide(const wchar_t *p,size_t n){cwd_event();return fwp_win_string(p,n);}
#else
static char *cwd_read(char *path,size_t size) {
    if(path || size)_Exit(227);
    if(cwd_mode==1){errno=ENOENT;return NULL;}
    char *p;
    if(cwd_mode==2){p=malloc(6001);if(p){memset(p,'x',6000);p[6000]=0;}}
    else p=getcwd(path,size);
    if(p)cwd_live++;return p;
}
static void cwd_release(void *p){fwp_buf_release(p);cwd_live--;}
#endif
static void cwd_drop(V v){if(fwp_rc_release_last(v))fwp_rc_free_obj(v);}
static int cwd_drop_error(V value){
    if(*fwp_rc_slot(value)!=1)return 224;
    V kind=OBJ(value)->f[0];
    if(STR(kind)->len!=3||memcmp(STR(kind)->d,"cwd",3))return 225;
    cwd_drop(kind);cwd_drop(OBJ(value)->f[1]);cwd_drop(value);return 0;
}
int main(void){
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
#if FWP_ARC_ONLY
    const int collect_limit=0;
#else
    const int collect_limit=1;
#endif
    for(cwd_collect=0;cwd_collect<=collect_limit;cwd_collect++){
        intptr_t budget=fwp_gc.budget;
        for(cwd_mode=0;cwd_mode<4;cwd_mode++)for(int repeat=0;repeat<128;repeat++){
            if(cwd_mode==1){
                fwp_handler handler={0};handler.prev=fwp_handlers;handler.cleanup=fwp_cleanups;fwp_handlers=&handler;
                if(!setjmp(handler.jb)){(void)fEXERCISE(FWP_UNIT);return 222;}
                fwp_handlers=handler.prev;
                int status=cwd_drop_error(handler.value);if(status)return status;handler.value=0;
            }else if(cwd_mode==3){
                fwp_trap_recover=cwd_recover;fwp_trap_jb=&cwd_failure;fwp_trap_cleanup=fwp_cleanups;
                if(!setjmp(cwd_failure)){(void)fEXERCISE(FWP_UNIT);return 223;}
                fwp_trap_recover=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
            }else{
                V path=fEXERCISE(FWP_UNIT);
                if(*fwp_rc_slot(path)!=1)return 219;
                if(!STR(path)->len||(cwd_mode==2&&STR(path)->len!=6000))return 220;
                cwd_drop(path);
            }
            if(cwd_live)return 221;
            if(fwp_cleanups)return 226;
            if(!cwd_collect&&fwp_gc.budget!=budget)return 228;
        }
#ifdef _WIN32
        cwd_mode=4;
        fwp_handler handler={0};handler.prev=fwp_handlers;handler.cleanup=fwp_cleanups;fwp_handlers=&handler;
        if(!setjmp(handler.jb)){(void)fEXERCISE(FWP_UNIT);return 222;}
        fwp_handlers=handler.prev;
        int status=cwd_drop_error(handler.value);if(status)return status;
        if(cwd_live||fwp_cleanups)return 221;
#endif
    }
    return 0;
}
