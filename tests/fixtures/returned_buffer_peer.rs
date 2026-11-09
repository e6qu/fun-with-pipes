//! Native Vec for unique buffers, native Rc<Vec> for shared buffers.
use std::process;
#[cfg(buffer_shared)]
use std::rc::Rc;

#[cfg(not(buffer_shared))]
pub type Buffer = Vec<i64>;
#[cfg(buffer_shared)]
pub type Buffer = Rc<Vec<i64>>;

#[inline(never)]
pub fn make(input: i64) -> Buffer {
    let length = input.max(0) as usize;
    let mut values = Vec::new();
    values.try_reserve_exact(length).unwrap_or_else(|_| {
        eprintln!("out of memory");
        process::exit(102)
    });
    for index in 0..length { values.push(index as i64); }
    #[cfg(buffer_shared)]
    { Rc::new(values) }
    #[cfg(not(buffer_shared))]
    { values }
}

#[inline(never)]
pub fn scan(values: &Buffer) -> i64 {
    let mut sum: i64 = 0;
    for &value in values.iter() {
        sum = sum.checked_add(value).unwrap_or_else(|| {
            eprintln!("integer overflow");
            process::exit(3)
        });
    }
    sum
}

#[cfg(buffer_shared)]
#[inline(never)]
pub fn alias(values: &Buffer) -> Buffer { Rc::clone(values) }

#[inline(never)]
pub fn release(values: Buffer) { drop(values); }
