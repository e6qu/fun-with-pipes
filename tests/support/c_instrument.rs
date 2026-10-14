//! Rename exact call identifiers without rewriting allocator-name suffixes.
pub fn calls(source: &str, replacements: &[(&str, &str)]) -> String {
    source
        .split_inclusive(|c: char| !c.is_ascii_alphanumeric() && c != '_')
        .map(|part| {
            if let Some(name) = part.strip_suffix('(') {
                if let Some((_, replacement)) = replacements.iter().find(|(old, _)| *old == name) {
                    return format!("{replacement}(");
                }
            }
            part.to_owned()
        })
        .collect()
}
