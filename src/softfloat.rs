//! Portable IEEE binary16/binary128 arithmetic. Language integration is separate
//! from this bit-level core; no host extended-float representation is assumed.
use std::ops::{Add, Div, Mul, Sub};

/// The same portable core, available to the C backend and target ABI tests.
pub const C_SOURCE: &str = include_str!(concat!(env!("OUT_DIR"), "/softfloat.c"));

#[repr(C)]
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Binary128 {
    words: [u64; 2],
}

#[repr(C)]
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Binary16(u16);

#[repr(transparent)]
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct BFloat16(u16);
#[repr(C)]
#[derive(Clone, Copy)]
struct Binary32(u32);
#[repr(C)]
#[derive(Clone, Copy)]
struct Binary64(u64);

extern "C" {
    fn f16_add(a: Binary16, b: Binary16) -> Binary16;
    fn f16_sub(a: Binary16, b: Binary16) -> Binary16;
    fn f16_mul(a: Binary16, b: Binary16) -> Binary16;
    fn f16_div(a: Binary16, b: Binary16) -> Binary16;
    fn f16_sqrt(a: Binary16) -> Binary16;
    fn fwp_f128_to_bf16(a: Binary128) -> u16;
    fn fwp_bf16_to_f128(a: u16) -> Binary128;
    fn fwp_bf16_add(a: u16, b: u16) -> u16;
    fn fwp_bf16_sub(a: u16, b: u16) -> u16;
    fn fwp_bf16_mul(a: u16, b: u16) -> u16;
    fn fwp_bf16_div(a: u16, b: u16) -> u16;
    fn fwp_bf16_sqrt(a: u16) -> u16;
    fn f128_add(a: Binary128, b: Binary128) -> Binary128;
    fn f128_sub(a: Binary128, b: Binary128) -> Binary128;
    fn f128_mul(a: Binary128, b: Binary128) -> Binary128;
    fn f128_div(a: Binary128, b: Binary128) -> Binary128;
    fn f128_sqrt(a: Binary128) -> Binary128;
    fn f128_to_f16(a: Binary128) -> Binary16;
    fn f128_to_f32(a: Binary128) -> Binary32;
    fn f128_to_f64(a: Binary128) -> Binary64;
    fn f16_to_f128(a: Binary16) -> Binary128;
    fn f32_to_f128(a: Binary32) -> Binary128;
    fn f64_to_f128(a: Binary64) -> Binary128;
}

impl Binary128 {
    pub const fn from_bits(bits: u128) -> Self {
        Self {
            words: [bits as u64, (bits >> 64) as u64],
        }
    }

    pub const fn to_bits(self) -> u128 {
        ((self.words[1] as u128) << 64) | self.words[0] as u128
    }

    pub fn from_f16_bits(bits: u16) -> Self {
        unsafe { f16_to_f128(Binary16(bits)) }
    }

    pub fn from_f32(value: f32) -> Self {
        unsafe { f32_to_f128(Binary32(value.to_bits())) }
    }

    pub fn from_f64(value: f64) -> Self {
        unsafe { f64_to_f128(Binary64(value.to_bits())) }
    }

    pub fn to_f16_bits(self) -> u16 {
        unsafe { f128_to_f16(self).0 }
    }

    pub fn to_f32(self) -> f32 {
        f32::from_bits(unsafe { f128_to_f32(self).0 })
    }

    pub fn to_f64(self) -> f64 {
        f64::from_bits(unsafe { f128_to_f64(self).0 })
    }

    pub fn sqrt(self) -> Self {
        unsafe { f128_sqrt(self) }
    }
}

impl Binary16 {
    pub const fn from_bits(bits: u16) -> Self {
        Self(bits)
    }
    pub const fn to_bits(self) -> u16 {
        self.0
    }
    pub fn from_quad(value: Binary128) -> Self {
        unsafe { f128_to_f16(value) }
    }
    pub fn to_quad(self) -> Binary128 {
        unsafe { f16_to_f128(self) }
    }
    pub fn sqrt(self) -> Self {
        unsafe { f16_sqrt(self) }
    }
}

impl BFloat16 {
    pub const fn from_bits(bits: u16) -> Self {
        Self(bits)
    }
    pub const fn to_bits(self) -> u16 {
        self.0
    }
    pub fn from_quad(value: Binary128) -> Self {
        Self(unsafe { fwp_f128_to_bf16(value) })
    }
    pub fn to_quad(self) -> Binary128 {
        unsafe { fwp_bf16_to_f128(self.0) }
    }
    pub fn sqrt(self) -> Self {
        Self(unsafe { fwp_bf16_sqrt(self.0) })
    }
}

