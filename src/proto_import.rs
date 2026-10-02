//! `fwp proto --import`: fwp types, clients and server routes from a
//! `.proto` file.

use std::path::Path;

pub fn generate(path: &Path) -> Result<String, String> {
    Err(format!("{}: not implemented yet", path.display()))
}
