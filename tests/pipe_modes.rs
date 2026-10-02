//! The type checker decides, per `|`, whether it means application or
//! composition.

use fwp::ast::ExprKind;
use fwp::driver::check_source;
use fwp::infer::PipeMode;

fn modes(src: &str) -> Vec<PipeMode> {
    let c = check_source("t.fwp", src, None).unwrap_or_else(|f| panic!("{}", f.rendered));
    let mut found = Vec::new();
    for b in &c.env.bindings {
        if b.module != "main" {
            continue;
        }
        let mut stack = vec![&b.body];
        while let Some(e) = stack.pop() {
            match &e.kind {
                ExprKind::Pipe(l, r) => {
                    found.push((e.span.col, c.typed.pipe_modes[&e.id]));
                    stack.push(l);
                    stack.push(r);
                }
                ExprKind::App(f, args) => {
                    stack.push(f);
                    stack.extend(args.iter());
                }
                ExprKind::Match(arms) => stack.extend(arms.iter().map(|a| &a.body)),
                _ => {}
            }
        }
    }
    found.sort_by_key(|(c, _)| *c);
    found.into_iter().map(|(_, m)| m).collect()
}

#[test]
fn value_on_the_left_applies() {
    assert_eq!(modes("x = 1 | add 2"), vec![PipeMode::Apply]);
}

#[test]
fn function_on_the_left_composes() {
    assert_eq!(modes("f = add 1 | add 2"), vec![PipeMode::Compose]);
}

#[test]
fn mixed_pipeline() {
    // (([1] | map (add 1 | add 2)) | length): apply, compose, apply
    assert_eq!(
        modes("n = [1] | map (add 1 | add 2) | length"),
        vec![PipeMode::Apply, PipeMode::Compose, PipeMode::Apply]
    );
}

#[test]
fn deferred_until_known() {
    let src = "rec spin = match\n    0 -> 0\n    _ -> spin | id\n";
    assert_eq!(modes(src), vec![PipeMode::Compose]);
}
