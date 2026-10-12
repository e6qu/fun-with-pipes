//! Cache pruning must preserve the executable returned to its caller.

use std::path::{Path, PathBuf};
use std::process::{Command, Output};
use std::time::{Duration, SystemTime};

struct Cache(PathBuf);

impl Cache {
    fn new(name: &str) -> Self {
        let dir =
            std::env::temp_dir().join(format!("fwp-cache-lifetime-{}-{name}", std::process::id()));
        std::fs::create_dir(&dir).unwrap();
        Self(dir)
    }

    fn source(&self, name: &str) -> PathBuf {
        let source = self.0.join(format!("{name}.fwp"));
        std::fs::write(&source, format!("main = \"{name}\" | echo\n")).unwrap();
        source
    }

    fn run(&self, source: &Path, limit: &str, interpreter: bool) -> Output {
        let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
        command
            .args(["run", if interpreter { "--interp" } else { "--native" }])
            .arg(source)
            .env("FWP_CACHE_DIR", &self.0)
            .env("FWP_CACHE_MAX", limit);
        if interpreter {
            command.env("FWP_NO_OPT", "1");
        } else {
            command.env_remove("FWP_NO_OPT");
        }
        command.output().unwrap()
    }

    fn entries(&self) -> Vec<PathBuf> {
        std::fs::read_dir(self.0.join("native"))
            .unwrap()
            .map(|entry| entry.unwrap().path())
            .filter(|path| !path.file_name().unwrap().to_string_lossy().starts_with('.'))
            .collect()
    }
}

impl Drop for Cache {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

fn assert_output(output: &Output, expected: &[u8]) {
    assert!(
        output.status.success(),
        "cache evicted the executable before it could run: {}",
        String::from_utf8_lossy(&output.stderr)
    );
    assert_eq!(output.stdout, expected);
    assert!(
        output.stderr.is_empty(),
        "{}",
        String::from_utf8_lossy(&output.stderr)
    );
}

#[test]
fn cache_limit_preserves_current_executable_despite_future_timestamps() {
    for limit in ["0", "1"] {
        let cache = Cache::new(&format!("timestamp-{limit}"));
        let first = cache.source("first");
        assert_output(&cache.run(&first, limit, false), b"first\n");
        let old = cache.entries();
        assert_eq!(
            old.len(),
            1,
            "native compilation must actually populate the cache"
        );
        std::fs::File::open(&old[0])
            .unwrap()
            .set_modified(SystemTime::now() + Duration::from_secs(3600))
            .unwrap();
        let second = cache.source("second");
        let native = cache.run(&second, limit, false);
        assert_output(&native, b"second\n");
        let oracle = cache.run(&second, limit, true);
        assert_output(&oracle, b"second\n");
        assert_eq!(native.stdout, oracle.stdout);
        let current = cache.entries();
        assert_eq!(current.len(), 1);
        assert_ne!(current[0], old[0]);
        assert!(!old[0].exists());
        assert!(current[0].is_file());
    }
}

#[test]
fn cache_hit_applies_reduced_limit_without_deleting_current_executable() {
    let cache = Cache::new("hit");
    let first = cache.source("first");
    let second = cache.source("second");
    let third = cache.source("third");
    for (source, expected) in [
        (&first, b"first\n".as_slice()),
        (&second, b"second\n".as_slice()),
        (&third, b"third\n".as_slice()),
    ] {
        assert_output(&cache.run(source, "8", false), expected);
    }
    assert_eq!(cache.entries().len(), 3);
    assert_output(&cache.run(&second, "0", false), b"second\n");
    assert_eq!(
        cache.entries().len(),
        1,
        "a cache hit must apply the reduced cache limit"
    );
    assert_output(&cache.run(&second, "1", false), b"second\n");
    assert_eq!(cache.entries().len(), 1);
}
