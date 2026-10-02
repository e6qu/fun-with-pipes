//! Lexer for fwp source text.
//!
//! Tokens carry layout information (column and whether they are the first
//! token on their line) which the parser uses for its offside rule.

use crate::diag::{DResult, Diagnostic, Span};

#[derive(Clone, Debug, PartialEq)]
pub enum Tok {
    /// Lowercase identifier, possibly qualified: `map`, `wrapping.add`.
    Ident(String),
    /// Uppercase identifier, possibly qualified: `Some`, `Json.Null`.
    Upper(String),
    /// Field selector path: `.name`, `.address.city`, `.0`.
    Selector(Vec<String>),
    /// Macro invocation head: `name!(` (the `(` is consumed).
    MacroCall(String),
    Int {
        neg: bool,
        mag: u128,
        suffix: Option<String>,
    },
    Float {
        value: f64,
        suffix: Option<String>,
    },
    /// Balanced ternary literal `0t+-0`, most significant trit first.
    Trits(Vec<i8>),
    /// Duration literal in nanoseconds: `2s`, `150ms`.
    Duration(i128),
    Str(String),
    Keyword(Kw),
    Sym(Sym),
    Underscore,
    Eof,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kw {
    Rec,
    Match,
    Trait,
    Impl,
    Where,
    Comptime,
    Import,
    Export,
    Macro,
    Quote,
    Resource,
    Foreign,
    With,
    Type,
    Test,
    Make,
    Update,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Sym {
    Pipe,
    Eq,
    Colon,
    Arrow,
    Bang,
    LParen,
    RParen,
    LBracket,
    RBracket,
    LBrace,
    RBrace,
    Comma,
    Semi,
}

impl Sym {
    pub fn text(self) -> &'static str {
        match self {
            Sym::Pipe => "|",
            Sym::Eq => "=",
            Sym::Colon => ":",
            Sym::Arrow => "->",
            Sym::Bang => "!",
            Sym::LParen => "(",
            Sym::RParen => ")",
            Sym::LBracket => "[",
            Sym::RBracket => "]",
            Sym::LBrace => "{",
            Sym::RBrace => "}",
            Sym::Comma => ",",
            Sym::Semi => ";",
        }
    }
}

impl Kw {
    pub fn text(self) -> &'static str {
        match self {
            Kw::Rec => "rec",
            Kw::Match => "match",
            Kw::Trait => "trait",
            Kw::Impl => "impl",
            Kw::Where => "where",
            Kw::Comptime => "comptime",
            Kw::Import => "import",
            Kw::Export => "export",
            Kw::Macro => "macro",
            Kw::Quote => "quote",
            Kw::Resource => "resource",
            Kw::Foreign => "foreign",
            Kw::With => "with",
            Kw::Type => "type",
            Kw::Test => "test",
            Kw::Make => "make",
            Kw::Update => "update",
        }
    }

    fn from_str(s: &str) -> Option<Kw> {
        Some(match s {
            "rec" => Kw::Rec,
            "match" => Kw::Match,
            "trait" => Kw::Trait,
            "impl" => Kw::Impl,
            "where" => Kw::Where,
            "comptime" => Kw::Comptime,
            "import" => Kw::Import,
            "export" => Kw::Export,
            "macro" => Kw::Macro,
            "quote" => Kw::Quote,
            "resource" => Kw::Resource,
            "foreign" => Kw::Foreign,
            "with" => Kw::With,
            "type" => Kw::Type,
            "test" => Kw::Test,
            "make" => Kw::Make,
            "update" => Kw::Update,
            _ => return None,
        })
    }
}

impl Tok {
    pub fn describe(&self) -> String {
        match self {
            Tok::Ident(s) => format!("identifier `{}`", s),
            Tok::Upper(s) => format!("name `{}`", s),
            Tok::Selector(p) => format!("selector `.{}`", p.join(".")),
            Tok::MacroCall(s) => format!("macro call `{}!`", s),
            Tok::Int { .. } => "integer literal".into(),
            Tok::Float { .. } => "float literal".into(),
            Tok::Trits(_) => "ternary literal".into(),
            Tok::Duration(_) => "duration literal".into(),
            Tok::Str(_) => "string literal".into(),
            Tok::Keyword(k) => format!("keyword `{}`", k.text()),
            Tok::Sym(s) => format!("`{}`", s.text()),
            Tok::Underscore => "`_`".into(),
            Tok::Eof => "end of file".into(),
        }
    }
}

