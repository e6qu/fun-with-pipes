//! Descriptor decoders own partial values through failures and trapped construction.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn typed_decoder_cleanup_survives_every_injected_construction_exit() {
    let dir = std::env::temp_dir().join(format!("fwp-decoder-partial-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let input = dir.join("decode.fwp");
    std::fs::write(
        &input,
        r#"
Row = { name: String, items: List[String], packed: Array[String], sign: Trit }
read : String -> Result[Row, String]
read = json.read
main = "{\"name\":\"owned\",\"items\":[\"one\",\"two\"],\"packed\":[\"a\",\"b\"],\"sign\":0}" | read | echo
"#,
    )
    .unwrap();
    let cfile = dir.join("decode.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let original = std::fs::read_to_string(cfile).unwrap();
    let descriptor = original
        .split("return fwp_p_json_read(l0, ")
        .nth(1)
        .unwrap()
        .split(')')
        .next()
        .unwrap();
    let probe = format!(
        r#"
static int decode_recover(void) {{ return 1; }}
int main(void) {{
#ifdef _WIN32
    /* Preserve exact test output bytes on native Windows too. */
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    V text=fwp_cstr("{{\"name\":\"owned\",\"items\":[\"one\",\"two\"],\"packed\":[\"a\",\"b\"],\"sign\":0}}");
    V invalid=fwp_cstr("{{\"name\":\"owned\",\"items\":[\"one\",3],\"packed\":[\"a\",\"b\"],\"sign\":0}}");
    intptr_t budget=fwp_gc.budget;
    jmp_buf trap; fwp_trap_jb=&trap; fwp_trap_cleanup=0; fwp_trap_recover=decode_recover;
    decode_probe_at=0; decode_probe_step=0;
    V result=fwp_p_json_read(text,{descriptor});
    ({descriptor})->drop(result);
    int points=decode_probe_step;
    if(points<3 || fwp_cleanups || fwp_gc.budget!=budget || decode_scratch_live) return 190;
    for(decode_probe_at=1;decode_probe_at<=points;decode_probe_at++) {{
        decode_probe_step=0;
        if(!setjmp(trap)) {{ (void)fwp_p_json_read(text,{descriptor}); return 191; }}
        if(strcmp(fwp_trap_msg,"decoder construction control")) return 192;
        if(fwp_cleanups || fwp_gc.budget!=budget || decode_scratch_live) {{ fprintf(stderr,"point=%d charge=%lld scratch=%zu cleanups=%p\n",decode_probe_at,(long long)(budget-fwp_gc.budget),decode_scratch_live,(void*)fwp_cleanups); return 193; }}
    }}
    decode_probe_at=0;
    result=fwp_p_json_read(text,{descriptor});
    const fwp_desc *row=({descriptor})->vfields[0][0];
    fwp_buf wire={{0}}; fwp_encode(&wire,OBJ(result)->f[0],row);
    ({descriptor})->drop(result);
    for(size_t n=0;n<=wire.len;n++) {{
        fwp_rd reader={{(const unsigned char *)wire.d,n,0}}; V value=0;
        int ok=fwp_decode(&reader,row,&value);
        if(ok!=(n==wire.len)) return 196;
        if(ok) row->drop(value);
        if(fwp_cleanups || fwp_gc.budget!=budget) return 197;
    }}
    if(row->fields[row->n-1]->kind!=K_TRIT) return 198;
    wire.d[wire.len-1]=2;
    fwp_rd malformed={{(const unsigned char *)wire.d,wire.len,0}}; V rejected=0;
    if(fwp_decode(&malformed,row,&rejected)) return 199;
    if(fwp_cleanups || fwp_gc.budget!=budget) return 197;
    free(wire.d);
    result=fwp_p_json_read(invalid,{descriptor});
    if(fwp_tag(result)!=1) return 194;
    ({descriptor})->drop(result);
    if(fwp_cleanups || fwp_gc.budget!=budget || fwp_gc.ncollect || decode_scratch_live) return 195;
    puts("partial decoder cleanup verified"); return 0;
}}
"#
    );
    let code = original
        .replace("/* Partial decoder values", "static int decode_probe_at,decode_probe_step; static size_t decode_scratch_live;\nstatic void decode_probe(void){if(++decode_probe_step==decode_probe_at)fwp_trap(\"decoder construction control\");}\n/* Partial decoder values")
        .replace("    V result = fwp_rc_fresh(fwp_record((uint32_t)f->count, f->values));", "    decode_probe();\n    V result = fwp_rc_fresh(fwp_record((uint32_t)f->count, f->values));")
        .replace("    V result = fwp_rc_fresh(fwp_data(tag, (uint32_t)f->count, f->values));", "    decode_probe();\n    V result = fwp_rc_fresh(fwp_data(tag, (uint32_t)f->count, f->values));")
        .replace("            owner.value = fwp_rc_fresh(fwp_cons(f->values[i - 1], owner.value));", "            decode_probe();\n            owner.value = fwp_rc_fresh(fwp_cons(f->values[i - 1], owner.value));")
        .replace("                fwp_array_store(fields->aggregate, i, fields->values[0], d->elem);", "                decode_probe();\n                fwp_array_store(fields->aggregate, i, fields->values[0], d->elem);")
        .replace("        b->next = j->blocks; b->used = 0; b->capacity = capacity;", "        decode_scratch_live += sizeof *b + capacity;\n        b->next = j->blocks; b->used = 0; b->capacity = capacity;")
        .replace("        free(block);", "        decode_scratch_live -= sizeof *block + block->capacity;\n        free(block);")
        .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)");
    let code = format!("{code}\n{probe}");
    let omitted = code.replace(
        "if (d && d->drop) d->drop(f->values[i]);",
        "/* omitted partial child drop */",
    );
    assert_ne!(omitted, code);
    for opt in ["-O1", "-O2"] {
        let binary = dir
            .join(opt)
            .with_extension(std::env::consts::EXE_EXTENSION);
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        assert_eq!(
            checked(&mut Command::new(&binary)).stdout,
            b"partial decoder cleanup verified\n"
        );
        fwp::cgen::compile_c(&omitted, &binary, opt).unwrap();
        assert_eq!(
            Command::new(binary).output().unwrap().status.code(),
            Some(193)
        );
    }
    std::fs::remove_dir_all(dir).unwrap();
}
