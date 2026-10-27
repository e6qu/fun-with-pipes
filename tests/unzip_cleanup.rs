//! Both unzip outputs own their duplicated fields throughout failure cleanup.
use std::process::Command;

#[test]
fn unzip_releases_scratch_fields_and_both_partial_lists() {
    let dir = fwp::cgen::TempDir::new("unzip-cleanup").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(&source, "main = [(\"left\", \"right\")] | unzip | echo\n").unwrap();
    {
        let cfile = dir.join("main.c");
        let emitted = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(emitted.status.success(), "{emitted:?}");
        let code = std::fs::read_to_string(cfile).unwrap();
        let start = code.find("static V fwp_p_unzip_owned(").unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let helper = code[start..end]
            .replace("fwp_mem_alloc(", "unzip_scratch(")
            .replace("fwp_data(", "unzip_node(")
            .replace("fwp_tuple2(", "unzip_pair(");
        let code = code[..start].to_string()
            + "static void *unzip_scratch(size_t);\nstatic V unzip_node(V,size_t,const V *);\nstatic V unzip_pair(V,V);\n"
            + &helper + &code[end..];
        let code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
        let code = code[..code.find("int main(").unwrap()].to_string()
            + include_str!("fixtures/unzip_cleanup.c");
        let missing_field = code.replace(
            "fwp_map_owner left = {l, 0, 0, drop_x, drop_left};",
            "fwp_map_owner left = {l, 0, 0, NULL, drop_left};",
        );
        let missing_list = code.replace(
            "fwp_map_owner right = {r, 0, 0, drop_y, drop_right};",
            "fwp_map_owner right = {r, 0, 0, drop_y, NULL};",
        );
        let missing_scratch = code.replace(
            "fwp_scratch_finish(&a, &scratch_cleanup);",
            "fwp_cleanup_pop(&scratch_cleanup);",
        );
        for opt in ["-O1", "-O2"] {
            for (candidate, expected) in [
                (&code, 0),
                (&missing_field, 248),
                (&missing_list, 248),
                (&missing_scratch, 249),
            ] {
                if expected != 0 {
                    assert_ne!(candidate, &code);
                }
                let binary = dir.join("probe.exe");
                fwp::cgen::compile_c(candidate, &binary, opt).unwrap();
                let result = Command::new(&binary).output().unwrap();
                assert_eq!(
                    result.status.code(),
                    Some(expected),
                    "counted {opt}: {result:?}"
                );
            }
        }
    }
}
