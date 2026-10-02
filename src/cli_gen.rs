//! Shell completion scripts (bash, zsh, fish) and a man page for a
//! command-line program, from the same commands as its help
//! (`src/cli.rs`). Both backends print these texts: `prog --completions
//! bash`, `prog --man`.

use std::fmt::Write as _;

use crate::cli::{self, Command, FlagKind, PathKind, PosKind};

/// The shells there are completion scripts for.
pub const SHELLS: [&str; 3] = ["bash", "zsh", "fish"];

/// What a value completes to.
#[derive(Clone, Debug, PartialEq)]
enum Action {
    Nothing,
    Files,
    Dirs,
    Words(Vec<String>),
}

fn action(name: &str, ty: &crate::ir::MT, choices: &Option<Vec<String>>) -> Action {
    if let Some(cs) = choices {
        return Action::Words(cs.clone());
    }
    match cli::path_kind(name, ty) {
        Some(PathKind::File) => Action::Files,
        Some(PathKind::Dir) => Action::Dirs,
        None => Action::Nothing,
    }
}

/// A flag as completions see it.
struct CFlag {
    long: String,
    short: Option<char>,
    value: Option<(String, Action)>,
    repeat: bool,
    doc: String,
}

/// A positional argument as completions see it.
struct CArg {
    name: String,
    optional: bool,
    rest: bool,
    action: Action,
}

fn cflags(c: &Command) -> Vec<CFlag> {
    let mut out = Vec::new();
    if let Some(o) = &c.options {
        for f in &o.flags {
            let value = (f.kind != FlagKind::Switch).then(|| {
                let a = action(&f.placeholder, &f.value_ty, &f.choices);
                // a field named `file` or `dir` is a path too
                let a = match a {
                    Action::Nothing => action(&f.name, &f.value_ty, &None),
                    a => a,
                };
                (f.placeholder.clone(), a)
            });
            out.push(CFlag {
                long: f.name.clone(),
                short: f.short,
                value,
                repeat: f.kind == FlagKind::Repeated,
                doc: f.doc.clone(),
            });
        }
    }
    let short_h = out.iter().any(|f| f.short == Some('h'));
    if !cli::has_flag(c, "help") {
        out.push(CFlag {
            long: "help".into(),
            short: (!short_h).then_some('h'),
            value: None,
            repeat: false,
            doc: "show this help".into(),
        });
    }
    if c.version.is_some() && !cli::has_flag(c, "version") {
        out.push(CFlag {
            long: "version".into(),
            short: None,
            value: None,
            repeat: false,
            doc: "show the version".into(),
        });
    }
    out
}

fn cargs(c: &Command) -> Vec<CArg> {
    c.positional
        .iter()
        .map(|p| CArg {
            name: p.name.clone(),
            optional: p.kind != PosKind::Required,
            rest: p.kind == PosKind::Variadic,
            action: action(&p.name, &p.value_ty, &p.choices),
        })
        .collect()
}

/// A name usable in a shell function name.
fn ident(name: &str) -> String {
    name.chars()
        .map(|c| if c.is_ascii_alphanumeric() { c } else { '_' })
        .collect()
}

/// Single-quoted for a POSIX shell (and zsh).
fn sq(s: &str) -> String {
    format!("'{}'", s.replace('\'', "'\\''"))
}

/// Single-quoted for fish.
fn fish_q(s: &str) -> String {
    format!("'{}'", s.replace('\\', "\\\\").replace('\'', "\\'"))
}

/// The program's name: the first word of a command's name.
fn program_name(cmds: &[Command], multi: Option<&str>) -> String {
    match multi {
        Some(n) => n.to_string(),
        None => cmds.first().map(|c| c.name.clone()).unwrap_or_default(),
    }
}

