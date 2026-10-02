//! CSV for the interpreter (`csv.parse-with`, `csv.decode`); the C runtime
//! has the same functions (`runtime/fwp_rt_exec.c`).
//!
//! * Fields are separated by a one-byte separator and records by `\n` or
//!   `\r\n`. A field that starts with `"` is quoted: it may contain the
//!   separator and newlines, and `""` is a quote. Text after its closing
//!   quote is kept, and a quote that is never closed runs to the end of
//!   the input (nothing is an error).
//! * Empty lines are skipped.

use crate::ir::{Program, TypeShape, MT};
use crate::value::Value;

/// The records of a CSV text.
pub fn parse(text: &str, sep: u8) -> Vec<Vec<String>> {
    let s = text.as_bytes();
    let mut rows = Vec::new();
    let mut row: Vec<String> = Vec::new();
    let mut field: Vec<u8> = Vec::new();
    let mut at_start = true; // at the start of a field
    let mut any = false; // the record has something
    let mut i = 0;
    let take = |f: &mut Vec<u8>| String::from_utf8_lossy(&std::mem::take(f)).into_owned();
    while i < s.len() {
        let c = s[i];
        if at_start && c == b'"' {
            i += 1;
            while i < s.len() {
                if s[i] == b'"' {
                    if s.get(i + 1) == Some(&b'"') {
                        field.push(b'"');
                        i += 2;
                        continue;
                    }
                    i += 1;
                    break;
                }
                field.push(s[i]);
                i += 1;
            }
            at_start = false;
            any = true;
            continue;
        }
        if c == sep {
            row.push(take(&mut field));
            at_start = true;
            any = true;
            i += 1;
            continue;
        }
        if c == b'\n' || (c == b'\r' && s.get(i + 1) == Some(&b'\n')) {
            i += if c == b'\r' { 2 } else { 1 };
            if any {
                row.push(take(&mut field));
                rows.push(std::mem::take(&mut row));
            }
            field.clear();
            at_start = true;
            any = false;
            continue;
        }
        field.push(c);
        at_start = false;
        any = true;
        i += 1;
    }
    if any {
        row.push(take(&mut field));
        rows.push(row);
    }
    rows
}

/// A header as a field name: trimmed, in lower case, with spaces and
/// `_` as `-` (`First Name` is `first-name`).
pub fn column_name(h: &str) -> String {
    h.trim()
        .chars()
        .map(|c| match c {
            ' ' | '_' => '-',
            c => c.to_ascii_lowercase(),
        })
        .collect()
}

/// Records of type `t` from rows whose first one is the header: each
/// field from the column of its name, parsed as command-line values are
/// (an `Option` field is `None` when its cell is empty or its column
/// missing).
pub fn decode(rows: &[Value], t: &MT, prog: &Program) -> Result<Vec<Value>, String> {
    let fields: Vec<(String, MT)> = match t {
        MT::Record(fs) => fs.clone(),
        MT::Con(..) => match prog.shapes.get(t) {
            Some(TypeShape::Record(fs)) => fs.clone(),
            _ => Vec::new(),
        },
        _ => Vec::new(),
    };
    if fields.is_empty()
        || fields
            .iter()
            .any(|(l, _)| l.starts_with(|c: char| c.is_ascii_digit()))
    {
        return Err(format!("`{}` is not a record with named fields", t));
    }
    let rows: Vec<Vec<String>> = rows
        .iter()
        .map(|r| {
            r.list_items()
                .iter()
                .map(|c| c.as_str().to_string())
                .collect()
        })
        .collect();
    let Some(header) = rows.first() else {
        return Ok(Vec::new());
    };
    let header: Vec<String> = header.iter().map(|h| column_name(h)).collect();
    let mut cols = Vec::new();
    for (name, ty) in &fields {
        let col = header.iter().position(|h| h == name);
        if col.is_none() && crate::cli::option_elem(ty).is_none() {
            return Err(format!("missing column `{}`", name));
        }
        cols.push(col);
    }
    let mut out = Vec::new();
    for (r, row) in rows.iter().enumerate().skip(1) {
        let mut vals = Vec::new();
        for ((name, ty), col) in fields.iter().zip(&cols) {
            let text = col.and_then(|c| row.get(c)).map_or("", |s| s.as_str());
            let v = match crate::cli::option_elem(ty) {
                Some(_) if text.trim().is_empty() => Ok(Value::data(0, vec![])),
                Some(e) => crate::cli::parse_value(text, &e, prog).map(|v| Value::data(1, vec![v])),
                None => crate::cli::parse_value(text, ty, prog),
            };
            vals.push(v.map_err(|m| format!("row {}: column `{}`: {}", r + 1, name, m))?);
        }
        out.push(Value::Record(vals.into()));
    }
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::parse;

    fn p(s: &str) -> Vec<Vec<String>> {
        parse(s, b',')
    }

    #[test]
    fn quoting() {
        assert_eq!(p("a,b\n1,2\n"), vec![vec!["a", "b"], vec!["1", "2"]]);
        assert_eq!(
            p("\"a,b\",\"c\"\"d\"\r\nx"),
            vec![vec!["a,b", "c\"d"], vec!["x"]]
        );
        assert_eq!(p("\"multi\nline\",2"), vec![vec!["multi\nline", "2"]]);
        assert_eq!(p("\n\na\n\n"), vec![vec!["a"]]);
        assert_eq!(p(",\n\"\""), vec![vec!["", ""], vec![""]]);
        assert_eq!(p("\"ab\"c,\"open"), vec![vec!["abc", "open"]]);
        assert_eq!(p("a\rb"), vec![vec!["a\rb"]]);
    }
}
