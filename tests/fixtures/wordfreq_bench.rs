//! ASCII comparison for examples/wordfreq.fwp; sorted pairs, not a hash table.
use std::io::{self, Read, Write};

fn main() -> io::Result<()> {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input)?;
    assert!(input.is_ascii() && !input.contains('\0'));
    // Keep all normalized words before counting, matching the fwp pipeline.
    let words: Vec<String> = input
        .split(|c| matches!(c, ' ' | '\t' | '\n' | '\r'))
        .filter(|word| !word.is_empty())
        .map(|word| {
            word.bytes()
                .filter(|c| !matches!(c, b',' | b'.'))
                .map(|c| c.to_ascii_lowercase() as char)
                .collect()
        })
        .collect();
    drop(input);
    let mut table: Vec<(String, i64)> = Vec::new();
    for word in words {
        match table.binary_search_by(|entry| entry.0.cmp(&word)) {
            Ok(i) => table[i].1 = table[i].1.checked_add(1).unwrap(),
            Err(i) => table.insert(i, (word, 1)),
        }
    }
    table.sort_unstable_by(|a, b| b.1.cmp(&a.1).then_with(|| a.0.cmp(&b.0)));
    let mut output = io::stdout().lock();
    for (word, count) in table.iter().take(5) {
        writeln!(output, "{word}: {count}")?;
    }
    Ok(())
}