/// The completion script for `shell`, or `None` for an unknown shell.
/// `multi` is the name of a multi-command program.
pub fn completions(shell: &str, cmds: &[Command], multi: Option<&str>) -> Option<String> {
    let name = program_name(cmds, multi);
    Some(match shell {
        "bash" => bash(&name, cmds, multi.is_some()),
        "zsh" => zsh(&name, cmds, multi.is_some()),
        "fish" => fish(&name, cmds, multi.is_some()),
        _ => return None,
    })
}

// ------------------------------------------------------------------- bash

fn bash_reply(a: &Action) -> String {
    match a {
        Action::Nothing => ":".into(),
        Action::Files => "COMPREPLY=($(compgen -f -- \"$cur\"))".into(),
        Action::Dirs => "COMPREPLY=($(compgen -d -- \"$cur\"))".into(),
        Action::Words(ws) => format!(
            "COMPREPLY=($(compgen -W {} -- \"$cur\"))",
            sq(&ws.join(" "))
        ),
    }
}

/// The body of one command: completing its flags, their values and its
/// arguments, from word `start`.
fn bash_command(out: &mut String, fname: &str, c: &Command, start: usize, indent: &str) {
    let flags = cflags(c);
    let args = cargs(c);
    let mut valued = Vec::new();
    let mut words = Vec::new();
    let mut cases = String::new();
    for f in &flags {
        let mut forms = vec![format!("--{}", f.long)];
        if let Some(s) = f.short {
            forms.push(format!("-{}", s));
        }
        words.extend(forms.iter().cloned());
        if let Some((_, a)) = &f.value {
            valued.extend(forms.iter().cloned());
            let _ = writeln!(
                cases,
                "{i}    {}) {}; return ;;",
                forms.join("|"),
                bash_reply(a),
                i = indent
            );
        }
    }
    if !cases.is_empty() {
        let _ = write!(out, "{i}case $prev in\n{}{i}esac\n", cases, i = indent);
    }
    let _ = write!(
        out,
        "{i}if [[ $cur == -* ]]; then\n{i}    COMPREPLY=($(compgen -W {} -- \"$cur\"))\n{i}    return\n{i}fi\n",
        sq(&words.join(" ")),
        i = indent
    );
    if args.iter().all(|a| a.action == Action::Nothing) {
        return;
    }
    let _ = writeln!(
        out,
        "{}{}_npos {} {}",
        indent,
        fname,
        start,
        sq(&valued.join(" "))
    );
    let _ = writeln!(out, "{}case $n in", indent);
    for (i, a) in args.iter().enumerate() {
        if a.action == Action::Nothing {
            continue;
        }
        let pat = if a.rest {
            "*".to_string()
        } else {
            i.to_string()
        };
        let _ = writeln!(out, "{}    {}) {} ;;", indent, pat, bash_reply(&a.action));
    }
    let _ = writeln!(out, "{}esac", indent);
}

fn bash(name: &str, cmds: &[Command], multi: bool) -> String {
    let f = format!("_fwp_{}", ident(name));
    let mut s = format!(
        "# bash completion for {name}, generated by fwp. Load it with\n#   source <({name} --completions bash)\n# or save it as ~/.local/share/bash-completion/completions/{name}\n\n"
    );
    // the number of positional arguments before the current word, from
    // word $1; $2 lists the flags that take a value
    let _ = write!(
        s,
        r#"{f}_npos() {{
    local i w dd=0
    n=0
    for ((i = $1; i < COMP_CWORD; i++)); do
        w=${{COMP_WORDS[i]}}
        if ((dd)); then
            ((n++))
            continue
        fi
        case $w in
        --) dd=1 ;;
        =) ((i++)) ;;
        --*=*) ;;
        -?*)
            if [[ " $2 " == *" $w "* ]]; then
                ((i++))
                [[ ${{COMP_WORDS[i]}} == = ]] && ((i++))
            fi
            ;;
        *) ((n++)) ;;
        esac
    done
}}

