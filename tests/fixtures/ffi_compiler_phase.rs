//! Test compiler launcher: compilation must precede the first program effect.
use std::env;
use std::path::Path;
use std::process::{exit, Command};

fn main() {
    let (Some(marker), Some(compiler)) =
        (env::var_os("FWP_TEST_EFFECT"), env::var_os("FWP_TEST_CC"))
    else {
        exit(89);
    };
    if Path::new(&marker).exists() {
        eprintln!("compiler started after program effect");
        exit(88);
    }
    match Command::new(compiler).args(env::args_os().skip(1)).status() {
        Ok(status) => match status.code() {
            Some(code) => exit(code),
            None => exit(87),
        },
        Err(error) => {
            eprintln!("test compiler launch failed: {error}");
            exit(87);
        }
    }
}
