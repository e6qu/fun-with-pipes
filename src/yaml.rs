//! A reader of YAML 1.2 documents as JSON values, for `fwp openapi
//! --import` of OpenAPI documents written in YAML.
//!
//! It reads the part of YAML that such documents use: block mappings and
//! sequences (including a sequence at the indentation of its key and
//! compact `- key: value` items), flow collections (`[a, b]`, `{a: 1}`)
//! over several lines, plain, single-quoted and double-quoted scalars
//! (with escapes and line folding), literal (`|`) and folded (`>`) block
//! scalars with chomping and indentation indicators, comments, anchors
//! and aliases (`&name`, `*name`, and `<<` merge keys), tags (ignored,
//! except `!!str`), and `---` and `...` around a single document. Plain
//! scalars follow the core schema: `null`, `~`, booleans, integers
//! (decimal, `0x`, `0o`), floats (`.inf`, `.nan`) and strings; mapping
//! keys are always strings. Complex keys (`? `), several documents and
//! directives other than `%YAML` are rejected.

use std::collections::HashMap;

use crate::json::Json;

/// Parse a YAML document into a JSON value.
pub fn parse(text: &str) -> Result<Json, String> {
    let mut p = Parser {
        s: text.chars().collect(),
        pos: 0,
        anchors: HashMap::new(),
        depth: 0,
    };
    p.document()
}

struct Parser {
    s: Vec<char>,
    pos: usize,
    anchors: HashMap<String, Json>,
    depth: usize,
}

/// A scalar as it was written: plain scalars are resolved by the core
/// schema, quoted ones are strings.
enum Scalar {
    Plain(String),
    Quoted(String),
}

impl Parser {
    fn err<T>(&self, msg: impl std::fmt::Display) -> Result<T, String> {
        let line = 1 + self.s[..self.pos.min(self.s.len())]
            .iter()
            .filter(|c| **c == '\n')
            .count();
        Err(format!("line {}: {}", line, msg))
    }

    fn peek(&self) -> Option<char> {
        self.s.get(self.pos).copied()
    }

    fn at(&self, k: usize) -> Option<char> {
        self.s.get(self.pos + k).copied()
    }

    /// The column of a position (0-based).
    fn col_of(&self, pos: usize) -> usize {
        let mut i = pos;
        while i > 0 && self.s[i - 1] != '\n' {
            i -= 1;
        }
        pos - i
    }

    fn col(&self) -> usize {
        self.col_of(self.pos)
    }

    /// The position of the start of the current line.
    fn line_start(&self) -> usize {
        self.pos - self.col()
    }

    fn blank(c: Option<char>) -> bool {
        matches!(c, None | Some(' ' | '\t' | '\n' | '\r'))
    }

    /// Skip spaces and a comment on the current line.
    fn skip_inline(&mut self) {
        while matches!(self.peek(), Some(' ' | '\t' | '\r')) {
            self.pos += 1;
        }
        if self.peek() == Some('#')
            && (self.pos == 0 || Self::blank(self.s.get(self.pos - 1).copied()))
        {
            while !matches!(self.peek(), None | Some('\n')) {
                self.pos += 1;
            }
        }
    }

    /// Skip spaces, comments and line breaks. Returns whether a line break
    /// was crossed.
    fn skip_all(&mut self) -> bool {
        let mut crossed = false;
        loop {
            self.skip_inline();
            if self.peek() == Some('\n') {
                self.pos += 1;
                crossed = true;
            } else {
                return crossed;
            }
        }
    }

    /// At `---` or `...` at the start of a line.
    fn at_marker(&self) -> bool {
        self.col() == 0
            && ((self.peek() == Some('-') && self.at(1) == Some('-') && self.at(2) == Some('-'))
                || (self.peek() == Some('.') && self.at(1) == Some('.') && self.at(2) == Some('.')))
            && Self::blank(self.at(3))
    }