macro_rules! binary_ops {
    ($ty:ty, $add:ident, $sub:ident, $mul:ident, $div:ident, $call:expr) => {
        impl Add for $ty {
            type Output = Self;
            fn add(self, other: Self) -> Self {
                ($call)($add, self, other)
            }
        }
        impl Sub for $ty {
            type Output = Self;
            fn sub(self, other: Self) -> Self {
                ($call)($sub, self, other)
            }
        }
        impl Mul for $ty {
            type Output = Self;
            fn mul(self, other: Self) -> Self {
                ($call)($mul, self, other)
            }
        }
        impl Div for $ty {
            type Output = Self;
            fn div(self, other: Self) -> Self {
                ($call)($div, self, other)
            }
        }
    };
}
binary_ops!(
    Binary128,
    f128_add,
    f128_sub,
    f128_mul,
    f128_div,
    |f: unsafe extern "C" fn(Binary128, Binary128) -> Binary128, a, b| unsafe { f(a, b) }
);
binary_ops!(
    Binary16,
    f16_add,
    f16_sub,
    f16_mul,
    f16_div,
    |f: unsafe extern "C" fn(Binary16, Binary16) -> Binary16, a, b| unsafe { f(a, b) }
);
binary_ops!(
    BFloat16,
    fwp_bf16_add,
    fwp_bf16_sub,
    fwp_bf16_mul,
    fwp_bf16_div,
    |f: unsafe extern "C" fn(u16, u16) -> u16, a: BFloat16, b: BFloat16| BFloat16(unsafe {
        f(a.0, b.0)
    })
);

#[cfg(test)]
mod tests {
    use super::Binary128 as Q;
    const ONE: u128 = 0x3fff_0000_0000_0000_0000_0000_0000_0000;

    #[test]
    fn quad_arithmetic_retains_bits_beyond_double_precision() {
        let one = Q::from_bits(ONE);
        let next = Q::from_bits(ONE + 1);
        assert_eq!(
            (next - one).to_bits(),
            0x3f8f_0000_0000_0000_0000_0000_0000_0000
        ); // 2^-112
        assert_eq!((next + next).to_bits(), ONE + (1 << 112) + 1);
        assert_eq!((next * next).to_bits(), ONE + 2);
        assert_eq!(
            (one / Q::from_f64(3.0)).to_bits(),
            0x3ffd_5555_5555_5555_5555_5555_5555_5555
        );
        assert_eq!(
            Q::from_f64(2.0).sqrt().to_bits(),
            0x3fff_6a09_e667_f3bc_c908_b2fb_1366_ea95
        );
    }

    #[test]
    fn quad_rounds_ties_even_and_preserves_subnormals() {
        let half_ulp = Q::from_bits(0x3f8e_0000_0000_0000_0000_0000_0000_0000);
        assert_eq!((Q::from_bits(ONE) + half_ulp).to_bits(), ONE);
        assert_eq!((Q::from_bits(ONE + 1) + half_ulp).to_bits(), ONE + 2);
        assert_eq!((Q::from_bits(1) + Q::from_bits(1)).to_bits(), 2);
        assert_eq!((Q::from_bits(1) / Q::from_f64(2.0)).to_bits(), 0);
        assert_eq!(Q::from_bits(1 << 127).sqrt().to_bits(), 1 << 127);
    }

    #[test]
    fn half_conversion_rounds_directly_from_quad() {
        // Just above the binary16 midpoint 1 + 2^-11. Converting through
        // binary32 or binary64 would first erase the last binary128 bit.
        let above = Q::from_bits(ONE + (1 << 101) + 1);
        assert_eq!(above.to_f16_bits(), 0x3c01);
        assert_eq!(Q::from_f64(above.to_f64()).to_f16_bits(), 0x3c00);
        for bits in 0u16..=u16::MAX {
            if bits & 0x7c00 == 0x7c00 && bits & 0x03ff != 0 {
                continue;
            }
            assert_eq!(Q::from_f16_bits(bits).to_f16_bits(), bits);
        }
    }

