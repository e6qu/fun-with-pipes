//! placeholder
pub struct Module {
    pub text: String,
    pub warnings: Vec<String>,
}

pub fn client(_text: &str) -> Result<Module, String> {
    Err("not implemented".into())
}