    fn document(&mut self) -> Result<Json, String> {
        if self.peek() == Some('\u{feff}') {
            self.pos += 1;
        }
        loop {
            self.skip_all();
            if self.col() == 0 && self.peek() == Some('%') {
                let start = self.pos;
                while !matches!(self.peek(), None | Some('\n')) {
                    self.pos += 1;
                }
                let d: String = self.s[start..self.pos].iter().collect();
                if !d.starts_with("%YAML") {
                    self.pos = start;
                    return self.err(format!("unsupported directive `{}`", d.trim()));
                }
                continue;
            }
            break;
        }
        if self.at_marker() && self.peek() == Some('-') {
            self.pos += 3;
        }
        self.skip_all();
        let v = if self.peek().is_none() || self.at_marker() {
            Json::Null
        } else {
            self.node(0, false)?
        };
        self.skip_all();
        if self.at_marker() && self.peek() == Some('.') {
            self.pos += 3;
            self.skip_all();
        }
        if self.peek().is_some() {
            if self.at_marker() {
                return self.err("several documents are not supported");
            }
            return self.err(format!("unexpected `{}`", self.peek().unwrap()));
        }
        Ok(v)
    }

    /// A block node whose content is at column `indent` or more. With
    /// `seq_at_parent`, a block sequence may start at `indent - 1` (the
    /// value of a mapping key at that column).
    fn node(&mut self, indent: usize, seq_at_parent: bool) -> Result<Json, String> {
        self.depth += 1;
        if self.depth > 400 {
            return self.err("too deeply nested");
        }
        let r = self.node_inner(indent, seq_at_parent);
        self.depth -= 1;
        r
    }

    fn node_inner(&mut self, indent: usize, seq_at_parent: bool) -> Result<Json, String> {
        let mut anchor = None;
        let mut tag = None;
        let mut newline = self.skip_all();
        // properties: an anchor and a tag, in any order
        loop {
            match self.peek() {
                Some('&') => {
                    self.pos += 1;
                    anchor = Some(self.word());
                }
                Some('!') => {
                    tag = Some(self.word());
                }
                _ => break,
            }
            newline |= self.skip_all();
        }
        let _ = newline;
        let c = self.col();
        let min = if seq_at_parent {
            indent.saturating_sub(1)
        } else {
            indent
        };
        let v = if self.peek().is_none() || self.at_marker() || c < min {
            Json::Null
        } else if self.peek() == Some('-')
            && Self::blank(self.at(1))
            && (c >= indent || seq_at_parent)
        {
            self.sequence(c)?
        } else if c < indent {
            Json::Null
        } else {
            match self.peek() {
                Some('*') => {
                    self.pos += 1;
                    let name = self.word();
                    let v = match self.anchors.get(&name) {
                        Some(v) => v.clone(),
                        None => return self.err(format!("unknown alias `*{}`", name)),
                    };
                    self.skip_inline();
                    if self.mapping_follows() {
                        let key = scalar_text(&v);
                        self.mapping(c, Some(key))?
                    } else {
                        v
                    }
                }
                Some('[') | Some('{') => {
                    let v = self.flow()?;
                    self.skip_inline();
                    if self.mapping_follows() {
                        return self.err("a collection cannot be a mapping key");
                    }
                    v
                }
                Some('|') | Some('>') => Json::Str(self.block_scalar(indent)?),
                Some('?') if Self::blank(self.at(1)) => {
                    return self.err("complex mapping keys (`? `) are not supported")
                }
                _ => {
                    let start = self.pos;
                    let s = self.scalar(indent, false)?;
                    self.skip_inline();
                    if self.mapping_follows() {
                        self.pos = start;
                        self.mapping(c, None)?
                    } else {
                        self.resolve(s, tag.as_deref())
                    }
                }
            }
        };
        if let Some(a) = anchor {
            self.anchors.insert(a, v.clone());
        }
        Ok(v)
    }

    /// An anchor, alias or tag name: up to a blank or a flow indicator.
    fn word(&mut self) -> String {
        let start = self.pos;
        while !Self::blank(self.peek()) && !matches!(self.peek(), Some(',' | '[' | ']' | '{' | '}'))
        {
            self.pos += 1;
        }
        self.s[start..self.pos].iter().collect()
    }

    /// At `:` followed by a blank: the scalar before it was a key.
    fn mapping_follows(&self) -> bool {
        self.peek() == Some(':') && Self::blank(self.at(1))
    }

    fn resolve(&self, s: Scalar, tag: Option<&str>) -> Json {
        match s {
            Scalar::Quoted(t) => Json::Str(t),
            Scalar::Plain(t) if tag == Some("!!str") => Json::Str(t),
            Scalar::Plain(t) => plain_value(&t),
        }
    }

