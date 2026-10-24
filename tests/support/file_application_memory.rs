//! Observe managed storage, file-read scratch, read/write handles and resident memory.
use std::io::{BufRead, BufReader, Read, Write};
use std::process::{Command, Output, Stdio};

#[path = "process_memory.rs"]
mod process_memory;

// Drain report output while stderr drives the sampling handshake. Large CSV
// and grep results must not block the child before it reaches a checkpoint.
pub fn run_observed(command: &mut Command) -> (Output, String) {
    let mut child = command
        .env("FWP_FILE_APP_RSS", "1")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    let mut stdout = child.stdout.take().unwrap();
    let report = std::thread::spawn(move || {
        let mut bytes = Vec::new();
        stdout.read_to_end(&mut bytes).unwrap();
        bytes
    });
    let mut input = child.stdin.take().unwrap();
    let mut errors = BufReader::new(child.stderr.take().unwrap());
    let mut stderr = Vec::new();
    let mut resident = String::from("phase\tremaining\trss_kib\n");
    loop {
        let mut line = String::new();
        if errors.read_line(&mut line).unwrap() == 0 {
            break;
        }
        let fields: Vec<_> = line.split_whitespace().collect();
        if fields.first() == Some(&"file-memory")
            && fields.len() == 6
            && ["64", "32", "1"].contains(&fields[2])
        {
            let rss = process_memory::process_rss_kib(child.id());
            assert!(rss > 0);
            resident.push_str(&format!("{}\t{}\t{rss}\n", fields[1], fields[2]));
            input.write_all(b"\n").unwrap();
            input.flush().unwrap();
        }
        stderr.extend_from_slice(line.as_bytes());
    }
    drop(input);
    let output = Output {
        status: child.wait().unwrap(),
        stdout: report.join().unwrap(),
        stderr,
    };
    (output, resident)
}
// Preserve both healthy and deliberately broken runs before their assertions.
pub fn save_execution(
    program: &str,
    size: usize,
    variant: &str,
    opt: &str,
    output: &Output,
    resident: &str,
) {
    if let Some(path) = std::env::var_os("FWP_FILE_APPLICATION_ARTIFACTS") {
        let path = std::path::PathBuf::from(path);
        std::fs::create_dir_all(&path).unwrap();
        let label = format!("{program}-{size}-{variant}{opt}");
        std::fs::write(path.join(format!("{label}.stdout")), &output.stdout).unwrap();
        std::fs::write(path.join(format!("{label}.stderr")), &output.stderr).unwrap();
        let status = match output.status.code() {
            Some(code) => code.to_string(),
            None => output.status.to_string(),
        };
        std::fs::write(path.join(format!("{label}.status")), status).unwrap();
        if variant == "measured" {
            std::fs::write(path.join(format!("{label}.rss.tsv")), resident).unwrap();
        }
    }
}
pub fn observe(original: &str) -> String {
    let mut code = original.to_string();
    let marker = "typedef uint64_t V;";
    assert_eq!(code.matches(marker).count(), 1);
    code = code.replace(marker, &format!("{marker}\nstatic int file_app_active;\n#define FILE_APP_OMIT_CLOSE 0\n#define FILE_APP_OMIT_WRITE_CLOSE 0\nstatic uint64_t file_app_opened, file_app_closed, file_app_raw;\n#define FILE_APP_OMIT_RAW_FREE 0"));
    // Record actual successful handle acquisition and closing on each platform.
    for (before, after) in [
        ("DIR *directory=opendir(STR(path)->d);", "DIR *directory=opendir(STR(path)->d); if(directory) file_app_opened++;"),
        ("if (*directory) closedir(*directory);", "if (*directory && (!FILE_APP_OMIT_CLOSE || !file_app_active)) { if(closedir(*directory)) exit(242); file_app_closed++; }"),
        ("HANDLE handle = FindFirstFileW(pattern, &entry);", "HANDLE handle = FindFirstFileW(pattern, &entry); if(handle != INVALID_HANDLE_VALUE) file_app_opened++;"),
        ("if (*handle != INVALID_HANDLE_VALUE) FindClose(*handle);", "if (*handle != INVALID_HANDLE_VALUE && (!FILE_APP_OMIT_CLOSE || !file_app_active)) { if(!FindClose(*handle)) exit(242); file_app_closed++; }"),
    ] {
        assert_eq!(code.matches(before).count(), 1, "{before}");
        code = code.replace(before, after);
    }
    let buffer = "typedef struct { char *d; size_t len, cap; } fwp_buf;";
    assert_eq!(code.matches(buffer).count(), 1);
    code = code.replace(
        buffer,
        &format!("{buffer}\nstatic fwp_buf *file_app_buffer;"),
    );
    let grown = "        b->d = data;\n        b->cap = cap;";
    assert_eq!(code.matches(grown).count(), 1);
    code = code.replace(
        grown,
        &format!("        if(b == file_app_buffer) file_app_raw += cap - b->cap;\n{grown}"),
    );
    // Count only the C scratch buffer belonging to file.read. Other C buffers
    // and allocator pages are deliberately outside this counter.
    for signature in [
        "static V buf_to_str(",
        "static void fwp_file_buffer_cleanup(",
    ] {
        let start = code.find(signature).unwrap();
        let end = start + code[start..].find("\n}").unwrap() + 2;
        let body = &code[start..end];
        assert_eq!(body.matches("    free(b->d);").count(), 1);
        let body = body.replace("    free(b->d);", "    if(b == file_app_buffer) { if(!FILE_APP_OMIT_RAW_FREE || !file_app_active) { free(b->d); file_app_raw -= b->cap; } file_app_buffer = 0; } else free(b->d);");
        code.replace_range(start..end, &body);
    }
    let read_start = code.find("static V fwp_p_file_read_impl(").unwrap();
    let read_end = read_start + code[read_start..].find("\n}").unwrap() + 2;
    let reader = &code[read_start..read_end];
    let opened = "    if (!f) return fwp_io_error_path(\"read\", STR(path)->d, err);";
    assert_eq!(reader.matches(opened).count(), 1);
    assert_eq!(reader.matches("    fclose(f);").count(), 1);
    let reader = reader.replace(opened, &format!("{opened}\n    file_app_opened++;"))
        .replace("    fclose(f);", "    if (!FILE_APP_OMIT_CLOSE || !file_app_active) { if(fclose(f)) exit(242); file_app_closed++; }");
    assert_eq!(reader.matches("    fwp_buf b = {0};").count(), 1);
    let reader = reader.replace(
        "    fwp_buf b = {0};",
        "    fwp_buf b = {0};\n    file_app_buffer = &b;",
    );
    code.replace_range(read_start..read_end, &reader);
    // Flush the write-only omission control so later reads still see the bytes;
    // only its close is omitted, independently of read-handle controls.
    for signature in [
        "static V fwp_p_file_write_new(",
        "static V fwp_p_file_append(",
        "static V fwp_p_file_write_bytes(",
    ] {
        let start = code.find(signature).unwrap();
        let end = start + code[start..].find("\n}").unwrap() + 2;
        let body = &code[start..end];
        let opened = "    if (!f) return fwp_io_error_path(\"write\", STR(path)->d, err);";
        let closed = "    if (fclose(f) != 0 && !error) error = errno;";
        assert_eq!(body.matches(opened).count(), 1, "{signature}");
        assert_eq!(body.matches(closed).count(), 1, "{signature}");
        let body = body.replace(opened, &format!("{opened}\n    file_app_opened++;"))
            .replace(closed, "    if (!FILE_APP_OMIT_WRITE_CLOSE || !file_app_active) { int close_error = fclose(f); file_app_closed++; if(close_error && !error) error = errno; } else if(fflush(f) != 0 && !error) error = errno;");
        code.replace_range(start..end, &body);
    }
    let marker = "static void *fwp_main_thread(void *arg) {";
    assert_eq!(code.matches(marker).count(), 1);
    code = code.replace(
        marker,
        &format!(
            "{}\n{marker}",
            include_str!("../fixtures/file_app_memory.c")
        ),
    );
    let start = code.find(marker).unwrap();
    let (runtime, main) = code.split_at(start);
    let initial = "    fwp_init_consts();\n";
    let final_point = "    /* Ownership observation point: before runtime teardown. */\n";
    assert_eq!(main.matches(initial).count(), 1);
    assert_eq!(main.matches(final_point).count(), 1);
    format!(
        "{runtime}{}",
        main.replace(
            initial,
            &format!("{initial}    file_app_start=file_app_charge();\n")
        )
        .replace(
            final_point,
            &format!("{final_point}    file_app_finish();\n")
        )
    )
}

pub fn check_observations(stderr: &[u8]) {
    let observations = std::str::from_utf8(stderr).unwrap();
    assert_eq!(observations.lines().count(), 193);
    assert_eq!(observations.lines().last(), Some("file-final\t0\t0\t0"));
    for (index, line) in observations.lines().take(192).enumerate() {
        let fields: Vec<_> = line.split('\t').collect();
        assert_eq!(fields.len(), 6);
        assert_eq!(fields[0], "file-memory");
        assert_eq!(fields[1].parse::<usize>().unwrap(), index / 64);
        assert_eq!(fields[2].parse::<usize>().unwrap(), 64 - index % 64);
        assert!(fields[3].parse::<i64>().unwrap() >= 0);
        assert_eq!(fields[4], "0");
        assert_eq!(fields[5], "0");
    }
}