{f}() {{
    local cur=${{COMP_WORDS[COMP_CWORD]}} prev= n=0
    ((COMP_CWORD > 0)) && prev=${{COMP_WORDS[COMP_CWORD - 1]}}
    # `--name=value` is three words
    if [[ $prev == = ]] && ((COMP_CWORD > 1)); then
        prev=${{COMP_WORDS[COMP_CWORD - 2]}}
    elif [[ $cur == = ]]; then
        prev=${{COMP_WORDS[COMP_CWORD - 1]}}
        cur=
    fi
    COMPREPLY=()
    if [[ ${{COMP_WORDS[1]}} == --completions ]]; then
        ((COMP_CWORD == 2)) && COMPREPLY=($(compgen -W 'bash zsh fish' -- "$cur"))
        return
    fi
"#
    );
    if multi {
        let mut names: Vec<String> = cmds.iter().map(|c| c.command.clone()).collect();
        let mut top = names.clone();
        if !names.iter().any(|n| n == "help") {
            top.push("help".into());
        }
        names.sort();
        let mut opts = vec!["--help", "-h"];
        if cmds.first().is_some_and(|c| c.version.is_some()) {
            opts.push("--version");
        }
        opts.extend(["--completions", "--man"]);
        let _ = write!(
            s,
            "    if ((COMP_CWORD == 1)); then\n        if [[ $cur == -* ]]; then\n            COMPREPLY=($(compgen -W {} -- \"$cur\"))\n        else\n            COMPREPLY=($(compgen -W {} -- \"$cur\"))\n        fi\n        return\n    fi\n    case ${{COMP_WORDS[1]}} in\n",
            sq(&opts.join(" ")),
            sq(&top.join(" "))
        );
        if !cmds.iter().any(|c| c.command == "help") {
            let _ = write!(
                s,
                "    help)\n        ((COMP_CWORD == 2)) && COMPREPLY=($(compgen -W {} -- \"$cur\"))\n        ;;\n",
                sq(&names.join(" "))
            );
        }
        for c in cmds {
            let _ = writeln!(s, "    {})", sq(&c.command));
            bash_command(&mut s, &f, c, 2, "        ");
            s.push_str("        ;;\n");
        }
        s.push_str("    esac\n");
    } else if let Some(c) = cmds.first() {
        bash_command(&mut s, &f, c, 1, "    ");
    }
    let _ = write!(s, "}}\n\ncomplete -o filenames -F {} {}\n", f, sq(name));
    s
}

// -------------------------------------------------------------------- zsh

/// Text in an `_arguments` description: no brackets, quoted.
fn zsh_desc(s: &str) -> String {
    s.replace('[', "(").replace(']', ")")
}

fn zsh_action(a: &Action) -> String {
    match a {
        Action::Nothing => String::new(),
        Action::Files => "_files".into(),
        Action::Dirs => "_files -/".into(),
        Action::Words(ws) => format!("({})", ws.join(" ")),
    }
}

fn zsh_message(s: &str) -> String {
    s.replace(':', "\\:")
}

fn zsh_specs(c: &Command) -> Vec<String> {
    let mut specs = Vec::new();
    for f in cflags(c) {
        let desc = format!("[{}]", zsh_desc(&f.doc));
        let value = match &f.value {
            Some((p, a)) => format!(":{}:{}", zsh_message(p), zsh_action(a)),
            None => String::new(),
        };
        let (sf, lf) = match f.value {
            Some(_) => ("+", "="),
            None => ("", ""),
        };
        let special = matches!(f.long.as_str(), "help" | "version") && f.value.is_none();
        let spec = match (f.short, f.repeat) {
            (Some(s), false) => {
                let excl = if special {
                    "(- *)".to_string()
                } else {
                    format!("(-{} --{})", s, f.long)
                };
                format!(
                    "{}{{-{}{},--{}{}}}{}",
                    sq(&excl),
                    s,
                    sf,
                    f.long,
                    lf,
                    sq(&format!("{}{}", desc, value))
                )
            }
            (Some(s), true) => format!(
                "'*'{{-{}{},--{}{}}}{}",
                s,
                sf,
                f.long,
                lf,
                sq(&format!("{}{}", desc, value))
            ),
            (None, rep) => {
                let excl = if special { "(- *)" } else { "" };
                sq(&format!(
                    "{}{}--{}{}{}{}",
                    excl,
                    if rep { "*" } else { "" },
                    f.long,
                    lf,
                    desc,
                    value
                ))
            }
        };
        specs.push(spec);
    }
    for (i, a) in cargs(c).iter().enumerate() {
        let msg = zsh_message(&a.name);
        let act = zsh_action(&a.action);
        specs.push(sq(&if a.rest {
            format!("*:{}:{}", msg, act)
        } else if a.optional {
            format!("{}::{}:{}", i + 1, msg, act)
        } else {
            format!("{}:{}:{}", i + 1, msg, act)
        }));
    }
    specs
}