    /// A block sequence of items `- ` at column `c`.
    fn sequence(&mut self, c: usize) -> Result<Json, String> {
        let mut items = Vec::new();
        loop {
            // at `-`
            self.pos += 1;
            let line = self.line_start();
            self.skip_inline();
            let item = if self.peek() == Some('\n') || self.peek().is_none() {
                self.node(c + 1, false)?
            } else {
                // the item starts on this line: its content is at its own
                // column (a compact mapping continues there)
                let _ = line;
                let col = self.col();
                self.node(col, false)?
            };
            items.push(item);
            self.skip_all();
            if self.peek().is_none() || self.at_marker() || self.col() != c {
                break;
            }
            if !(self.peek() == Some('-') && Self::blank(self.at(1))) {
                // the next key of the mapping that holds the sequence
                break;
            }
        }
        if self.col() > c && self.peek().is_some() && !self.at_marker() {
            return self.err("unexpected indentation");
        }
        Ok(Json::Arr(items))
    }

    /// A block mapping at column `c`; its first key may be given (an
    /// alias used as a key).
    fn mapping(&mut self, c: usize, mut first: Option<String>) -> Result<Json, String> {
        let mut members: Vec<(String, Json)> = Vec::new();
        loop {
            let key = match first.take() {
                Some(k) => k,
                None => {
                    if self.peek() == Some('?') && Self::blank(self.at(1)) {
                        return self.err("complex mapping keys (`? `) are not supported");
                    }
                    if matches!(self.peek(), Some('[' | '{')) {
                        return self.err("a collection cannot be a mapping key");
                    }
                    if self.peek() == Some('*') {
                        self.pos += 1;
                        let name = self.word();
                        match self.anchors.get(&name) {
                            Some(v) => scalar_text(v),
                            None => return self.err(format!("unknown alias `*{}`", name)),
                        }
                    } else {
                        match self.scalar(c, true)? {
                            Scalar::Plain(t) | Scalar::Quoted(t) => t,
                        }
                    }
                }
            };
            self.skip_inline();
            if !self.mapping_follows() {
                return self.err(format!("expected `:` after the key `{}`", key));
            }
            self.pos += 1;
            let value = self.node(c + 1, true)?;
            if key == "<<" {
                // merge keys: the members of a mapping (or of several)
                let maps = match &value {
                    Json::Arr(ms) => ms.clone(),
                    m => vec![m.clone()],
                };
                for m in maps {
                    for (k, v) in m.members() {
                        if !members.iter().any(|(x, _)| x == k) {
                            members.push((k.clone(), v.clone()));
                        }
                    }
                }
            } else if let Some(m) = members.iter_mut().find(|(k, _)| *k == key) {
                m.1 = value;
            } else {
                members.push((key, value));
            }
            self.skip_all();
            if self.peek().is_none() || self.at_marker() || self.col() < c {
                break;
            }
            if self.col() > c {
                return self.err("unexpected indentation");
            }
            if self.peek() == Some('-') && Self::blank(self.at(1)) {
                return self.err("expected a key, found an item of a sequence");
            }
        }
        Ok(Json::Obj(members))
    }

    /// A scalar in block context: quoted, or plain (ending before `: `
    /// or ` #`, continued on lines indented at least `indent` unless it
    /// is a key).
    fn scalar(&mut self, indent: usize, key: bool) -> Result<Scalar, String> {
        match self.peek() {
            Some('"') => self.double_quoted().map(Scalar::Quoted),
            Some('\'') => self.single_quoted().map(Scalar::Quoted),
            _ => {
                let mut out = self.plain_line(false);
                if out.is_empty() {
                    return self.err(format!(
                        "unexpected `{}`",
                        self.peek().map(String::from).unwrap_or_default()
                    ));
                }
                if key {
                    return Ok(Scalar::Plain(out));
                }
                // continuation lines
                loop {
                    let save = self.pos;
                    self.skip_inline();
                    if self.peek() != Some('\n') {
                        self.pos = save;
                        break;
                    }
                    let mut breaks = 0;
                    while self.peek() == Some('\n') {
                        self.pos += 1;
                        breaks += 1;
                        while matches!(self.peek(), Some(' ' | '\t')) {
                            self.pos += 1;
                        }
                        if self.peek() == Some('\r') {
                            self.pos += 1;
                        }
                    }
                    let blank_comment = self.peek() == Some('#');
                    if self.peek().is_none()
                        || self.col() < indent
                        || self.col() == 0 && indent == 0
                        || blank_comment
                        || self.at_marker()
                        || (self.peek() == Some('-') && Self::blank(self.at(1)))
                    {
                        self.pos = save;
                        break;
                    }
                    let line = self.plain_line(false);
                    if line.is_empty() || self.mapping_follows() {
                        self.pos = save;
                        break;
                    }
                    if breaks > 1 {
                        for _ in 1..breaks {
                            out.push('\n');
                        }
                    } else {
                        out.push(' ');
                    }
                    out.push_str(&line);
                }
                Ok(Scalar::Plain(out))
            }
        }
    }

