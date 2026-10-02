//! Source files, spans and diagnostics.

use std::fmt;

/// A location in a source file. Lines and columns are 1-based.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash, Default)]
pub struct Span {
    pub file: u32,
    pub line: u32,
    pub col: u32,
    pub len: u32,
}

impl Span {
    pub const DUMMY: Span = Span {
        file: u32::MAX,
        line: 0,
        col: 0,
        len: 0,
    };
}

#[derive(Clone, Debug)]
pub struct SourceFile {
    pub name: String,
    pub text: String,
}

/// All source files loaded during a compilation.
#[derive(Clone, Debug, Default)]
pub struct SourceMap {
    pub files: Vec<SourceFile>,
}

impl SourceMap {
    pub fn add(&mut self, name: impl Into<String>, text: impl Into<String>) -> u32 {
        self.files.push(SourceFile {
            name: name.into(),
            text: text.into(),
        });
        (self.files.len() - 1) as u32
    }

    pub fn get(&self, id: u32) -> Option<&SourceFile> {
        self.files.get(id as usize)
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Level {
    Error,
    Warning,
}

#[derive(Clone, Debug)]
pub struct Diagnostic {
    pub level: Level,
    pub message: String,
    pub span: Span,
    pub notes: Vec<String>,
}

impl Diagnostic {
    pub fn error(span: Span, message: impl Into<String>) -> Self {
        Diagnostic {
            level: Level::Error,
            message: message.into(),
            span,
            notes: Vec::new(),
        }
    }

    pub fn warning(span: Span, message: impl Into<String>) -> Self {
        Diagnostic {
            level: Level::Warning,
            message: message.into(),
            span,
            notes: Vec::new(),
        }
    }

    pub fn with_note(mut self, note: impl Into<String>) -> Self {
        self.notes.push(note.into());
        self
    }

    /// Render as `file:line:col: error: message` followed by the source line
    /// and a caret marker.
    pub fn render(&self, sm: &SourceMap) -> String {
        let mut out = String::new();
        let level = match self.level {
            Level::Error => "error",
            Level::Warning => "warning",
        };
        match sm.get(self.span.file) {
            Some(file) if self.span.line > 0 => {
                out.push_str(&format!(
                    "{}:{}:{}: {}: {}\n",
                    file.name, self.span.line, self.span.col, level, self.message
                ));
                if let Some(line) = file.text.lines().nth(self.span.line as usize - 1) {
                    let gutter = format!("{}", self.span.line);
                    out.push_str(&format!("{} | {}\n", gutter, line));
                    let pad: String = line
                        .chars()
                        .take(self.span.col.saturating_sub(1) as usize)
                        .map(|c| if c == '\t' { '\t' } else { ' ' })
                        .collect();
                    let width = self.span.len.max(1) as usize;
                    out.push_str(&format!(
                        "{} | {}{}\n",
                        " ".repeat(gutter.len()),
                        pad,
                        "^".repeat(width)
                    ));
                }
            }
            _ => out.push_str(&format!("{}: {}\n", level, self.message)),
        }
        for n in &self.notes {
            out.push_str(&format!("  note: {}\n", n));
        }
        out
    }
}

impl fmt::Display for Diagnostic {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.message)
    }
}

pub type DResult<T> = Result<T, Diagnostic>;

/// Render a list of diagnostics.
pub fn render_all(diags: &[Diagnostic], sm: &SourceMap) -> String {
    diags.iter().map(|d| d.render(sm)).collect()
}