fn zsh_arguments(out: &mut String, c: &Command, indent: &str) {
    let _ = write!(out, "{}_arguments -s -S", indent);
    for sp in zsh_specs(c) {
        let _ = write!(out, " \\\n{}    {}", indent, sp);
    }
    out.push('\n');
}

fn zsh(name: &str, cmds: &[Command], multi: bool) -> String {
    let f = format!("_fwp_{}", ident(name));
    let mut s = format!(
        "#compdef {name}\n# zsh completion for {name}, generated by fwp. Load it with\n#   source <({name} --completions zsh)\n# after compinit, or save it as _{name} in a directory of $fpath\n\n"
    );
    let _ = writeln!(s, "{}() {{", f);
    if multi {
        s.push_str("    local -a commands\n    commands=(\n");
        for c in cmds {
            let _ = writeln!(
                s,
                "        {}",
                sq(&format!("{}:{}", c.command.replace(':', "\\:"), c.summary))
            );
        }
        if !cmds.iter().any(|c| c.command == "help") {
            s.push_str("        'help:show the help of a command'\n");
        }
        s.push_str("    )\n");
        let mut opts = vec!["--help", "-h"];
        if cmds.first().is_some_and(|c| c.version.is_some()) {
            opts.push("--version");
        }
        opts.extend(["--completions", "--man"]);
        let _ = write!(
            s,
            "    if ((CURRENT == 2)); then\n        if [[ $PREFIX == -* ]]; then\n            compadd -- {}\n        else\n            _describe -t commands {} commands\n        fi\n        return\n    fi\n",
            opts.join(" "),
            sq(&format!("{} command", name))
        );
        s.push_str(
            "    local cmd=$words[2]\n    shift words\n    ((CURRENT--))\n    case $cmd in\n",
        );
        s.push_str("    --completions) ((CURRENT == 2)) && compadd -- bash zsh fish ;;\n");
        if !cmds.iter().any(|c| c.command == "help") {
            let _ = writeln!(
                s,
                "    help) ((CURRENT == 2)) && _describe -t commands {} commands ;;",
                sq(&format!("{} command", name))
            );
        }
        for c in cmds {
            let _ = writeln!(s, "    {})", sq(&c.command));
            zsh_arguments(&mut s, c, "        ");
            s.push_str("        ;;\n");
        }
        s.push_str("    esac\n");
    } else if let Some(c) = cmds.first() {
        s.push_str("    if [[ $words[2] == --completions ]]; then\n        ((CURRENT == 3)) && compadd -- bash zsh fish\n        return\n    fi\n");
        zsh_arguments(&mut s, c, "    ");
    }
    let _ = write!(
        s,
        "}}\n\nif [[ $zsh_eval_context[-1] == loadautofunc ]]; then\n    {f} \"$@\"\nelse\n    compdef {f} {}\nfi\n",
        sq(name)
    );
    s
}

// ------------------------------------------------------------------- fish