    /// The rest of a plain scalar on this line.
    fn plain_line(&mut self, flow: bool) -> String {
        let start = self.pos;
        let mut end = self.pos;
        while let Some(c) = self.peek() {
            if c == '\n' {
                break;
            }
            if c == ':'
                && (Self::blank(self.at(1))
                    || (flow && matches!(self.at(1), Some(',' | ']' | '}'))))
            {
                break;
            }
            if c == '#' && self.pos > start && Self::blank(self.s.get(self.pos - 1).copied()) {
                break;
            }
            if flow && matches!(c, ',' | '[' | ']' | '{' | '}') {
                break;
            }
            self.pos += 1;
            if !matches!(c, ' ' | '\t' | '\r') {
                end = self.pos;
            }
        }
        let s: String = self.s[start..end].iter().collect();
        self.pos = end;
        s
    }

    fn double_quoted(&mut self) -> Result<String, String> {
        self.pos += 1;
        let mut out = String::new();
        loop {
            let Some(c) = self.peek() else {
                return self.err("unterminated double-quoted string");
            };
            self.pos += 1;
            match c {
                '"' => return Ok(out),
                '\\' => {
                    let Some(e) = self.peek() else {
                        return self.err("unterminated double-quoted string");
                    };
                    self.pos += 1;
                    let hex = |p: &mut Parser, n: usize| -> Result<char, String> {
                        let h: String = p.s[p.pos..(p.pos + n).min(p.s.len())].iter().collect();
                        p.pos += n;
                        u32::from_str_radix(&h, 16)
                            .ok()
                            .and_then(char::from_u32)
                            .map_or_else(|| p.err(format!("invalid escape `{}`", h)), Ok)
                    };
                    match e {
                        '0' => out.push('\0'),
                        'a' => out.push('\x07'),
                        'b' => out.push('\x08'),
                        't' | '\t' => out.push('\t'),
                        'n' => out.push('\n'),
                        'v' => out.push('\x0b'),
                        'f' => out.push('\x0c'),
                        'r' => out.push('\r'),
                        'e' => out.push('\x1b'),
                        ' ' => out.push(' '),
                        '"' => out.push('"'),
                        '/' => out.push('/'),
                        '\\' => out.push('\\'),
                        'N' => out.push('\u{85}'),
                        '_' => out.push('\u{a0}'),
                        'L' => out.push('\u{2028}'),
                        'P' => out.push('\u{2029}'),
                        'x' => out.push(hex(self, 2)?),
                        'u' => {
                            let c = hex(self, 4);
                            match c {
                                Ok(c) => out.push(c),
                                Err(_) => {
                                    // a surrogate pair
                                    self.pos -= 4;
                                    let hi: String = self.s
                                        [self.pos..(self.pos + 4).min(self.s.len())]
                                        .iter()
                                        .collect();
                                    self.pos += 4;
                                    let hi = u32::from_str_radix(&hi, 16).unwrap_or(0);
                                    if (0xd800..0xdc00).contains(&hi)
                                        && self.peek() == Some('\\')
                                        && self.at(1) == Some('u')
                                    {
                                        self.pos += 2;
                                        let lo: String = self.s
                                            [self.pos..(self.pos + 4).min(self.s.len())]
                                            .iter()
                                            .collect();
                                        self.pos += 4;
                                        let lo = u32::from_str_radix(&lo, 16).unwrap_or(0);
                                        match char::from_u32(
                                            0x10000
                                                + ((hi - 0xd800) << 10)
                                                + (lo.wrapping_sub(0xdc00) & 0x3ff),
                                        ) {
                                            Some(c) => out.push(c),
                                            None => return self.err("invalid surrogate pair"),
                                        }
                                    } else {
                                        return self.err("invalid escape `\\u`");
                                    }
                                }
                            }
                        }
                        'U' => out.push(hex(self, 8)?),
                        '\n' | '\r' => {
                            // an escaped line break: no space
                            if e == '\r' && self.peek() == Some('\n') {
                                self.pos += 1;
                            }
                            while matches!(self.peek(), Some(' ' | '\t')) {
                                self.pos += 1;
                            }
                        }
                        e => return self.err(format!("invalid escape `\\{}`", e)),
                    }
                }
                '\n' | '\r' => {
                    self.fold_break(&mut out, c);
                }
                c => out.push(c),
            }
        }
    }