#[derive(Clone, Debug)]
pub struct Token {
    pub tok: Tok,
    pub span: Span,
    /// True if this is the first token on its line.
    pub bol: bool,
}

pub fn is_int_suffix(s: &str) -> bool {
    matches!(
        s,
        "i8" | "i16"
            | "i32"
            | "i64"
            | "i128"
            | "u8"
            | "u16"
            | "u32"
            | "u64"
            | "u128"
            | "isize"
            | "usize"
    )
}

pub fn is_float_suffix(s: &str) -> bool {
    matches!(s, "f16" | "bf16" | "f32" | "f64" | "f128")
}

fn duration_unit(s: &str) -> Option<i128> {
    Some(match s {
        "ns" => 1,
        "us" => 1_000,
        "ms" => 1_000_000,
        "s" => 1_000_000_000,
        "min" => 60_000_000_000,
        "h" => 3_600_000_000_000,
        _ => return None,
    })
}

struct Lexer<'a> {
    src: &'a [u8],
    text: &'a str,
    pos: usize,
    line: u32,
    col: u32,
    file: u32,
    toks: Vec<Token>,
    line_has_token: bool,
}

pub fn lex(text: &str, file: u32) -> DResult<Vec<Token>> {
    let mut lx = Lexer {
        src: text.as_bytes(),
        text,
        pos: 0,
        line: 1,
        col: 1,
        file,
        toks: Vec::new(),
        line_has_token: false,
    };
    lx.run()?;
    Ok(lx.toks)
}

fn is_ident_start(c: u8) -> bool {
    c.is_ascii_lowercase() || c == b'_'
}

fn is_ident_char(c: u8) -> bool {
    c.is_ascii_alphanumeric() || c == b'_'
}

impl<'a> Lexer<'a> {
    fn peek(&self) -> u8 {
        self.peek_at(0)
    }

    fn peek_at(&self, n: usize) -> u8 {
        *self.src.get(self.pos + n).unwrap_or(&0)
    }

    fn bump(&mut self) -> u8 {
        let c = self.peek();
        self.pos += 1;
        if c == b'\n' {
            self.line += 1;
            self.col = 1;
            self.line_has_token = false;
        } else if (c & 0xC0) != 0x80 {
            // count columns in characters, not UTF-8 continuation bytes
            self.col += 1;
        }
        c
    }

    fn span_from(&self, line: u32, col: u32, start: usize) -> Span {
        Span {
            file: self.file,
            line,
            col,
            len: if self.line == line {
                (self.col - col).max(1)
            } else {
                (self.pos - start) as u32
            },
        }
    }

    fn err<T>(&self, line: u32, col: u32, msg: impl Into<String>) -> DResult<T> {
        Err(Diagnostic::error(
            Span {
                file: self.file,
                line,
                col,
                len: 1,
            },
            msg,
        ))
    }

    fn push(&mut self, tok: Tok, line: u32, col: u32, start: usize) {
        let span = self.span_from(line, col, start);
        let bol = !self.line_has_token;
        self.line_has_token = true;
        self.toks.push(Token { tok, span, bol });
    }

    fn prev_is_adjacent_operand(&self, start: usize) -> bool {
        // Whether the token immediately before `start` (no whitespace) is an
        // operand-like character, which makes a following `.` part of a path
        // rather than a selector.
        if start == 0 {
            return false;
        }
        let c = self.src[start - 1];
        is_ident_char(c) || c == b')' || c == b']' || c == b'}' || c == b'"'
    }