    #[test]
    fn bfloat_conversion_and_arithmetic_round_once() {
        use super::BFloat16 as B;
        let one = B::from_bits(0x3f80);
        // Midpoint between 1 and 1 + 2^-7, with one extra quad bit.
        let above = Q::from_bits(ONE + (1 << 104) + 1);
        assert_eq!(B::from_quad(above).to_bits(), 0x3f81);
        assert_eq!(B::from_quad(Q::from_f64(above.to_f64())).to_bits(), 0x3f80);
        assert_eq!((one / B::from_bits(0x4040)).to_bits(), 0x3eab); // 1/3
        assert_eq!(B::from_bits(0x4000).sqrt().to_bits(), 0x3fb5); // sqrt(2)
        let half_ulp = B::from_bits(0x3b80); // 2^-8
        assert_eq!((one + half_ulp).to_bits(), 0x3f80);
        assert_eq!((B::from_bits(0x3f81) + half_ulp).to_bits(), 0x3f82);
        assert_eq!((B::from_bits(1) + B::from_bits(1)).to_bits(), 2);
        assert_eq!((B::from_bits(1) / B::from_bits(0x4000)).to_bits(), 0);
        assert_eq!(
            (B::from_bits(0x7f7f) * B::from_bits(0x4000)).to_bits(),
            0x7f80
        );
        assert_eq!(B::from_bits(0x8000).sqrt().to_bits(), 0x8000);
        assert_eq!((B::from_bits(0xff81) + one).to_bits(), 0x7fc0);
        for bits in 0u16..=u16::MAX {
            if bits & 0x7f80 == 0x7f80 && bits & 0x007f != 0 {
                continue;
            }
            assert_eq!(B::from_quad(B::from_bits(bits).to_quad()).to_bits(), bits);
        }
    }

    #[test]
    fn half_arithmetic_has_half_precision() {
        use super::Binary16 as H;
        let one = H::from_bits(0x3c00);
        assert_eq!((one / H::from_bits(0x4200)).to_bits(), 0x3555); // 1/3
        assert_eq!(H::from_bits(0x4000).sqrt().to_bits(), 0x3da8); // sqrt(2)
        let half_ulp = H::from_bits(0x1000); // 2^-11
        assert_eq!((one + half_ulp).to_bits(), 0x3c00);
        assert_eq!((H::from_bits(0x3c01) + half_ulp).to_bits(), 0x3c02);
        assert_eq!((H::from_bits(1) + H::from_bits(1)).to_bits(), 2);
        assert_eq!((H::from_bits(1) / H::from_bits(0x4000)).to_bits(), 0);
        assert_eq!(
            (H::from_bits(0x7bff) * H::from_bits(0x4000)).to_bits(),
            0x7c00
        );
        assert_eq!(H::from_bits(0x8000).sqrt().to_bits(), 0x8000);
    }

    #[test]
    fn arithmetic_nan_policy_is_canonical_but_raw_bits_are_unchanged() {
        let payload = 0x7fff_8123_0000_0000_0123_4567_89ab_cdef;
        let nan = Q::from_bits(payload);
        assert_eq!(nan.to_bits(), payload);
        assert_eq!(
            (nan + Q::from_bits(ONE)).to_bits(),
            0x7fff_8000_0000_0000_0000_0000_0000_0000
        );
    }
}

/// Stable identifiers for the shared text ABI; BF16's identifier is not its width.
#[repr(i32)]
#[derive(Clone, Copy, Debug)]
pub enum FloatFormat {
    F16 = 16,
    BF16 = 17,
    F32 = 32,
    F64 = 64,
    F128 = 128,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum FloatTextError {
    Invalid,
    OutOfMemory,
}

extern "C" {
    fn fwp_decimal_parse(
        text: *const std::ffi::c_char,
        format: i32,
        low: *mut u64,
        high: *mut u64,
    ) -> i32;
    fn fwp_decimal_show(
        low: u64,
        high: u64,
        format: i32,
        buffer: *mut std::ffi::c_char,
        capacity: usize,
    ) -> i32;
}

/// Decimal input rounds directly to the requested format, including subnormals.
pub fn parse_bits(text: &str, format: FloatFormat) -> Result<u128, FloatTextError> {
    let text = std::ffi::CString::new(text).map_err(|_| FloatTextError::Invalid)?;
    let (mut low, mut high) = (0, 0);
    match unsafe { fwp_decimal_parse(text.as_ptr(), format as i32, &mut low, &mut high) } {
        1 => Ok((high as u128) << 64 | low as u128),
        0 => Err(FloatTextError::Invalid),
        -1 => Err(FloatTextError::OutOfMemory),
        code => panic!("unexpected exact float parser status {code}"),
    }
}

/// Shortest round-trip digits in scientific notation; raw NaN payloads require
/// binary transport. Both engines use this exact core during format migration.
pub fn format_bits(bits: u128, format: FloatFormat) -> Result<String, FloatTextError> {
    let mut buffer = [0u8; 64];
    let length = unsafe {
        fwp_decimal_show(
            bits as u64,
            (bits >> 64) as u64,
            format as i32,
            buffer.as_mut_ptr().cast(),
            buffer.len(),
        )
    };
    if length < 0 {
        return Err(FloatTextError::OutOfMemory);
    }
    Ok(std::str::from_utf8(&buffer[..length as usize])
        .expect("decimal ASCII")
        .into())
}

#[cfg(test)]
mod text_tests {
    use super::{format_bits, parse_bits, FloatFormat::*, FloatTextError};