    /// A line break inside a quoted scalar: trailing spaces are dropped, a
    /// single break is a space, and each further empty line a newline.
    fn fold_break(&mut self, out: &mut String, c: char) {
        if c == '\r' && self.peek() == Some('\n') {
            self.pos += 1;
        }
        while out.ends_with([' ', '\t']) {
            out.pop();
        }
        let mut breaks = 1;
        loop {
            while matches!(self.peek(), Some(' ' | '\t' | '\r')) {
                self.pos += 1;
            }
            if self.peek() == Some('\n') {
                self.pos += 1;
                breaks += 1;
            } else {
                break;
            }
        }
        if breaks == 1 {
            out.push(' ');
        } else {
            for _ in 1..breaks {
                out.push('\n');
            }
        }
    }

    fn single_quoted(&mut self) -> Result<String, String> {
        self.pos += 1;
        let mut out = String::new();
        loop {
            let Some(c) = self.peek() else {
                return self.err("unterminated single-quoted string");
            };
            self.pos += 1;
            match c {
                '\'' if self.peek() == Some('\'') => {
                    self.pos += 1;
                    out.push('\'');
                }
                '\'' => return Ok(out),
                '\n' | '\r' => self.fold_break(&mut out, c),
                c => out.push(c),
            }
        }
    }

    /// A literal (`|`) or folded (`>`) block scalar, its content indented
    /// more than `parent` (the column of the node that holds it, less
    /// one) or by its indentation indicator.
    fn block_scalar(&mut self, indent: usize) -> Result<String, String> {
        let folded = self.peek() == Some('>');
        self.pos += 1;
        let mut chomp = ' ';
        let mut explicit = None;
        for _ in 0..2 {
            match self.peek() {
                Some(c @ ('-' | '+')) => {
                    chomp = c;
                    self.pos += 1;
                }
                Some(c @ '1'..='9') => {
                    explicit = Some(c as usize - '0' as usize);
                    self.pos += 1;
                }
                _ => {}
            }
        }
        self.skip_inline();
        match self.peek() {
            None => return Ok(String::new()),
            Some('\n') => self.pos += 1,
            Some(c) => {
                return self.err(format!("unexpected `{}` after a block scalar indicator", c))
            }
        }
        // the lines, and the content's indentation
        let parent = indent.saturating_sub(1);
        let mut lines: Vec<String> = Vec::new();
        let mut n = explicit.map(|e| parent + e);
        loop {
            let start = self.pos;
            let mut spaces = 0;
            while self.peek() == Some(' ') {
                self.pos += 1;
                spaces += 1;
            }
            let rest_empty = matches!(self.peek(), None | Some('\n' | '\r'));
            if rest_empty {
                if self.peek().is_none() {
                    if spaces > 0 && n.is_some_and(|n| spaces > n) {
                        lines.push(" ".repeat(spaces - n.unwrap()));
                    }
                    break;
                }
                if self.peek() == Some('\r') {
                    self.pos += 1;
                }
                self.pos += 1;
                let extra = n.map(|n| spaces.saturating_sub(n)).unwrap_or(0);
                lines.push(" ".repeat(extra));
                continue;
            }
            let width = *n.get_or_insert(spaces);
            if spaces < width
                || (explicit.is_none() && spaces <= parent && indent > 0)
                || (spaces == 0 && self.at_marker())
            {
                self.pos = start;
                break;
            }
            self.pos = start + width;
            let ls = self.pos;
            while !matches!(self.peek(), None | Some('\n')) {
                self.pos += 1;
            }
            let mut line: String = self.s[ls..self.pos].iter().collect();
            if line.ends_with('\r') {
                line.pop();
            }
            lines.push(line);
            if self.peek() == Some('\n') {
                self.pos += 1;
            } else {
                break;
            }
        }
        // the lines that end the scalar: empty ones are trailing breaks
        let content_end = lines
            .iter()
            .rposition(|l| !l.is_empty())
            .map_or(0, |i| i + 1);
        let trailing = lines.len() - content_end;
        let body = &lines[..content_end];
        let mut out = String::new();
        if folded {
            // a line break between two lines of text is a space, and n
            // empty lines between them are n newlines; around lines that
            // are more indented, breaks are kept
            let mut prev: Option<&str> = None;
            let mut empties = 0;
            for l in body {
                if l.is_empty() {
                    empties += 1;
                    continue;
                }
                match prev {
                    Some(p) => {
                        let more = l.starts_with([' ', '\t']) || p.starts_with([' ', '\t']);
                        if empties == 0 && !more {
                            out.push(' ');
                        } else {
                            let n = if more { empties + 1 } else { empties };
                            out.push_str(&"\n".repeat(n));
                        }
                    }
                    None => out.push_str(&"\n".repeat(empties)),
                }
                out.push_str(l);
                prev = Some(l);
                empties = 0;
            }
        } else {
            out = body.join("\n");
        }
        if !body.is_empty() {
            match chomp {
                '-' => {}
                '+' => {
                    out.push('\n');
                    for _ in 0..trailing {
                        out.push('\n');
                    }
                }
                _ => out.push('\n'),
            }
        } else if chomp == '+' {
            for _ in 0..trailing {
                out.push('\n');
            }
        }
        Ok(out)
    }