    fn run(&mut self) -> DResult<()> {
        loop {
            let c = self.peek();
            if c == 0 {
                break;
            }
            if c == b' ' || c == b'\t' || c == b'\r' || c == b'\n' {
                self.bump();
                continue;
            }
            if c == b'#' {
                while self.peek() != b'\n' && self.peek() != 0 {
                    self.bump();
                }
                continue;
            }
            let (line, col, start) = (self.line, self.col, self.pos);
            if c.is_ascii_digit() || (c == b'-' && self.peek_at(1).is_ascii_digit()) {
                let tok = self.number(line, col)?;
                self.push(tok, line, col, start);
                continue;
            }
            if c == b'"' {
                let s = self.string(line, col)?;
                self.push(Tok::Str(s), line, col, start);
                continue;
            }
            if c == b'.'
                && (is_ident_char(self.peek_at(1)))
                && !self.prev_is_adjacent_operand(start)
            {
                let mut path = Vec::new();
                while self.peek() == b'.' && is_ident_char(self.peek_at(1)) {
                    self.bump();
                    let s = self.pos;
                    while is_ident_char(self.peek())
                        || (self.peek() == b'-'
                            && self.peek_at(1).is_ascii_alphabetic()
                            && s != self.pos)
                    {
                        self.bump();
                    }
                    path.push(self.text[s..self.pos].to_string());
                }
                self.push(Tok::Selector(path), line, col, start);
                continue;
            }
            if is_ident_start(c) || c.is_ascii_uppercase() {
                if c == b'_' && !is_ident_char(self.peek_at(1)) {
                    self.bump();
                    self.push(Tok::Underscore, line, col, start);
                    continue;
                }
                let tok = self.ident()?;
                self.push(tok, line, col, start);
                continue;
            }
            let sym = match c {
                b'|' => Sym::Pipe,
                b'=' => Sym::Eq,
                b':' => Sym::Colon,
                b'-' if self.peek_at(1) == b'>' => {
                    self.bump();
                    Sym::Arrow
                }
                b'!' => Sym::Bang,
                b'(' => Sym::LParen,
                b')' => Sym::RParen,
                b'[' => Sym::LBracket,
                b']' => Sym::RBracket,
                b'{' => Sym::LBrace,
                b'}' => Sym::RBrace,
                b',' => Sym::Comma,
                b';' => Sym::Semi,
                _ => {
                    let ch = self.text[self.pos..].chars().next().unwrap_or('?');
                    return self.err(line, col, format!("unexpected character `{}`", ch));
                }
            };
            self.bump();
            self.push(Tok::Sym(sym), line, col, start);
        }
        let (line, col, start) = (self.line, self.col, self.pos);
        self.push(Tok::Eof, line, col, start);
        Ok(())
    }

