static jmp_buf text_jump;
static fwp_task text_cancelled;
static int text_recover(void) { return 1; }
static V text_new(const char *text) {
    return fwp_rc_fresh(fwp_str_new(text, strlen(text)));
}
static int text_equal(V value, const char *text) {
    return STR(value)->len == strlen(text) && !memcmp(STR(value)->d, text, strlen(text));
}
static int text_count(V value) {
    uint8_t *slot = fwp_rc_slot(value);
    return slot ? *slot : -1;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_tasks_init();
    intptr_t initial=fwp_gc.budget;
    V (*unary[])(V)={TEXT_LOWER,TEXT_UPPER,TEXT_TRIM,TEXT_START,TEXT_END};
    const char *input[]={"AbC", "aBc", "  x  ", "  x  ", "  x  "};
    const char *expected[]={"abc", "ABC", "x", "x  ", "  x"};
    for(size_t i=0;i<sizeof unary/sizeof *unary;i++) {
        V original=text_new("123 λ");
        uint64_t before=text_allocations;
        V result=unary[i](original);
        if(result!=original || text_count(result)!=1 || text_allocations!=before)return 232;
        TEXT_DROP(result);
        if(i<2) {
            original=text_new(input[i]);
            before=text_allocations;
            result=unary[i](original);
            if(result!=original || !text_equal(result,expected[i]) || text_count(result)!=1 || text_allocations!=before)return 237;
            TEXT_DROP(result);
        }
        original=text_new(input[i]);fwp_rc_dup(original);
        result=unary[i](original);
        if(result==original || !text_equal(result,expected[i]) || !text_equal(original,input[i]))return 233;
        if(text_count(result)!=1 || text_count(original)!=1)return 233;
        TEXT_DROP(result);TEXT_DROP(original);
    }
    const char *from[]={"", "missing", "abc"};
    const char *to[]={"!", "!", "abc"};
    for(size_t i=0;i<3;i++) {
        V original=text_new("abc"),a=text_new(from[i]),b=text_new(to[i]);
        fwp_rc_dup(original);
        uint64_t before=text_allocations;
        V result=TEXT_REPLACE(a,b,original);
        if(result!=original || text_count(result)!=2 || text_allocations!=before)return 232;
        TEXT_DROP(result);
        if(text_count(original)!=1 || !text_equal(original,"abc"))return 233;
        TEXT_DROP(original);TEXT_DROP(a);TEXT_DROP(b);
    }
    V original=text_new("abc abc"),from_value=text_new("abc"),to_value=text_new("x");
    fwp_rc_dup(original);
    V result=TEXT_REPLACE(from_value,to_value,original);
    if(!text_equal(result,"x x") || !text_equal(original,"abc abc"))return 233;
    TEXT_DROP(result);TEXT_DROP(original);TEXT_DROP(from_value);TEXT_DROP(to_value);
    // The borrowed pattern and replacement may alias the consumed source.
    original=text_new("abc");
    result=TEXT_REPLACE(original,original,original);
    if(result!=original || text_count(result)!=1)return 233;
    TEXT_DROP(result);
    for(int kind=1;kind<=2;kind++)for(size_t i=0;i<6;i++) {
        V saved=text_new("AbC");fwp_rc_dup(saved);
        V a=text_new("A"),b=text_new("x");
        text_force_trap=kind;
        fwp_trap_recover=text_recover;fwp_trap_jb=&text_jump;fwp_trap_cleanup=NULL;
        fwp_task *previous=fwp_cur;
        memset(&text_cancelled,0,sizeof text_cancelled);
        if(kind==2) {
            text_cancelled.identity=UINT64_MAX;text_cancelled.cancelled=1;
#ifdef _WIN32
            text_cancelled.ctx.top=previous->ctx.top;
#endif
            text_cancelled.base=&text_jump;fwp_cur=&text_cancelled;
        }
        if(!setjmp(text_jump)) {
            if(i<5)unary[i](saved);else TEXT_REPLACE(a,b,saved);
            return 234;
        }
        text_cancelled.base=NULL;fwp_cur=previous;
        fwp_trap_recover=NULL;fwp_trap_jb=NULL;text_force_trap=0;
        if(kind==1 && strcmp(fwp_trap_msg,"text copy control"))return 235;
        if(kind==2 && !text_cancelled.unwinding)return 235;
        if(fwp_cleanups || text_count(saved)!=1)return 235;
        if(!text_equal(saved,"AbC"))return 233;
        TEXT_DROP(saved);TEXT_DROP(a);TEXT_DROP(b);
    }
    fwp_tasks_finish();
    if(fwp_gc.budget!=initial)return 236;
    puts("text owners transfer, preserve aliases and release on failure");
    return 0;
}
