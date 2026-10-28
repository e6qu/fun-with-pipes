//! Raw interpreter oracles, tracked effects, and bounded-stack traversal for
//! direct consumers. Golden suites separately cover ownership checks and reuse.
use fwp::driver::check_source;
use std::path::Path;
use std::process::Command;

#[test]
fn consumers_and_projections_match_the_raw_interpreter() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/run");
    for name in ["iteration_consumers", "make_projections"] {
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(root.join(format!("{name}.fwp")))
            .output()
            .unwrap();
        assert!(output.status.success(), "{name}: {output:?}");
        assert!(output.stderr.is_empty(), "{name}: {output:?}");
        assert_eq!(
            output.stdout,
            std::fs::read(root.join(format!("{name}.out"))).unwrap(),
            "{name}"
        );
    }
}

#[test]
fn consumer_callbacks_cannot_hide_io() {
    for source in [
        "bad : Iterator[String] -> ()\nbad = iter.each print\n",
        "bad : Iterator[String] -> String\nbad = iter.fold (curry (.1 | tap print)) \"\"\n",
        "bad : Iterator[String] -> Option[String]\nbad = iter.find (tap print | string.length | eq 0)\n",
        "bad : List[String] -> String\nbad = fold-until (curry (.1 | tap print | Again)) \"\"\n",
        "bad : List[String] -> (List[String], String)\nbad = map-accum (curry (.1 | tap print | both id id)) \"\"\n",
    ] {
        let error = check_source("consumer-effects.fwp", source, None)
            .err()
            .expect("accepted unhandled IO");
        assert!(error.rendered.contains("IO"), "{}", error.rendered);
    }
}

#[test]
fn long_consumers_do_not_accumulate_stack_frames() {
    let dir = std::env::temp_dir().join(format!("fwp-iteration-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("long.fwp");
    std::fs::write(
        &source,
        r#"
main = [
    0 | iter.count-from | iter.take 20000 | iter.fold add 0 | echo,
    0 | iter.count-from | iter.find (eq 20000) | echo,
    0 | iter.count-from | iter.take 20000 | run-state 0 (iter.each (const (add 1) | modify)) | echo,
    range 0 20000 | fold-until (add | flip compose Again) 0 | echo,
    range 0 20000 | map-accum (add | flip compose (both id id)) 0 | both (.0 | length) .1 | echo,
] | ignore
"#,
    )
    .unwrap();
    let expected = b"199990000\nSome 20000\n((), 20000)\n199990000\n(20000, 199990000)\n";
    for raw in [true, false] {
        let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
        command.arg("run");
        if raw {
            command.arg("--interp").env("FWP_NO_OPT", "1");
        }
        let output = command.arg(&source).output().unwrap();
        assert!(output.status.success(), "raw={raw}: {output:?}");
        assert!(output.stderr.is_empty(), "raw={raw}: {output:?}");
        assert_eq!(output.stdout, expected, "raw={raw}");
    }
    std::fs::remove_dir_all(dir).unwrap();
}
