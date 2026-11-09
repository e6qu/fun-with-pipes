fn main() {
    if std::env::args().len() != 1 {
        eprintln!("expected no arguments");
        std::process::exit(2);
    }
    for population in [64, 4096] {
        for mode in 0..4 {
            let stats = weak_callback_service::service_run(population, mode);
            println!("{{\"population\":{population},\"mode\":{mode},\"calls\":{},\"cancelled\":{},\"expired\":{},\"errors\":{},\"sent\":{},\"received\":{},\"sum\":{},\"received_sum\":{}}}",
        stats.calls, stats.cancelled, stats.expired, stats.errors, stats.sent,
        stats.received, stats.sum, stats.received_sum);
        }
    }
}
