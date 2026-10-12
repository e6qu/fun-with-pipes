from pathlib import Path
p=Path('/private/tmp/fwp-phase4-ad-workspace-draft/fwp_rt_kernel.c');s=p.read_text();a='    static int registered_finish;';b='    int64_t slot = 0;';start=s.index(a);end=s.index(b,start);block=s[start:end];s=s[:start]+'#ifndef FWP_LIBRARY\n'+block+'#endif\n'+s[end:]
a='static void *fwp_k_malloc(size_t n) {';s=s.replace(a,'''#ifdef FWP_LIBRARY
/* Private tape buffers have library lifetime, including GC-disabled libraries.
 * An explicit unload hook avoids keeping a separate process-exit owner. */
static void __attribute__((destructor)) fwp_tape_library_finish(void) {
    fwp_tape_finish();
}
#endif

'''+a);p.write_text(s)
p=Path('/private/tmp/fwp-autodiff-workspace-probe-draft.c');s=p.read_text();start=s.index('static V workspace_scope_entry');end=s.index('int main(void)',start)
s=s[:start]+'''static fwp_clo workspace_callback={0,0},workspace_nested_callback={1,0};
static V workspace_nested_base;
static V workspace_nested_entry(V *args){
    (void)args;workspace_nested_base=fwp_p_ad_tape(7);return FWP_UNIT;
}
static V workspace_scope_entry(V *args){
    (void)args;workspace_base=fwp_p_ad_tape(5);
    if(workspace_mode==5)return FWP_UNIT;
    if(workspace_mode==7){
        fwp_p_ad_scope(PTR(&workspace_nested_callback),FWP_UNIT);
        if(!workspace_dead(workspace_nested_base))exit(207);
        if(fwp_tape_of((int64_t)workspace_base>>32)->leaves!=5)exit(208);
        return FWP_UNIT;
    }
    fwp_trap("workspace scope control");return FWP_UNIT;
}
static const fwp_fninfo workspace_functions[]={
    {1,workspace_scope_entry,"workspace scope control",0},
    {1,workspace_nested_entry,"workspace nested control",0}
};
'''+s[end:]
a='    fwp_fns=workspace_functions;';s=s.replace(a,a+'''
    for(workspace_mode=5;workspace_mode<=7;workspace_mode+=2){
        if(fwp_p_ad_scope(PTR(&workspace_callback),FWP_UNIT)!=FWP_UNIT)return 209;
        if(fwp_cleanups || !workspace_dead(workspace_base))return 210;
    }
    workspace_mode=6;''');p.write_text(s)
print('Prepared native normal/nested scope and library lifetime cleanup')
