//! fwp ("foop"): a tacit, statically typed, pipe-oriented language.

pub mod ast;
pub mod diag;
pub mod driver;
pub mod env;
pub mod exhaust;
pub mod infer;
pub mod lexer;
pub mod parser;
pub mod pretty;
pub mod solve;
pub mod stdgen;
pub mod types;