    /// Identifier segment: letters, digits, `_`, and interior hyphens that are
    /// followed by a letter (`route-spec`, `all-reduce`).
    fn segment(&mut self) -> &'a str {
        let s = self.pos;
        while is_ident_char(self.peek())
            || (self.peek() == b'-' && self.peek_at(1).is_ascii_alphabetic() && self.pos > s)
        {
            self.bump();
        }
        &self.text[s..self.pos]
    }

    fn ident(&mut self) -> DResult<Tok> {
        let mut segs = vec![self.segment()];
        while self.peek() == b'.'
            && (self.peek_at(1).is_ascii_alphabetic() || self.peek_at(1) == b'_')
        {
            self.bump();
            segs.push(self.segment());
        }
        let full = segs.join(".");
        let last = segs.last().unwrap();
        let upper = last.as_bytes()[0].is_ascii_uppercase();
        if segs.len() == 1 {
            if let Some(kw) = Kw::from_str(&full) {
                return Ok(Tok::Keyword(kw));
            }
        }
        if !upper && self.peek() == b'!' && self.peek_at(1) == b'(' {
            self.bump();
            self.bump();
            return Ok(Tok::MacroCall(full));
        }
        Ok(if upper {
            Tok::Upper(full)
        } else {
            Tok::Ident(full)
        })
    }

    fn number(&mut self, line: u32, col: u32) -> DResult<Tok> {
        let neg = if self.peek() == b'-' {
            self.bump();
            true
        } else {
            false
        };
        // balanced ternary
        if self.peek() == b'0'
            && self.peek_at(1) == b't'
            && matches!(self.peek_at(2), b'+' | b'-' | b'0')
        {
            if neg {
                return self.err(line, col, "ternary literals carry their own sign");
            }
            self.bump();
            self.bump();
            let mut trits = Vec::new();
            while matches!(self.peek(), b'+' | b'-' | b'0') {
                trits.push(match self.bump() {
                    b'+' => 1,
                    b'-' => -1,
                    _ => 0,
                });
            }
            return Ok(Tok::Trits(trits));
        }
        let radix = if self.peek() == b'0' && matches!(self.peek_at(1), b'x' | b'b' | b'o') {
            self.bump();
            match self.bump() {
                b'x' => 16,
                b'b' => 2,
                _ => 8,
            }
        } else {
            10
        };
        let mut digits = String::new();
        while self.peek().is_ascii_alphanumeric() || self.peek() == b'_' {
            let c = self.peek();
            if c == b'_' {
                self.bump();
                continue;
            }
            let ok = (c as char).is_digit(radix);
            if !ok {
                break;
            }
            digits.push(c as char);
            self.bump();
        }
        if digits.is_empty() {
            return self.err(line, col, "malformed number literal");
        }
        let mut is_float = false;
        if radix == 10 && self.peek() == b'.' && self.peek_at(1).is_ascii_digit() {
            is_float = true;
            digits.push('.');
            self.bump();
            while self.peek().is_ascii_digit() || self.peek() == b'_' {
                let c = self.bump();
                if c != b'_' {
                    digits.push(c as char);
                }
            }
        }
        if radix == 10
            && matches!(self.peek(), b'e' | b'E')
            && (self.peek_at(1).is_ascii_digit()
                || (matches!(self.peek_at(1), b'+' | b'-') && self.peek_at(2).is_ascii_digit()))
        {
            is_float = true;
            digits.push('e');
            self.bump();
            if matches!(self.peek(), b'+' | b'-') {
                digits.push(self.bump() as char);
            }
            while self.peek().is_ascii_digit() {
                digits.push(self.bump() as char);
            }
        }
        // suffix
        let s = self.pos;
        while self.peek().is_ascii_alphanumeric() {
            self.bump();
        }
        let suffix = &self.text[s..self.pos];
        let suffix = if suffix.is_empty() {
            None
        } else {
            Some(suffix.to_string())
        };
        if let Some(sfx) = &suffix {
            if let Some(unit) = duration_unit(sfx) {
                if radix != 10 {
                    return self.err(line, col, "duration literals must be decimal");
                }
                let ns = if is_float {
                    let v: f64 = digits.parse().unwrap_or(f64::INFINITY);
                    let ns = (v * unit as f64).round();
                    (ns < i64::MAX as f64).then_some(ns as i128)
                } else {
                    digits
                        .parse::<i128>()
                        .ok()
                        .and_then(|d| d.checked_mul(unit))
                        .filter(|ns| *ns <= i64::MAX as i128)
                };
                let Some(mut ns) = ns else {
                    return self.err(
                        line,
                        col,
                        "duration literal out of range (at most about 292 years)",
                    );
                };
                if neg {
                    ns = -ns;
                }
                return Ok(Tok::Duration(ns));
            }
        }
        if is_float || suffix.as_deref().is_some_and(is_float_suffix) {
            if let Some(sfx) = &suffix {
                if !is_float_suffix(sfx) {
                    return self.err(line, col, format!("invalid float suffix `{}`", sfx));
                }
            }
            if radix != 10 {
                return self.err(line, col, "float literals must be decimal");
            }
            let mut v: f64 = digits
                .parse()
                .map_err(|_| Diagnostic::error(self.span_from(line, col, s), "bad float"))?;
            if neg {
                v = -v;
            }
            return Ok(Tok::Float { value: v, suffix });
        }
        if let Some(sfx) = &suffix {
            if !is_int_suffix(sfx) {
                return self.err(line, col, format!("invalid integer suffix `{}`", sfx));
            }
        }
        let mag = u128::from_str_radix(&digits, radix).map_err(|_| {
            Diagnostic::error(
                Span {
                    file: self.file,
                    line,
                    col,
                    len: 1,
                },
                "integer literal too large",
            )
        })?;
        Ok(Tok::Int { neg, mag, suffix })
    }

    fn string(&mut self, line: u32, col: u32) -> DResult<String> {
        self.bump(); // opening quote
        let mut out = String::new();
        loop {
            let c = self.peek();
            match c {
                0 => return self.err(line, col, "unterminated string literal"),
                b'"' => {
                    self.bump();
                    break;
                }
                b'\\' => {
                    let (el, ec) = (self.line, self.col);
                    self.bump();
                    let e = self.bump();
                    match e {
                        b'n' => out.push('\n'),
                        b't' => out.push('\t'),
                        b'r' => out.push('\r'),
                        b'0' => out.push('\0'),
                        b'\\' => out.push('\\'),
                        b'"' => out.push('"'),
                        b'u' => {
                            if self.bump() != b'{' {
                                return self.err(el, ec, "expected `{` after `\\u`");
                            }
                            let s = self.pos;
                            while self.peek().is_ascii_hexdigit() {
                                self.bump();
                            }
                            let hex = &self.text[s..self.pos];
                            if self.bump() != b'}' {
                                return self.err(el, ec, "expected `}` in unicode escape");
                            }
                            let ch = u32::from_str_radix(hex, 16).ok().and_then(char::from_u32);
                            match ch {
                                Some(ch) => out.push(ch),
                                None => return self.err(el, ec, "invalid unicode escape"),
                            }
                        }
                        _ => return self.err(el, ec, "unknown escape sequence"),
                    }
                }
                _ => {
                    // copy one UTF-8 character
                    let ch = self.text[self.pos..].chars().next().unwrap();
                    for _ in 0..ch.len_utf8() {
                        self.bump();
                    }
                    out.push(ch);
                }
            }
        }
        Ok(out)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn toks(s: &str) -> Vec<Tok> {
        lex(s, 0).unwrap().into_iter().map(|t| t.tok).collect()
    }

    #[test]
    fn idents_and_selectors() {
        assert_eq!(
            toks("users | filter .active | map .name"),
            vec![
                Tok::Ident("users".into()),
                Tok::Sym(Sym::Pipe),
                Tok::Ident("filter".into()),
                Tok::Selector(vec!["active".into()]),
                Tok::Sym(Sym::Pipe),
                Tok::Ident("map".into()),
                Tok::Selector(vec!["name".into()]),
                Tok::Eof
            ]
        );
        assert_eq!(
            toks("graph.constant-fold Json.Null .a.b .0"),
            vec![
                Tok::Ident("graph.constant-fold".into()),
                Tok::Upper("Json.Null".into()),
                Tok::Selector(vec!["a".into(), "b".into()]),
                Tok::Selector(vec!["0".into()]),
                Tok::Eof
            ]
        );
    }

    #[test]
    fn numbers() {
        assert_eq!(
            toks("42 -7 7u8 1.5f32 2e3 0xff 2s 150ms 0t+-0"),
            vec![
                Tok::Int {
                    neg: false,
                    mag: 42,
                    suffix: None
                },
                Tok::Int {
                    neg: true,
                    mag: 7,
                    suffix: None
                },
                Tok::Int {
                    neg: false,
                    mag: 7,
                    suffix: Some("u8".into())
                },
                Tok::Float {
                    value: 1.5,
                    suffix: Some("f32".into())
                },
                Tok::Float {
                    value: 2000.0,
                    suffix: None
                },
                Tok::Int {
                    neg: false,
                    mag: 255,
                    suffix: None
                },
                Tok::Duration(2_000_000_000),
                Tok::Duration(150_000_000),
                Tok::Trits(vec![1, -1, 0]),
                Tok::Eof
            ]
        );
    }

    #[test]
    fn hyphen_vs_negative() {
        assert_eq!(
            toks("all-reduce x -1"),
            vec![
                Tok::Ident("all-reduce".into()),
                Tok::Ident("x".into()),
                Tok::Int {
                    neg: true,
                    mag: 1,
                    suffix: None
                },
                Tok::Eof
            ]
        );
    }

    #[test]
    fn strings_comments_macros() {
        assert_eq!(
            toks("\"a\\n\\u{48}\" # comment\nassert!(x) _"),
            vec![
                Tok::Str("a\nH".into()),
                Tok::MacroCall("assert".into()),
                Tok::Ident("x".into()),
                Tok::Sym(Sym::RParen),
                Tok::Underscore,
                Tok::Eof
            ]
        );
    }

    #[test]
    fn layout_flags() {
        let ts = lex("f =\n    g\n    | h\nx = 1", 0).unwrap();
        let bols: Vec<(bool, u32)> = ts.iter().map(|t| (t.bol, t.span.col)).collect();
        assert_eq!(
            bols,
            vec![
                (true, 1),
                (false, 3),
                (true, 5),
                (true, 5),
                (false, 7),
                (true, 1),
                (false, 3),
                (false, 5),
                (false, 6)
            ]
        );
    }
}
