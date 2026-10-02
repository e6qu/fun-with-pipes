//! fwp ("foop"): a tacit, statically typed, pipe-oriented language.

// `Value` keys in maps and sets contain `RefCell`s only inside file
// handles, whose ordering is by pointer and never by their contents.
#![allow(clippy::mutable_key_type)]

pub mod ast;
pub mod cgen;
pub mod cli;
pub mod cli_gen;
pub mod csv;
pub mod diag;
pub mod driver;
pub mod env;
pub mod exec;
pub mod exhaust;
pub mod ffi;
pub mod ffi_interp;
pub mod fmt;
pub mod h2;
pub mod infer;
pub mod interp;
pub mod ir;
pub mod json;
pub mod lexer;
pub mod linalg;
pub mod lint;
pub mod lsp;
pub mod macros;
pub mod mono;
pub mod opt;
pub mod parser;
pub mod pretty;
pub mod prims_std;
pub mod proto;
pub mod protobuf;
pub mod sched;
pub mod services;
pub mod solve;
pub mod stdgen;
pub mod syntax;
pub mod sys;
pub mod textio;
pub mod types;
pub mod value;
pub mod web;
