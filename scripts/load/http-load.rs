//! Closed-loop HTTP/1.1 driver. Every attempt is retained, including warmup/errors.
use std::collections::HashMap;
use std::fs::{self, File};
use std::io::{self, BufWriter, Read, Write};
use std::net::{SocketAddr, TcpStream};
use std::path::{Path, PathBuf};
use std::sync::{Arc, Barrier, OnceLock};
use std::time::{Duration, Instant, SystemTime, UNIX_EPOCH};

const REQUEST: &[u8] =
    b"GET /items/42 HTTP/1.1\r\nhost: test\r\ncontent-length: 0\r\nconnection: keep-alive\r\n\r\n";
const BODY: &[u8] = b"{\"id\":42,\"name\":\"item 42\"}";

fn remaining(end: Instant) -> io::Result<Duration> {
    end.checked_duration_since(Instant::now())
        .filter(|d| !d.is_zero())
        .ok_or_else(|| io::Error::new(io::ErrorKind::TimedOut, "request deadline"))
}

fn response_length(bytes: &[u8]) -> Result<Option<usize>, ()> {
    let Some(index) = bytes.windows(4).position(|w| w == b"\r\n\r\n") else {
        return if bytes.len() < 8192 {
            Ok(None)
        } else {
            Err(())
        };
    };
    let header = std::str::from_utf8(&bytes[..index]).map_err(|_| ())?;
    let mut lines = header.split("\r\n");
    if lines.next() != Some("HTTP/1.1 200 OK") {
        return Err(());
    }
    let mut length = None;
    for line in lines {
        let (key, value) = line.split_once(':').ok_or(())?;
        if key.eq_ignore_ascii_case("content-length") {
            if length.is_some() {
                return Err(());
            }
            length = Some(value.trim().parse::<usize>().map_err(|_| ())?);
        }
        if key.eq_ignore_ascii_case("transfer-encoding")
            || (key.eq_ignore_ascii_case("connection")
                && value.trim().eq_ignore_ascii_case("close"))
        {
            return Err(());
        }
    }
    let length = length.ok_or(())?;
    if length != BODY.len() {
        return Err(());
    }
    Ok(Some(index + 4 + length))
}

fn attempt(stream: &mut TcpStream, deadline: Duration, bytes: &mut Vec<u8>, sent: &mut u32) -> u32 {
    let end = Instant::now() + deadline;
    let transfer = (|| -> io::Result<()> {
        while (*sent as usize) < REQUEST.len() {
            stream.set_write_timeout(Some(remaining(end)?))?;
            let count = stream.write(&REQUEST[*sent as usize..])?;
            if count == 0 {
                return Err(io::ErrorKind::WriteZero.into());
            }
            *sent += count as u32;
        }
        loop {
            if let Some(length) = response_length(bytes).map_err(|_| {
                io::Error::new(io::ErrorKind::InvalidData, "response framing/status")
            })? {
                if bytes.len() >= length {
                    if bytes.len() != length || !bytes.ends_with(BODY) {
                        return Err(io::Error::new(io::ErrorKind::InvalidData, "response body"));
                    }
                    remaining(end)?;
                    return Ok(());
                }
            }
            stream.set_read_timeout(Some(remaining(end)?))?;
            let mut buffer = [0; 1024];
            let count = stream.read(&mut buffer)?;
            if count == 0 {
                return Err(io::ErrorKind::UnexpectedEof.into());
            }
            bytes.extend_from_slice(&buffer[..count]);
        }
    })();
    match transfer {
        Ok(()) => 0,
        Err(e) => match e.kind() {
            io::ErrorKind::TimedOut | io::ErrorKind::WouldBlock => 1,
            io::ErrorKind::InvalidData => 2,
            io::ErrorKind::UnexpectedEof => 3,
            _ => 4,
        },
    }
}

struct Settings {
    address: SocketAddr,
    warmup: Duration,
    duration: Duration,
    deadline: Duration,
    output: PathBuf,
    epoch: OnceLock<Instant>,
    barrier: Barrier,
}

