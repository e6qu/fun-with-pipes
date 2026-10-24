//! Start exactly one worker, using the production Rust thread API.
use std::env;
use std::hint::black_box;
use std::process::ExitCode;
use std::thread;

fn main() -> ExitCode {
    let args: Vec<_> = env::args().collect();
    assert_eq!(args.len(), 2);
    let mib: usize = args[1].parse().unwrap();
    assert!(matches!(mib, 256 | 4096));
    let result = thread::Builder::new()
        .stack_size(mib * 1024 * 1024)
        .spawn(|| {
            let block = Box::new([0_u8; 56]);
            black_box(&block);
        });
    match result {
        Ok(worker) => {
            worker.join().unwrap();
            println!("stack_mib={mib} creation=0 joining=0");
            ExitCode::SUCCESS
        }
        Err(error) => {
            println!("stack_mib={mib} creation={error:?}");
            ExitCode::FAILURE
        }
    }
}
