fn main() {
    let arguments: Vec<_> = std::env::args().collect();
    if arguments.len() != 3
        || !["64", "4096"].contains(&arguments[1].as_str())
        || !["0", "1", "2", "3"].contains(&arguments[2].as_str())
    {
        eprintln!("expected population 64|4096 and mode 0|1|2|3");
        std::process::exit(2);
    }
    let population = arguments[1].parse::<usize>().unwrap();
    let mode = arguments[2].parse::<usize>().unwrap();
    let stats = weak_callback_service::service_run(population, mode);
    println!("{{\"population\":{population},\"mode\":{mode},\"calls\":{},\"cancelled\":{},\"expired\":{},\"errors\":{},\"sent\":{},\"received\":{},\"sum\":{},\"received_sum\":{}}}",
        stats.calls, stats.cancelled, stats.expired, stats.errors, stats.sent,
        stats.received, stats.sum, stats.received_sum);
}
