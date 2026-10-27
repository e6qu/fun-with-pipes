from pathlib import Path
import os
import re
import subprocess
import sys

compiler, cc, output_dir = sys.argv[1:]
root = Path.cwd()
out = Path(output_dir)
out.mkdir(parents=True, exist_ok=True)
adapter = r'''
mod fwp { pub mod cgen {
    pub struct TempDir { path: std::path::PathBuf }
    impl TempDir {
        pub fn new(prefix: &str) -> Result<Self, String> {
            let path=std::env::temp_dir().join(format!("{}-actual-{}", prefix, std::process::id()));
            std::fs::create_dir(&path).map_err(|e|e.to_string())?;
            Ok(Self { path })
        }
        pub fn join(&self, name: impl AsRef<std::path::Path>) -> std::path::PathBuf { self.path.join(name) }
    }
    impl Drop for TempDir { fn drop(&mut self) { std::fs::remove_dir_all(&self.path).unwrap(); } }
    pub fn compile_c(code: &str, output: &std::path::Path, opt: &str) -> Result<(), String> {
        // These sources are below the production threshold for GCC LTO.
        assert!(code.len() <= 1_000_000);
        let source=output.with_extension("c");
        std::fs::write(&source,code).unwrap();
        let result=std::process::Command::new(std::env::var("FWP_ACTUAL_TEST_CC").unwrap())
            .args([opt,"-std=gnu11","-ffp-contract=off","-w"])
            .arg(&source).arg("-o").arg(output)
            .args(["-lssl","-lcrypto","-lm","-lpthread"])
            .output().unwrap();
        if result.status.success() { Ok(()) } else { Err(String::from_utf8_lossy(&result.stderr).into()) }
    }
} }
'''
source=(root/'tests/service_value_ownership.rs').read_text().split('#[path = "support/http2_values.rs"]')[0]
source='\n'.join(line for line in source.splitlines() if not line.startswith('//!'))
source=re.sub(r'include_str!\("([^"\n]+)"\)', lambda m:'include_str!("'+str(root/'tests'/m[1])+'")', source)
path=out/'actual.rs'
path.write_text(adapter+source)
binary=out/'actual-test'
subprocess.run(['rustc','--edition=2021','-C','opt-level=1','--test',str(path),'-o',str(binary)],env=dict(os.environ,CARGO_BIN_EXE_fwp=compiler),check=True)
subprocess.run([str(binary),'--nocapture','--test-threads=1'],env=dict(os.environ,FWP_ACTUAL_TEST_CC=cc),check=True)