    /// A flow collection, `[...]` or `{...}`, over any number of lines.
    fn flow(&mut self) -> Result<Json, String> {
        self.depth += 1;
        if self.depth > 400 {
            return self.err("too deeply nested");
        }
        let open = self.peek().unwrap();
        self.pos += 1;
        let close = if open == '[' { ']' } else { '}' };
        let mut items = Vec::new();
        let mut members: Vec<(String, Json)> = Vec::new();
        loop {
            self.skip_all();
            match self.peek() {
                None => return self.err(format!("unterminated `{}`", open)),
                Some(c) if c == close => {
                    self.pos += 1;
                    break;
                }
                _ => {}
            }
            let start = self.pos;
            let key = self.flow_node()?;
            self.skip_all();
            if self.peek() == Some(':')
                && (Self::blank(self.at(1))
                    || matches!(self.at(1), Some(',' | ']' | '}'))
                    || matches!(self.s.get(self.pos.wrapping_sub(1)), Some('"' | '\'')))
            {
                self.pos += 1;
                self.skip_all();
                let value = if matches!(self.peek(), Some(',')) || self.peek() == Some(close) {
                    Json::Null
                } else {
                    self.flow_node()?
                };
                let k = scalar_text(&key);
                if open == '[' {
                    items.push(Json::Obj(vec![(k, value)]));
                } else {
                    members.push((k, value));
                }
            } else if open == '[' {
                items.push(key);
            } else {
                let _ = start;
                members.push((scalar_text(&key), Json::Null));
            }
            self.skip_all();
            match self.peek() {
                Some(',') => self.pos += 1,
                Some(c) if c == close => {}
                Some(c) => return self.err(format!("expected `,` or `{}`, found `{}`", close, c)),
                None => return self.err(format!("unterminated `{}`", open)),
            }
        }
        self.depth -= 1;
        Ok(if open == '[' {
            Json::Arr(items)
        } else {
            Json::Obj(members)
        })
    }