fn fish_command(out: &mut String, name: &str, c: &Command, cond: &str) {
    let base = format!("complete -c {}{}", fish_q(name), cond);
    for f in cflags(c) {
        let mut line = base.clone();
        if let Some(s) = f.short {
            let _ = write!(line, " -s {}", s);
        }
        let _ = write!(line, " -l {}", f.long);
        match &f.value {
            Some((_, Action::Files)) => line.push_str(" -r -F"),
            Some((_, Action::Dirs)) => line.push_str(" -x -a '(__fish_complete_directories)'"),
            Some((_, Action::Words(ws))) => {
                let _ = write!(line, " -x -a {}", fish_q(&ws.join(" ")));
            }
            Some((_, Action::Nothing)) => line.push_str(" -x"),
            None => {}
        }
        if !f.doc.is_empty() {
            let _ = write!(line, " -d {}", fish_q(&f.doc));
        }
        out.push_str(&line);
        out.push('\n');
    }
    // arguments: files, directories or the values of enumerations
    let args = cargs(c);
    if args.iter().any(|a| a.action == Action::Files) {
        let _ = writeln!(out, "{} -F", base);
    }
    if args.iter().any(|a| a.action == Action::Dirs) {
        let _ = writeln!(out, "{} -a '(__fish_complete_directories)'", base);
    }
    for a in &args {
        if let Action::Words(ws) = &a.action {
            let _ = writeln!(out, "{} -a {}", base, fish_q(&ws.join(" ")));
        }
    }
}

fn fish(name: &str, cmds: &[Command], multi: bool) -> String {
    let mut s = format!(
        "# fish completion for {name}, generated by fwp. Load it with\n#   {name} --completions fish | source\n# or save it as ~/.config/fish/completions/{name}.fish\n\n"
    );
    let q = fish_q(name);
    let _ = writeln!(s, "complete -c {} -f", q);
    if multi {
        let top = " -n __fish_use_subcommand";
        for c in cmds {
            let _ = write!(s, "complete -c {}{} -a {}", q, top, fish_q(&c.command));
            if !c.summary.is_empty() {
                let _ = write!(s, " -d {}", fish_q(&c.summary));
            }
            s.push('\n');
        }
        let mut names: Vec<String> = cmds.iter().map(|c| c.command.clone()).collect();
        if !cmds.iter().any(|c| c.command == "help") {
            let _ = writeln!(
                s,
                "complete -c {}{} -a help -d 'show the help of a command'",
                q, top
            );
            let _ = writeln!(
                s,
                "complete -c {} -n '__fish_seen_subcommand_from help' -a {}",
                q,
                fish_q(&names.join(" "))
            );
        }
        let _ = writeln!(
            s,
            "complete -c {}{} -s h -l help -d 'show this help'",
            q, top
        );
        if cmds.first().is_some_and(|c| c.version.is_some()) {
            let _ = writeln!(
                s,
                "complete -c {}{} -l version -d 'show the version'",
                q, top
            );
        }
        let _ = writeln!(
            s,
            "complete -c {}{} -l completions -x -a 'bash zsh fish' -d 'print a completion script'",
            q, top
        );
        let _ = writeln!(s, "complete -c {}{} -l man -d 'print a man page'", q, top);
        names.sort();
        for c in cmds {
            let cond = format!(
                " -n {}",
                fish_q(&format!("__fish_seen_subcommand_from {}", c.command))
            );
            fish_command(&mut s, name, c, &cond);
        }
    } else if let Some(c) = cmds.first() {
        fish_command(&mut s, name, c, "");
    }
    s
}

// -------------------------------------------------------------------- man

/// Text for roff: backslashes, dashes and leading dots escaped.
fn roff(s: &str) -> String {
    let t = s.replace('\\', "\\e").replace('-', "\\-");
    if t.starts_with(['.', '\'']) {
        format!("\\&{}", t)
    } else {
        t
    }
}

