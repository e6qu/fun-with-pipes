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
    fwp_heap_start();
    fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_tasks_init();
    size_t initial=fwp_heap.live;
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
    // A real buffer allocation calibrates the raw observer and its broken-free control.
    text_direct_active=1;
    fwp_buf calibration={0};
    buf_puts(&calibration,"calibration");
    size_t raw_capacity=calibration.cap;
    V calibrated=fwp_rc_fresh(buf_to_str(&calibration));
    text_direct_active=0;
    TEXT_DROP(calibrated);
    if(text_raw_requests!=1 || text_raw_bytes!=raw_capacity ||
       text_raw_peak!=raw_capacity || text_raw_live)return 238;
    text_raw_requests=text_raw_bytes=text_raw_peak=0;

    struct replacement_case {
        const char *source,*from,*to,*expected;
        size_t source_n,from_n,to_n,expected_n;
        int changed;
    };
#define REPLACE_CASE(S,F,T,E,C) {S,F,T,E,sizeof(S)-1,sizeof(F)-1,sizeof(T)-1,sizeof(E)-1,C}
    const struct replacement_case cases[]={
        REPLACE_CASE("aaaaa","aa","X","XXa",1),
        REPLACE_CASE("abc","","x","abc",0),
        REPLACE_CASE("abc","a","a","abc",0),
        REPLACE_CASE("abc","z","x","abc",0),
        REPLACE_CASE("\377X\377","\377","","X",1),
        REPLACE_CASE("xxxxx","x","y","yyyyy",1),
        REPLACE_CASE("abc","a","long","longbc",1),
        REPLACE_CASE("abc","bc","","a",1),
        REPLACE_CASE("abc","abc","","",1),
        REPLACE_CASE("x\0x","\0","λ","xλx",1),
        REPLACE_CASE("λ λ","λ","ß","ß ß",1),
        REPLACE_CASE("..,..",".","",",",1),
        REPLACE_CASE("ababa","aba","z","zba",1),
        REPLACE_CASE("","a","x","",0),
    };
#undef REPLACE_CASE
    for(size_t i=0;i<sizeof cases/sizeof *cases;i++)for(int shared=0;shared<2;shared++) {
        const struct replacement_case *c=&cases[i];
        V source=fwp_rc_fresh(fwp_str_new(c->source,c->source_n));
        V pattern=fwp_rc_fresh(fwp_str_new(c->from,c->from_n));
        V replacement=fwp_rc_fresh(fwp_str_new(c->to,c->to_n));
        if(shared)fwp_rc_dup(source);
        uint64_t before=text_allocations;
        text_direct_active=1;
        V output=TEXT_REPLACE(pattern,replacement,source);
        text_direct_active=0;
        int reused=c->changed && !shared && c->to_n<=c->from_n;
        uint64_t allocations=c->changed && !reused;
        if(STR(output)->len!=c->expected_n || memcmp(STR(output)->d,c->expected,c->expected_n) ||
           STR(output)->d[c->expected_n] || text_allocations-before!=allocations ||
           text_count(output)!=(shared && !c->changed?2:1) || (reused && output!=source))return 240;
        if(shared && (STR(source)->len!=c->source_n || memcmp(STR(source)->d,c->source,c->source_n)))return 240;
        if(text_raw_requests || text_raw_bytes || text_raw_live || text_raw_peak)return 240;
        TEXT_DROP(output);
        if(shared)TEXT_DROP(source);
        TEXT_DROP(pattern);TEXT_DROP(replacement);
    }
    // Borrowed arguments can point at the consumed source without owning it again.
    for(int alias=0;alias<2;alias++)for(int shared=0;shared<2;shared++) {
        V source=text_new("abc"),other=text_new(alias?"a":"x");
        if(shared)fwp_rc_dup(source);
        uint64_t before=text_allocations;
        text_direct_active=1;
        V output=alias?TEXT_REPLACE(other,source,source):TEXT_REPLACE(source,other,source);
        text_direct_active=0;
        if(!text_equal(output,alias?"abcbc":"x") || text_count(output)!=1 ||
           text_allocations-before!=(uint64_t)(alias || shared) || text_raw_requests)return 240;
        if(shared && (!text_equal(source,"abc") || text_count(source)!=1))return 240;
        if(!alias && !shared && output!=source)return 240;
        TEXT_DROP(output);
        if(shared)TEXT_DROP(source);
        TEXT_DROP(other);
    }
    for(int shared=0;shared<2;shared++) {
        V source=text_new("a"),replacement=text_new("x");
        if(shared)fwp_rc_dup(source);
        uint64_t before=text_allocations;
        text_direct_active=1;
        V output=TEXT_REPLACE(source,replacement,source);
        text_direct_active=0;
        if(!text_equal(output,"x") || text_count(output)!=1 ||
           text_allocations-before!=(uint64_t)shared || text_raw_requests)return 240;
        if(shared && (!text_equal(source,"a") || text_count(source)!=1))return 240;
        if(!shared && output!=source)return 240;
        TEXT_DROP(output);
        if(shared)TEXT_DROP(source);
        TEXT_DROP(replacement);
    }
    const char repeated_bytes[]="λ\0x";
    const V repeat_counts[]={0,1,2,3,31,1025};
    for(size_t n=0;n<sizeof repeat_counts/sizeof *repeat_counts;n++)for(int empty=0;empty<2;empty++) {
        size_t length=empty?0:sizeof repeated_bytes-1;
        V source=fwp_rc_fresh(fwp_str_new(repeated_bytes,length));
        uint64_t before=text_allocations;
        text_direct_active=1;
        V output=TEXT_REPEAT(repeat_counts[n],source);
        text_direct_active=0;
        size_t total=length*(size_t)repeat_counts[n];
        if(STR(output)->len!=total || STR(output)->d[total] || text_allocations-before!=1 ||
           text_count(source)!=1 || STR(source)->len!=length || memcmp(STR(source)->d,repeated_bytes,length) ||
           text_raw_requests || text_raw_live)return 240;
        for(size_t j=0;j<total;j++)if(STR(output)->d[j]!=repeated_bytes[j%length])return 240;
        TEXT_DROP(output);TEXT_DROP(source);
    }
    for(int repeat=0;repeat<2;repeat++) {
        V source=text_new("abc"),pattern=text_new("b"),replacement=text_new("longer");
        if(!repeat)fwp_rc_dup(source);
        fwp_trap_recover=text_recover;fwp_trap_jb=&text_jump;fwp_trap_cleanup=NULL;
        text_direct_active=text_fail_result=1;
        if(!setjmp(text_jump)) {
            if(repeat)TEXT_REPEAT(3,source);else TEXT_REPLACE(pattern,replacement,source);
            return 239;
        }
        text_direct_active=text_fail_result=0;
        fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if(strcmp(fwp_trap_msg,"string output allocation") || fwp_cleanups ||
           text_count(source)!=1 || !text_equal(source,"abc") || text_raw_live)return 239;
        TEXT_DROP(source);TEXT_DROP(pattern);TEXT_DROP(replacement);
    }
    fwp_tasks_finish();
    if(fwp_heap.live!=initial)return 236;
    puts("text owners transfer, preserve aliases and release on failure");
    return 0;
}
