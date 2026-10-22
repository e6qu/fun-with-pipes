// DIMENSIONS and UPDATES are supplied by the measurement script.
// Two owned vectors are reused. This is the explicit derivative, without a tape.
use std::io::{self, Write};

fn main() -> io::Result<()> {
    assert!((2..=4096).contains(&DIMENSIONS) && UPDATES <= 4091);
    let mut x: Vec<f64> = (0..DIMENSIONS)
        .map(|i| if i % 2 == 0 { -1.2 } else { 1.0 })
        .collect();
    let mut gradient = vec![0.0; DIMENSIONS];
    for _ in 0..UPDATES {
        gradient.fill(0.0);
        for i in 0..DIMENSIONS - 1 {
            let residual = x[i + 1] - x[i] * x[i];
            gradient[i] += -400.0 * x[i] * residual - 2.0 * (1.0 - x[i]);
            gradient[i + 1] += 200.0 * residual;
        }
        for i in 0..DIMENSIONS {
            x[i] -= 0.001 * gradient[i];
        }
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