/// Paragraphs of a description, blank lines separating them.
fn roff_lines(out: &mut String, lines: &[String]) {
    let mut blank = false;
    for l in lines {
        if l.trim().is_empty() {
            blank = true;
            continue;
        }
        if blank {
            out.push_str(".PP\n");
            blank = false;
        }
        out.push_str(&roff(l.trim_end()));
        out.push('\n');
    }
}

fn roff_rows(out: &mut String, rows: &[(String, String)]) {
    for (l, r) in rows {
        let _ = write!(out, ".TP\n\\fB{}\\fR\n", roff(l.trim()));
        if !r.is_empty() {
            out.push_str(&roff(r));
            out.push('\n');
        }
    }
}

fn roff_command(out: &mut String, c: &Command) {
    if !c.positional.is_empty() {
        out.push_str(".PP\nArguments:\n");
        roff_rows(out, &cli::argument_rows(c));
    }
    let mut rows = cli::flag_rows(c);
    rows.extend(cli::builtin_rows(c));
    out.push_str(".PP\nOptions:\n");
    roff_rows(out, &rows);
}

/// A man page (section 1) for the program.
pub fn man_page(cmds: &[Command], multi: Option<&str>, module: &[String]) -> String {
    let name = program_name(cmds, multi);
    let version = cmds
        .first()
        .and_then(|c| c.version.clone())
        .map(|v| format!("{} {}", name, v))
        .unwrap_or_else(|| name.clone());
    let mut s = format!(
        ".TH {} 1 \"\" \"{}\" \"User Commands\"\n",
        roff(&name.to_uppercase()),
        roff(&version)
    );
    let description: Vec<String> = match (multi, cmds.first()) {
        (Some(_), _) => module.to_vec(),
        (None, Some(c)) => c.doc.clone(),
        _ => Vec::new(),
    };
    let summary = cli::summary(&description);
    let _ = write!(s, ".SH NAME\n{}", roff(&name));
    if !summary.is_empty() {
        let _ = write!(s, " \\- {}", roff(summary.trim_end_matches('.')));
    }
    s.push_str("\n.SH SYNOPSIS\n");
    if multi.is_some() {
        let _ = writeln!(
            s,
            "\\fB{}\\fR \\fIcommand\\fR [\\fIarguments\\fR...]",
            roff(&name)
        );
    } else if let Some(c) = cmds.first() {
        let _ = writeln!(s, "{}", roff(&cli::synopsis(c)));
    }
    if !description.is_empty() {
        s.push_str(".SH DESCRIPTION\n");
        roff_lines(&mut s, &description);
    }
    if multi.is_some() {
        s.push_str(".SH COMMANDS\n");
        for c in cmds {
            let _ = writeln!(s, ".SS {}", roff(&cli::synopsis(c)));
            roff_lines(&mut s, &c.doc);
            roff_command(&mut s, c);
        }
        s.push_str(".SH OPTIONS\n");
        roff_rows(&mut s, &cli::program_option_rows(cmds));
    } else if let Some(c) = cmds.first() {
        s.push_str(".SH OPTIONS\n");
        roff_command(&mut s, c);
    }
    let mut env: Vec<(String, String)> = Vec::new();
    for c in cmds {
        for (f, var) in c.env_vars() {
            if !env.iter().any(|(v, _)| v == var) {
                let mut text = format!("the default of --{}", f.name);
                if !f.doc.is_empty() {
                    let _ = write!(text, ": {}", f.doc);
                }
                env.push((var.to_string(), text));
            }
        }
    }
    if !env.is_empty() {
        s.push_str(".SH ENVIRONMENT\n");
        roff_rows(&mut s, &env);
    }
    s.push_str(".SH EXIT STATUS\n");
    roff_rows(
        &mut s,
        &[
            ("0".into(), "success".into()),
            ("1".into(), "an error".into()),
            ("2".into(), "a usage error".into()),
            ("3".into(), "input that does not parse".into()),
        ],
    );
    s
}