    fn flow_node(&mut self) -> Result<Json, String> {
        let mut anchor = None;
        let mut tag = None;
        loop {
            match self.peek() {
                Some('&') => {
                    self.pos += 1;
                    anchor = Some(self.word());
                }
                Some('!') => tag = Some(self.word()),
                _ => break,
            }
            self.skip_all();
        }
        let v = match self.peek() {
            Some('[') | Some('{') => self.flow()?,
            Some('*') => {
                self.pos += 1;
                let name = self.word();
                match self.anchors.get(&name) {
                    Some(v) => v.clone(),
                    None => return self.err(format!("unknown alias `*{}`", name)),
                }
            }
            Some('"') => Json::Str(self.double_quoted()?),
            Some('\'') => Json::Str(self.single_quoted()?),
            _ => {
                let mut out = self.plain_line(true);
                // continued on the next lines
                loop {
                    let save = self.pos;
                    if !self.skip_all() {
                        self.pos = save;
                        break;
                    }
                    let line = self.plain_line(true);
                    if line.is_empty() {
                        self.pos = save;
                        break;
                    }
                    out.push(' ');
                    out.push_str(&line);
                }
                if out.is_empty() {
                    return self.err(format!(
                        "unexpected `{}`",
                        self.peek().map(String::from).unwrap_or_default()
                    ));
                }
                self.resolve(Scalar::Plain(out), tag.as_deref())
            }
        };
        if let Some(a) = anchor {
            self.anchors.insert(a, v.clone());
        }
        Ok(v)
    }
}

/// A scalar as a mapping key.
fn scalar_text(v: &Json) -> String {
    match v {
        Json::Str(s) => s.clone(),
        Json::Null => "null".into(),
        Json::Bool(b) => b.to_string(),
        Json::Num(_) => v.to_string(),
        other => other.to_string(),
    }
}

/// A plain scalar by the core schema.
fn plain_value(t: &str) -> Json {
    match t {
        "" | "~" | "null" | "Null" | "NULL" => return Json::Null,
        "true" | "True" | "TRUE" => return Json::Bool(true),
        "false" | "False" | "FALSE" => return Json::Bool(false),
        ".inf" | ".Inf" | ".INF" | "+.inf" | "+.Inf" | "+.INF" => return Json::Num(f64::INFINITY),
        "-.inf" | "-.Inf" | "-.INF" => return Json::Num(f64::NEG_INFINITY),
        ".nan" | ".NaN" | ".NAN" => return Json::Num(f64::NAN),
        _ => {}
    }
    let digits = |s: &str, radix: u32| !s.is_empty() && s.chars().all(|c| c.is_digit(radix));
    if let Some(h) = t.strip_prefix("0x") {
        if digits(h, 16) {
            if let Ok(n) = u64::from_str_radix(h, 16) {
                return Json::Num(n as f64);
            }
        }
    }
    if let Some(o) = t.strip_prefix("0o") {
        if digits(o, 8) {
            if let Ok(n) = u64::from_str_radix(o, 8) {
                return Json::Num(n as f64);
            }
        }
    }
    let body = t.strip_prefix(['-', '+']).unwrap_or(t);
    if digits(body, 10) {
        if let Ok(n) = t.parse::<f64>() {
            return Json::Num(n);
        }
    }
    // [-+]? ( \. [0-9]+ | [0-9]+ ( \. [0-9]* )? ) ( [eE] [-+]? [0-9]+ )?
    let (mantissa, exp) = match body.find(['e', 'E']) {
        Some(i) => (&body[..i], Some(&body[i + 1..])),
        None => (body, None),
    };
    let mant_ok = match mantissa.split_once('.') {
        Some((a, b)) => {
            (a.is_empty() && digits(b, 10)) || (digits(a, 10) && (b.is_empty() || digits(b, 10)))
        }
        None => digits(mantissa, 10),
    };
    let exp_ok = exp.is_none_or(|e| digits(e.strip_prefix(['-', '+']).unwrap_or(e), 10));
    if mant_ok && exp_ok && (mantissa.contains('.') || exp.is_some()) {
        if let Ok(n) = t.parse::<f64>() {
            return Json::Num(n);
        }
    }
    Json::Str(t.to_string())
}

#[cfg(test)]
mod tests {
    use super::*;

    fn y(s: &str) -> Json {
        parse(s).unwrap_or_else(|e| panic!("{}: {}", e, s))
    }

    fn j(s: &str) -> Json {
        Json::parse(s).unwrap()
    }