    #[test]
    fn decimal_rounds_once_at_the_requested_precision() {
        assert_eq!(
            parse_bits("1.0000000000000000000000000000000002", F128),
            Ok(0x3fff0000000000000000000000000001)
        );
        assert_eq!(
            parse_bits("1.0004882812500000000000000000000001", F16),
            Ok(0x3c01)
        );
        assert_eq!(
            parse_bits("1.0039062500000000000000000000000001", BF16),
            Ok(0x3f81)
        );
        assert_eq!(parse_bits("4.5e-6", F16), Ok(0x004b));
        assert_eq!(parse_bits("1.00048828125", F16), Ok(0x3c00));
        assert_eq!(parse_bits("1.00146484375", F16), Ok(0x3c02));
        assert_eq!(parse_bits("-0", F128), Ok(1 << 127));
        assert_eq!(
            parse_bits("1e100000", F128),
            Ok(0x7fff0000000000000000000000000000)
        );
        assert_eq!(parse_bits("-1e-100000", F128), Ok(1 << 127));
        for invalid in ["", "garbage", "1.2oops", "1\0", " 1", "1 ", "0x1p0"] {
            assert_eq!(
                parse_bits(invalid, F128),
                Err(FloatTextError::Invalid),
                "{invalid:?}"
            );
        }
    }

    #[test]
    fn decimal_controls_match_independent_standard_float_parsers() {
        // Decimal strings are generated from integers, independently of gdtoa.
        for mantissa in [1u64, 3, 75, 9999, 12345678901234567, u64::MAX] {
            for exponent in -330..=310 {
                let text = format!("{mantissa}e{exponent}");
                assert_eq!(
                    parse_bits(&text, F64).unwrap(),
                    text.parse::<f64>().unwrap().to_bits() as u128,
                    "F64 {text}"
                );
                assert_eq!(
                    parse_bits(&text, F32).unwrap(),
                    text.parse::<f32>().unwrap().to_bits() as u128,
                    "F32 {text}"
                );
            }
        }
        assert_eq!(
            parse_bits("6.4751751194380251109244389582276465525e-4966", F128),
            Ok(1)
        );
        assert_eq!(
            parse_bits("1.1897314953572317650857593266280070162e4932", F128),
            Ok(0x7ffeffffffffffffffffffffffffffff)
        );
    }

    #[test]
    fn all_half_and_bfloat_values_round_trip_through_shortest_text() {
        for (format, exp, frac) in [(F16, 0x7c00, 0x3ff), (BF16, 0x7f80, 0x7f)] {
            for bits in 0u128..=0xffff {
                if bits & exp == exp && bits & frac != 0 {
                    continue;
                }
                let text = format_bits(bits, format).unwrap();
                assert_eq!(
                    parse_bits(&text, format).unwrap(),
                    bits,
                    "{format:?} {bits:x}: {text}"
                );
            }
        }
    }

    #[test]
    fn quad_extremes_and_deterministic_bit_patterns_round_trip() {
        let mut state = 0x123456789abcdef0u64;
        let mut words = vec![
            0,
            1,
            1 << 127,
            (1 << 112) - 1,
            1 << 112,
            0x3fff0000000000000000000000000001,
            0x7ffeffffffffffffffffffffffffffff,
        ];
        for _ in 0..1000 {
            state ^= state << 13;
            state ^= state >> 7;
            state ^= state << 17;
            let high = state;
            state ^= state << 13;
            state ^= state >> 7;
            state ^= state << 17;
            words.push((high as u128) << 64 | state as u128);
        }
        for bits in words {
            if bits >> 112 & 0x7fff == 0x7fff {
                continue;
            }
            let text = format_bits(bits, F128).unwrap();
            assert_eq!(parse_bits(&text, F128).unwrap(), bits, "{bits:x}: {text}");
        }
    }

    #[cfg(not(target_arch = "wasm32"))]
    #[test]
    fn conversion_scopes_are_independent_across_threads() {
        let threads: Vec<_> = (0..4u128)
            .map(|thread| {
                std::thread::spawn(move || {
                    for n in 0..128u128 {
                        let bits = 0x3fff0000000000000000000000000000 + (thread << 20) + n;
                        assert_eq!(
                            parse_bits(&format_bits(bits, F128).unwrap(), F128).unwrap(),
                            bits
                        );
                    }
                })
            })
            .collect();
        for thread in threads {
            thread.join().unwrap();
        }
    }
}
