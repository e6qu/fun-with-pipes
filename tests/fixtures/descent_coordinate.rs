// Coordinate-wise derivative matching descent_packed.fwp, without an AD tape.
// Two vectors are reused; fwp instead allocates an immutable array per update.
use std::io::{self, Write};
use std::mem;

// Measurement parameters are inserted here.

fn main() -> io::Result<()> {
    assert!((2..=4096).contains(&DIMENSIONS) && UPDATES <= 4091);
    let mut x: Vec<f64> = (0..DIMENSIONS)
        .map(|i| if i % 2 == 0 { -1.2 } else { 1.0 })
        .collect();
    let mut next = vec![0.0; DIMENSIONS];
    for _ in 0..UPDATES {
        for i in 0..DIMENSIONS {
            let previous = if i == 0 {
                0.0
            } else {
                200.0 * (x[i] - x[i - 1] * x[i - 1])
            };
            let following = if i + 1 == DIMENSIONS {
                0.0
            } else {
                -400.0 * x[i] * (x[i + 1] - x[i] * x[i]) - 2.0 * (1.0 - x[i])
            };
            next[i] = x[i] - 0.001 * (previous + following);
        }
        mem::swap(&mut x, &mut next);
    }
    assert!(x.iter().all(|value| value.is_finite()));
    let mut output = io::stdout().lock();
    write!(output, "[")?;
    for (i, value) in x.iter().enumerate() {
        if i != 0 {
            write!(output, ", ")?;
        }
        write!(output, "{value}")?;
    }
    writeln!(output, "]")
}