    #[test]
    fn block_collections() {
        assert_eq!(
            y("a: 1\nb:\n  c: x y\n  d: [1, two]\ne:\n- 1\n- k: v\n  l: w\n"),
            j(r#"{"a":1,"b":{"c":"x y","d":[1,"two"]},"e":[1,{"k":"v","l":"w"}]}"#)
        );
        assert_eq!(y("- - a\n  - b\n- c\n"), j(r#"[["a","b"],"c"]"#));
        assert_eq!(
            y("x:\n  a:\n  - 1\n  - 2\n  b: 3\ny: 4\n"),
            j(r#"{"x":{"a":[1,2],"b":3},"y":4}"#)
        );
        assert_eq!(
            y("--- # doc\nx: # comment\n  y: 2 # more\n...\n"),
            j(r#"{"x":{"y":2}}"#)
        );
        assert_eq!(
            y("'200':\n  ok: true\n404: {}\n"),
            j(r#"{"200":{"ok":true},"404":{}}"#)
        );
        assert_eq!(y("a:\nb: ~\n"), j(r#"{"a":null,"b":null}"#));
    }

    #[test]
    fn scalars() {
        assert_eq!(
            y("[1, -2.5, 0x1f, 1e3, .inf, true, null, 3.0.1, '1', \"a\\tb\\u00e9\", x: y]"),
            j(r#"[1,-2.5,31,1000,1e999,true,null,"3.0.1","1","a\tbé",{"x":"y"}]"#)
        );
        assert_eq!(
            y("a: 'it''s\n  here'\nb: \"one\n\n  two\"\nc: plain\n  continued\n"),
            j(r#"{"a":"it's here","b":"one\ntwo","c":"plain continued"}"#)
        );
        assert_eq!(
            y("u: http://x.y/z#a\nt: a #b\n"),
            j(r#"{"u":"http://x.y/z#a","t":"a"}"#)
        );
        assert_eq!(y("v: !!str 1.0\n"), j(r#"{"v":"1.0"}"#));
    }

    #[test]
    fn block_scalars() {
        assert_eq!(
            y("a: |\n  line 1\n    indented\n  line 3\nb: >\n  folded\n  text\n\n  para\nc: |-\n  no newline\nd: |+\n  keep\n\ne: x\n"),
            j(r#"{"a":"line 1\n  indented\nline 3\n","b":"folded text\npara\n","c":"no newline","d":"keep\n\n","e":"x"}"#)
        );
        assert_eq!(y("- |\n  a\n- b\n"), j(r#"["a\n","b"]"#));
    }

    #[test]
    fn flow_over_lines() {
        assert_eq!(
            y("a: {x: 1,\n  y: [a,\n     b]}\nb: [\n  {c: d}\n]\n"),
            j(r#"{"a":{"x":1,"y":["a","b"]},"b":[{"c":"d"}]}"#)
        );
    }

    #[test]
    fn anchors() {
        assert_eq!(
            y("base: &b\n  x: 1\n  y: 2\nother:\n  <<: *b\n  y: 3\nlist: [*b]\ns: &s hi\nt: *s\n"),
            j(
                r#"{"base":{"x":1,"y":2},"other":{"x":1,"y":3},"list":[{"x":1,"y":2}],"s":"hi","t":"hi"}"#
            )
        );
    }

    #[test]
    fn errors() {
        assert!(parse("a: 1\n b: 2\n").is_err());
        assert!(parse("a: *nope\n").is_err());
        assert!(parse("a: 1\n---\nb: 2\n").is_err());
        assert!(parse("? a\n: b\n").is_err());
        assert!(parse("a: \"open\n").is_err());
    }

    /// What `fwp openapi --yaml` writes reads back as the same document.
    #[test]
    fn reads_what_openapi_writes() {
        let doc = j(
            r##"{"openapi":"3.1.0","info":{"title":"t: x","version":"1.0","description":"line one\nline two\n"},"paths":{"/a/{id}":{"get":{"parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"integer","minimum":-5,"maximum":1.5}}],"responses":{"200":{"description":"","content":{"application/json":{"schema":{"$ref":"#/components/schemas/A"}}}}}}}},"components":{"schemas":{"A":{"type":"object","properties":{"x":{"enum":["true","null","1","- a","#"]},"e":{},"l":[]}}}}}"##,
        );
        let text = crate::openapi::yaml(&doc);
        assert_eq!(parse(&text).unwrap(), doc, "{}", text);
    }
}
