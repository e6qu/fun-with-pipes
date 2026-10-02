// A Rust program using the fwp-built static library libgeom.a.
use std::ffi::{CStr, CString};
use std::os::raw::c_char;

#[repr(C)]
#[derive(Clone, Copy)]
struct Point {
    x: f64,
    y: f64,
}

extern "C" {
    fn norm(p: Point) -> f64;
    fn scale(k: f64, p: Point) -> Point;
    fn add_ints(a: i64, b: i64) -> i64;
    fn greet(name: *const c_char) -> *const c_char;
    fn word_count(s: *const c_char) -> i64;
}

fn main() {
    unsafe {
        println!("norm = {}", norm(Point { x: 3.0, y: 4.0 }));
        let p = scale(2.0, Point { x: 1.5, y: -2.0 });
        println!("scale = ({}, {})", p.x, p.y);
        println!("add_ints = {}", add_ints(40, 2));
        let name = CString::new("rust").unwrap();
        println!("{}", CStr::from_ptr(greet(name.as_ptr())).to_str().unwrap());
        let s = CString::new("the quick brown fox").unwrap();
        println!("word_count = {}", word_count(s.as_ptr()));
    }
}
