use weak_callback_service::{service_run, Stats};
unsafe extern "C" {
    fn callable_phase_clock() -> u64;
}
fn fail(text: &str, status: i32) -> ! {
    eprintln!("{text}");
    std::process::exit(status);
}
fn number(text: &str) -> i64 {
    if text.is_empty() || !text.bytes().all(|byte| byte.is_ascii_digit()) {
        fail("invalid integer", 2);
    }
    text.parse::<i64>()
        .unwrap_or_else(|_| fail("invalid integer", 2))
}
fn expected(population: i64, mode: i64) -> Stats {
    let mut stats = Stats::default();
    for index in 0..population {
        if mode == 2 {
            stats.expired += 1;
            continue;
        }
        if mode == 1 && index % 4 == 0 {
            stats.cancelled += 1;
            continue;
        }
        if mode == 3 && index > population / 2 {
            continue;
        }
        stats.calls += 1;
        stats.sum += 16 * index + 120;
    }
    stats.errors = i64::from(mode == 3);
    stats.sent = stats.calls;
    stats.received = stats.calls;
    stats.received_sum = stats.sum;
    stats
}
fn main() {
    let arguments: Vec<_> = std::env::args().collect();
    if arguments.len() != 4 {
        fail("expected population mode batches", 2);
    }
    let population = number(&arguments[1]);
    let mode = number(&arguments[2]);
    let batches = number(&arguments[3]);
    if ![64, 4096].contains(&population)
        || !(0..4).contains(&mode)
        || ![1, 16, 64, 256, 1024, 4096, 16384].contains(&batches)
    {
        fail("invalid experiment arguments", 2);
    }
    let want = expected(population, mode);
    let mut total = Stats::default();
    let mut elapsed = 0_u64;
    for _ in 0..batches {
        let before = unsafe { callable_phase_clock() };
        let stats = service_run(population as usize, mode as usize);
        let after = unsafe { callable_phase_clock() };
        if after < before {
            fail("clock moved backwards", 77);
        }
        elapsed += after - before;
        if stats.calls != want.calls {
            fail("incorrect service result", 4);
        }
        if stats.cancelled != want.cancelled {
            fail("incorrect service result", 4);
        }
        if stats.expired != want.expired {
            fail("incorrect service result", 4);
        }
        if stats.errors != want.errors {
            fail("incorrect service result", 4);
        }
        if stats.sent != want.sent {
            fail("incorrect service result", 4);
        }
        if stats.received != want.received {
            fail("incorrect service result", 4);
        }
        if stats.sum != want.sum {
            fail("incorrect service result", 4);
        }
        if stats.received_sum != want.received_sum {
            fail("incorrect service result", 4);
        }
        total.calls += stats.calls;
        total.cancelled += stats.cancelled;
        total.expired += stats.expired;
        total.errors += stats.errors;
        total.sent += stats.sent;
        total.received += stats.received;
        total.sum += stats.sum;
        total.received_sum += stats.received_sum;
    }
    println!("{{\"population\":{population},\"mode\":{mode},\"batches\":{batches},\"calls\":{},\"cancelled\":{},\"expired\":{},\"errors\":{},\"sent\":{},\"received\":{},\"sum\":{},\"received_sum\":{},\"serviceNs\":{elapsed}}}", total.calls, total.cancelled, total.expired, total.errors, total.sent, total.received, total.sum, total.received_sum);
}