fn worker(id: usize, settings: &Settings) -> io::Result<(u64, u64)> {
    // Always reach the barrier, including setup failures; no worker strands peers.
    let connected =
        TcpStream::connect_timeout(&settings.address, settings.deadline).and_then(|stream| {
            stream.set_nodelay(true)?;
            Ok(stream)
        });
    let files = (|| -> io::Result<_> {
        Ok((
            BufWriter::new(File::create(
                settings.output.join(format!("worker-{id}.bin")),
            )?),
            BufWriter::new(File::create(
                settings.output.join(format!("worker-{id}.wire")),
            )?),
        ))
    })();
    settings.barrier.wait();
    settings.barrier.wait();
    let mut stream = connected?;
    let (mut samples, mut wires) = files?;
    let epoch = *settings.epoch.get().unwrap();
    let finish = epoch + settings.warmup + settings.duration;
    let mut responses: HashMap<Vec<u8>, u32> = HashMap::new();
    let mut bytes = Vec::with_capacity(1024);
    let mut attempts = 0;
    let mut failures = 0;
    while Instant::now() < finish {
        bytes.clear();
        let mut sent = 0;
        let started = Instant::now();
        if started >= finish {
            break;
        }
        let outcome = attempt(&mut stream, settings.deadline, &mut bytes, &mut sent);
        let ended = Instant::now();
        let next_id = responses.len() as u32;
        let response_id = match responses.get(&bytes) {
            Some(id) => *id,
            None => {
                wires.write_all(&(bytes.len() as u32).to_le_bytes())?;
                wires.write_all(&bytes)?;
                responses.insert(bytes.clone(), next_id);
                next_id
            }
        };
        let mut row = [0; 32];
        row[..8].copy_from_slice(&(started.duration_since(epoch).as_nanos() as u64).to_le_bytes());
        row[8..16].copy_from_slice(&(ended.duration_since(epoch).as_nanos() as u64).to_le_bytes());
        row[16..20].copy_from_slice(&sent.to_le_bytes());
        row[20..24].copy_from_slice(&(bytes.len() as u32).to_le_bytes());
        row[24..28].copy_from_slice(&outcome.to_le_bytes());
        row[28..32].copy_from_slice(&response_id.to_le_bytes());
        samples.write_all(&row)?;
        attempts += 1;
        if outcome != 0 {
            failures += 1;
            // A failed persistent connection is not silently reconnected/retried.
            break;
        }
    }
    samples.flush()?;
    wires.flush()?;
    Ok((attempts, failures))
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args: Vec<_> = std::env::args().collect();
    if args.len() != 7 {
        return Err("usage: http-load ADDRESS CONNECTIONS WARMUP_SECONDS SECONDS DEADLINE_MILLISECONDS OUTPUT".into());
    }
    let address: SocketAddr = args[1].parse()?;
    if !address.ip().is_loopback() {
        return Err("this experiment requires loopback".into());
    }
    let connections: usize = args[2].parse()?;
    if !(1..=64).contains(&connections) {
        return Err("connections must be 1..64".into());
    }
    let warmup = Duration::from_secs(args[3].parse()?);
    let duration = Duration::from_secs(args[4].parse()?);
    let deadline = Duration::from_millis(args[5].parse()?);
    if duration.is_zero() || deadline.is_zero() {
        return Err("duration and deadline must be positive".into());
    }
    let output = Path::new(&args[6]);
    fs::create_dir(output)?;
    fs::write(output.join("request.bin"), REQUEST)?;
    let settings = Arc::new(Settings {
        address,
        warmup,
        duration,
        deadline,
        output: output.to_owned(),
        epoch: OnceLock::new(),
        barrier: Barrier::new(connections + 1),
    });
    let mut threads = Vec::new();
    for id in 0..connections {
        let shared = settings.clone();
        threads.push(std::thread::spawn(move || worker(id, &shared)));
    }
    // First rendezvous excludes connection setup from the common request clock.
    // Second rendezvous releases workers only after the epoch is initialized.
    settings.barrier.wait();
    settings.epoch.set(Instant::now()).unwrap();
    let epoch_unix_ns = SystemTime::now().duration_since(UNIX_EPOCH)?.as_nanos();
    settings.barrier.wait();
    let mut attempts = 0;
    let mut failures = 0;
    let mut setup_errors = 0;
    for (id, thread) in threads.into_iter().enumerate() {
        match thread.join() {
            Ok(Ok((count, errors))) => {
                attempts += count;
                failures += errors;
            }
            Ok(Err(error)) => {
                eprintln!("worker {id}: {error}");
                setup_errors += 1;
            }
            Err(_) => {
                eprintln!("worker {id}: panic");
                setup_errors += 1;
            }
        }
    }
    println!("{{\"connections\":{connections},\"warmupNs\":{},\"durationNs\":{},\"deadlineNs\":{},\"epochUnixNs\":{epoch_unix_ns},\"attempts\":{attempts},\"failures\":{failures},\"setupErrors\":{setup_errors}}}",
        warmup.as_nanos(), duration.as_nanos(), deadline.as_nanos());
    if failures != 0 || setup_errors != 0 {
        return Err("load recorded unsuccessful attempts or worker errors".into());
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn fixed_response_requires_unambiguous_complete_framing() {
        let wire = format!("HTTP/1.1 200 OK\r\ncontent-length: {}\r\n\r\n", BODY.len());
        assert_eq!(response_length(b"HTTP/1.1"), Ok(None));
        assert_eq!(
            response_length(wire.as_bytes()),
            Ok(Some(wire.len() + BODY.len()))
        );
        assert!(response_length(wire.replace("200", "404").as_bytes()).is_err());
        assert!(response_length(
            wire.replace("content-length:", "transfer-encoding:")
                .as_bytes()
        )
        .is_err());
        assert!(response_length(
            wire.replace("\r\n\r\n", "\r\ncontent-length: 26\r\n\r\n")
                .as_bytes()
        )
        .is_err());
        assert!(response_length(&[b'x'; 8192]).is_err());
    }
}
