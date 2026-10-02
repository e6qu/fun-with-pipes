//! Services: one program, two deployments.
//!
//! A program built normally calls the exported functions of the modules it
//! imports directly. In a split build (`fwp build --service m`), module `m`
//! becomes a gRPC server of its exported functions, and every call to one
//! of them from another module is compiled to a client stub
//! (`Body::Remote`): it encodes the arguments as a protobuf request,
//! calls the address in `FWP_SERVICE_<M>`, and decodes the result (or the
//! `Error` the function raised). The source is the same in both builds;
//! only the monomorphizer's choice of callee differs.
//!
//! The interpreter's client stubs and server are in `grpc.rs`; the C
//! runtime implements both in `runtime/fwp_rt_grpc.c`.

use crate::ir::Program;
use crate::protobuf::{self, Schema};

/// The address of a service: `FWP_SERVICE_<MODULE>`, else the default.
pub fn address(module: &str, default: &str) -> String {
    std::env::var(protobuf::env_var(module))
        .ok()
        .filter(|s| !s.is_empty())
        .unwrap_or_else(|| default.to_string())
}

/// Check that a service's methods can be served: distinct paths, and
/// schemas for every method.
pub fn check_service(prog: &Program) -> Result<(), String> {
    let svc = prog.service.as_ref().ok_or("no service to serve")?;
    for (i, a) in svc.methods.iter().enumerate() {
        if let Some(b) = svc.methods[..i].iter().find(|b| b.path == a.path) {
            let method = a.path.rsplit('/').next().unwrap_or("");
            return Err(if a.path != protobuf::path(&svc.module, &a.name) {
                format!(
                    "`{}` and `{}` have the same gRPC method `{}`",
                    b.name, a.name, a.path
                )
            } else {
                format!(
                    "two exported functions of `{}` have the gRPC method name `{}`",
                    svc.module, method
                )
            });
        }
    }
    let mut schema = Schema::default();
    crate::rpc::service_methods(prog, &mut schema).map(|_| ())
}

/// The address a service listens on: `--listen`, else
/// `FWP_SERVICE_<MODULE>`, else the build's default.
pub fn listen_address(prog: &Program, listen: Option<String>) -> String {
    let svc = prog.service.as_ref().unwrap();
    listen.unwrap_or_else(|| address(&svc.module, &svc.default_addr))
}

/// Serve the program's service with the interpreter (`fwp serve`), over
/// TLS with a certificate and key (PEM files).
pub fn serve(
    prog: &Program,
    listen: Option<String>,
    tls: Option<crate::tls::ServerFiles>,
) -> i32 {
    crate::grpc::serve(prog, listen, tls)
}

/// The `.proto` file for the services of a program compiled once per
/// service module (`fwp proto`).
pub fn proto_text(progs: &[Program], source: &str) -> Result<String, String> {
    let mut schema = Schema::default();
    let mut methods = Vec::new();
    for prog in progs {
        check_service(prog)?;
        methods.extend(crate::rpc::service_methods(prog, &mut schema)?);
    }
    crate::rpc::proto_file(&schema, &methods, source)
}
