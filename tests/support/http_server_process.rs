//! Bounded startup and explicit shutdown for the HTTP test servers.
use std::io::{BufRead, BufReader};
#[cfg(windows)]
use std::os::windows::process::CommandExt;
use std::process::{Child, ChildStderr, Command, Stdio};
use std::time::Duration;

#[cfg(windows)]
#[link(name = "kernel32")]
extern "system" {
    fn GenerateConsoleCtrlEvent(event: u32, group: u32) -> i32;
}

pub fn start(
    command: &mut Command,
    prefix: &str,
    timeout: Duration,
    input: Stdio,
) -> Result<(Child, String, BufReader<ChildStderr>), String> {
    #[cfg(windows)]
    command.creation_flags(0x00000200); // isolate CTRL_BREAK to this server
    let mut child = command
        .stdin(input)
        .stdout(Stdio::null())
        .stderr(Stdio::piped())
        .spawn()
        .map_err(|error| format!("start {command:?}: {error}"))?;
    let mut stderr = BufReader::new(child.stderr.take().unwrap());
    let (sender, receiver) = std::sync::mpsc::channel();
    let reader = std::thread::spawn(move || {
        let mut line = String::new();
        let result = stderr.read_line(&mut line);
        let _ = sender.send((result, line, stderr));
    });
    let result = match receiver.recv_timeout(timeout) {
        Ok((Ok(n), line, stderr)) if n > 0 => match line.trim().strip_prefix(prefix) {
            Some(address) if !address.is_empty() => Ok((address.to_owned(), stderr)),
            _ => Err(format!("unexpected server address: {line:?}")),
        },
        Ok((Ok(_), _, _)) => Err("server exited before reporting its address".into()),
        Ok((Err(error), _, _)) => Err(format!("read server address: {error}")),
        Err(error) => Err(format!("server startup deadline: {error}")),
    };
    match result {
        Ok((address, stderr)) => {
            reader.join().expect("server address reader");
            Ok((child, address, stderr))
        }
        Err(error) => {
            let _ = child.kill();
            let reaped = child.wait();
            drop(receiver);
            reader.join().expect("server address reader");
            reaped.map_err(|wait| format!("{error}; reap server: {wait}"))?;
            Err(error)
        }
    }
}

// TLS-only tests use startup and drain stderr, then kill and reap directly.
#[allow(dead_code)]
pub fn terminate(child: &Child) -> Result<(), String> {
    #[cfg(unix)]
    {
        let output = Command::new("kill")
            .args(["-TERM", &child.id().to_string()])
            .output()
            .map_err(|error| format!("send SIGTERM: {error}"))?;
        if !output.status.success() {
            return Err(format!("send SIGTERM: {output:?}"));
        }
    }
    #[cfg(windows)]
    if unsafe { GenerateConsoleCtrlEvent(1, child.id()) } == 0 {
        return Err(format!(
            "send CTRL_BREAK: {}",
            std::io::Error::last_os_error()
        ));
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    #[test]
    fn child() {
        let Ok(mode) = std::env::var("FWP_HTTP_STARTUP_CHILD") else {
            return;
        };
        match mode.as_str() {
            "silent" => {}
            "partial" => eprint!("listening on http://"),
            "invalid" => eprintln!("bad address"),
            "ready" => eprintln!("listening on http://127.0.0.1:1234\nretained log"),
            "exit" => return,
            _ => panic!("unknown child mode"),
        }
        std::io::Write::flush(&mut std::io::stderr()).unwrap();
        std::thread::sleep(std::time::Duration::from_secs(30));
    }

    fn command(mode: &str) -> std::process::Command {
        let mut command = std::process::Command::new(std::env::current_exe().unwrap());
        let test = format!("{}::child", module_path!().split_once("::").unwrap().1);
        command
            .args(["--exact", &test, "--nocapture"])
            .env("FWP_HTTP_STARTUP_CHILD", mode);
        command
    }

    #[test]
    fn failed_startup_is_bounded_and_reaps_the_child() {
        for mode in ["silent", "partial", "invalid", "exit"] {
            let began = std::time::Instant::now();
            let result = super::start(
                &mut command(mode),
                "listening on http://",
                std::time::Duration::from_secs(if matches!(mode, "silent" | "partial") {
                    1
                } else {
                    10
                }),
                std::process::Stdio::null(),
            );
            let error = result.unwrap_err();
            assert!(
                if matches!(mode, "silent" | "partial") {
                    error.contains("timed out")
                } else if mode == "invalid" {
                    error.contains("unexpected server address")
                } else {
                    error.contains("exited before")
                },
                "{mode}: {error}"
            );
            assert!(began.elapsed() < std::time::Duration::from_secs(15));
        }
    }

    #[test]
    fn ready_server_keeps_buffered_diagnostics() {
        let (mut child, address, mut stderr) = super::start(
            &mut command("ready"),
            "listening on http://",
            std::time::Duration::from_secs(15),
            std::process::Stdio::null(),
        )
        .unwrap();
        child.kill().unwrap();
        child.wait().unwrap();
        assert_eq!(address, "127.0.0.1:1234");
        let mut rest = String::new();
        std::io::Read::read_to_string(&mut stderr, &mut rest).unwrap();
        assert_eq!(rest.trim(), "retained log");
    }
}
