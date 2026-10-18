//! Native terminal editing is supplied by Rustyline; the session engine has no
//! terminal dependency and is exercised by scripted sessions on every platform.
use super::*;
use rustyline::completion::{Completer, Pair};
use rustyline::error::ReadlineError;
use rustyline::highlight::{CmdKind, Highlighter, MatchingBracketHighlighter};
use rustyline::hint::Hinter;
use rustyline::history::DefaultHistory;
use rustyline::validate::{ValidationContext, ValidationResult, Validator};
use rustyline::{CompletionType, Config, Context, Editor, Helper};
use std::borrow::Cow;

struct TerminalSignals;
impl Drop for TerminalSignals {
    fn drop(&mut self) {
        TERMINAL_ACTIVE.store(false, Ordering::Relaxed);
        INTERRUPTED.store(false, Ordering::Relaxed);
    }
}

struct InputHelper {
    names: Vec<String>,
    brackets: MatchingBracketHighlighter,
    paste: bool,
}
impl Helper for InputHelper {}
impl Hinter for InputHelper {
    type Hint = String;
}
impl Completer for InputHelper {
    type Candidate = Pair;
    fn complete(
        &self,
        line: &str,
        pos: usize,
        _context: &Context<'_>,
    ) -> rustyline::Result<(usize, Vec<Pair>)> {
        let start = line[..pos]
            .rfind(|c: char| !(c.is_alphanumeric() || matches!(c, '_' | '-' | '.' | ':')))
            .map_or(0, |i| i + line[i..].chars().next().unwrap().len_utf8());
        let prefix = &line[start..pos];
        let commands = [
            ":help", ":type", ":names", ":history", ":load", ":save", ":time", ":paste", ":reset",
            ":quit",
        ];
        let candidates = self
            .names
            .iter()
            .map(String::as_str)
            .chain(commands)
            .filter(|name| name.starts_with(prefix))
            .map(|name| Pair {
                display: name.into(),
                replacement: name.into(),
            })
            .collect();
        Ok((start, candidates))
    }
}
impl Validator for InputHelper {
    fn validate(&self, context: &mut ValidationContext<'_>) -> rustyline::Result<ValidationResult> {
        Ok(
            if !self.paste
                && !context.input().trim_start().starts_with(':')
                && incomplete(context.input())
            {
                ValidationResult::Incomplete
            } else {
                ValidationResult::Valid(None)
            },
        )
    }
}
impl Highlighter for InputHelper {
    fn highlight<'l>(&self, line: &'l str, pos: usize) -> Cow<'l, str> {
        self.brackets.highlight(line, pos)
    }
    fn highlight_char(&self, line: &str, pos: usize, kind: CmdKind) -> bool {
        self.brackets.highlight_char(line, pos, kind)
    }
}

fn history_path() -> Option<PathBuf> {
    if let Some(state) = std::env::var_os("XDG_STATE_HOME") {
        return Some(PathBuf::from(state).join("fwp/repl-history"));
    }
    #[cfg(windows)]
    {
        std::env::var_os("LOCALAPPDATA").map(|p| PathBuf::from(p).join("fwp/repl-history"))
    }
    #[cfg(not(windows))]
    {
        std::env::var_os("HOME").map(|p| PathBuf::from(p).join(".local/state/fwp/repl-history"))
    }
}

pub(super) fn run(
    directory: PathBuf,
    history: Option<PathBuf>,
    no_history: bool,
) -> Result<(), String> {
    ctrlc::set_handler(interrupt_from_signal).map_err(|e| e.to_string())?;
    TERMINAL_ACTIVE.store(true, Ordering::Relaxed);
    let _signals = TerminalSignals;
    let mut session = Session::new(directory)?;
    let config = Config::builder()
        .completion_type(CompletionType::List)
        .max_history_size(1000)
        .map_err(|e| e.to_string())?
        .build();
    let mut editor =
        Editor::<InputHelper, DefaultHistory>::with_config(config).map_err(|e| e.to_string())?;
    editor.set_helper(Some(InputHelper {
        names: session.names.clone(),
        brackets: MatchingBracketHighlighter::new(),
        paste: false,
    }));
    let history = if no_history {
        None
    } else {
        Some(
            history
                .or_else(history_path)
                .ok_or("no history directory; use --history PATH or --no-history")?,
        )
    };
    if let Some(path) = &history {
        match editor.load_history(path) {
            Ok(()) => {}
            Err(ReadlineError::Io(e)) if e.kind() == io::ErrorKind::NotFound => {}
            Err(e) => return Err(format!("{}: {e}", path.display())),
        }
    }
    println!("fwp — interpreted session. :help for commands; Ctrl-D exits.");
    if let Some(path) = &history {
        println!("History: {}", path.display());
    }
    let mut output = io::stdout();
    loop {
        let prompt = format!("In [{}]: ", session.history.len() + 1);
        let mut line = match editor.readline(&prompt) {
            Ok(line) => line,
            Err(ReadlineError::Interrupted) => {
                INTERRUPTED.store(false, Ordering::Relaxed);
                continue;
            }
            Err(ReadlineError::Eof) => break,
            Err(e) => return Err(e.to_string()),
        };
        if line.trim() == ":paste" {
            println!("Enter a block; :end submits it, Ctrl-C discards it.");
            editor.helper_mut().unwrap().paste = true;
            line.clear();
            loop {
                match editor.readline("...: ") {
                    Ok(part) if part.trim() == ":end" => break,
                    Ok(part) => {
                        line.push_str(&part);
                        line.push('\n');
                    }
                    Err(ReadlineError::Interrupted | ReadlineError::Eof) => {
                        line.clear();
                        break;
                    }
                    Err(e) => return Err(e.to_string()),
                }
            }
            editor.helper_mut().unwrap().paste = false;
        }
        if line.trim().is_empty() {
            continue;
        }
        editor
            .add_history_entry(line.as_str())
            .map_err(|e| e.to_string())?;
        match command(&mut session, &line, &mut output) {
            Ok(false) => break,
            Ok(true) => {}
            Err(error) => eprintln!("{error}"),
        }
        editor.helper_mut().unwrap().names = session.names.clone();
    }
    if let Some(path) = history {
        if let Some(parent) = path.parent().filter(|p| !p.as_os_str().is_empty()) {
            std::fs::create_dir_all(parent).map_err(|e| e.to_string())?;
        }
        editor
            .append_history(&path)
            .map_err(|e| format!("{}: {e}", path.display()))?;
    }
    Ok(())
}
