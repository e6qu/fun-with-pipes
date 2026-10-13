//! Portable IEEE binary16/binary128 arithmetic. Language integration is separate
//! from this bit-level core; no host extended-float representation is assumed.
use std::ops::{Add, Div, Mul, Sub};

/// The same portable core, available to the C backend and target ABI tests.
pub const C_SOURCE: &str = include_str!(concat!(env!("OUT_DIR"), "/softfloat.c"));
pub const MATH_SOURCE: &str = include_str!(concat!(env!("OUT_DIR"), "/float_math.cpp"));

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
    fn fwp_u128_to_f128(low: u64, high: u64) -> Binary128;
    fn fwp_u128_to_f16(low: u64, high: u64) -> u16;
    fn fwp_u128_to_bf16(low: u64, high: u64) -> u16;
    fn fwp_f128_to_integer(
        value: Binary128,
        low: *mut u64,
        high: *mut u64,
        negative: *mut i32,
    ) -> i32;
    fn fwp_f128_compare(a: Binary128, b: Binary128) -> i32;
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
    pub fn from_u128(value: u128) -> Self {
        unsafe { fwp_u128_to_f128(value as u64, (value >> 64) as u64) }
    }

    pub fn from_i128(value: i128) -> Self {
        let bits = Self::from_u128(value.unsigned_abs()).to_bits();
        Self::from_bits(bits | ((value < 0) as u128) << 127)
    }

    /// Truncated sign/magnitude, or None for nonfinite values or |trunc(x)| >= 2^128.
    pub fn trunc_integer(self) -> Option<(bool, u128)> {
        let (mut low, mut high, mut negative) = (0, 0, 0);
        (unsafe { fwp_f128_to_integer(self, &mut low, &mut high, &mut negative) } != 0)
            .then_some((negative != 0, (high as u128) << 64 | low as u128))
    }

    pub fn numeric_cmp(self, other: Self) -> Option<std::cmp::Ordering> {
        use std::cmp::Ordering::*;
        match unsafe { fwp_f128_compare(self, other) } {
            -1 => Some(Less),
            0 => Some(Equal),
            1 => Some(Greater),
            2 => None,
            _ => unreachable!("invalid binary128 comparison result"),
        }
    }

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
    pub fn from_u128(value: u128) -> Self {
        Self(unsafe { fwp_u128_to_f16(value as u64, (value >> 64) as u64) })
    }

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
    pub fn from_u128(value: u128) -> Self {
        Self(unsafe { fwp_u128_to_bf16(value as u64, (value >> 64) as u64) })
    }

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

macro_rules! transcendental_ops {
    ($ty:ty, $abi:ty, $unwrap:expr, $wrap:expr, $exp:ident, $ln:ident, $sin:ident, $cos:ident, $tan:ident, $pow:ident) => {
        extern "C" {
            fn $exp(a: $abi) -> $abi;
            fn $ln(a: $abi) -> $abi;
            fn $sin(a: $abi) -> $abi;
            fn $cos(a: $abi) -> $abi;
            fn $tan(a: $abi) -> $abi;
            fn $pow(a: $abi, b: $abi) -> $abi;
        }
        impl $ty {
            pub fn exp(self) -> Self {
                ($wrap)(unsafe { $exp(($unwrap)(self)) })
            }
            pub fn ln(self) -> Self {
                ($wrap)(unsafe { $ln(($unwrap)(self)) })
            }
            pub fn sin(self) -> Self {
                ($wrap)(unsafe { $sin(($unwrap)(self)) })
            }
            pub fn cos(self) -> Self {
                ($wrap)(unsafe { $cos(($unwrap)(self)) })
            }
            pub fn tan(self) -> Self {
                ($wrap)(unsafe { $tan(($unwrap)(self)) })
            }
            pub fn pow(self, exponent: Self) -> Self {
                ($wrap)(unsafe { $pow(($unwrap)(self), ($unwrap)(exponent)) })
            }
        }
    };
}
transcendental_ops!(
    Binary128,
    Binary128,
    |v| v,
    |v| v,
    fwp_f128_exp,
    fwp_f128_ln,
    fwp_f128_sin,
    fwp_f128_cos,
    fwp_f128_tan,
    fwp_f128_pow
);
transcendental_ops!(
    Binary16,
    u16,
    |v: Binary16| v.0,
    Binary16,
    fwp_f16_exp,
    fwp_f16_ln,
    fwp_f16_sin,
    fwp_f16_cos,
    fwp_f16_tan,
    fwp_f16_pow
);
transcendental_ops!(
    BFloat16,
    u16,
    |v: BFloat16| v.0,
    BFloat16,
    fwp_bf16_exp,
    fwp_bf16_ln,
    fwp_bf16_sin,
    fwp_bf16_cos,
    fwp_bf16_tan,
    fwp_bf16_pow
);

#[cfg(test)]
mod tests {
    use super::Binary128 as Q;
    const ONE: u128 = 0x3fff_0000_0000_0000_0000_0000_0000_0000;

    #[test]
    fn transcendentals_retain_the_declared_precision_and_range() {
        use super::{parse_bits, BFloat16 as B, Binary16 as H, FloatFormat::F128};
        // Independent mathematical constants, with more than binary128 precision.
        for (actual, decimal) in [
            (
                Q::from_f64(1.0).exp(),
                "2.71828182845904523536028747135266249775724709369995",
            ),
            (
                Q::from_f64(2.0).ln(),
                "0.69314718055994530941723212145817656807550013436026",
            ),
            (
                Q::from_f64(1.0).sin(),
                "0.84147098480789650665250232163029899962256306079837",
            ),
            (
                Q::from_f64(1.0).cos(),
                "0.54030230586813971740093660744297660373231042061792",
            ),
            (
                Q::from_f64(1.0).tan(),
                "1.5574077246549022305069748074583601730872507723815",
            ),
        ] {
            let expected = parse_bits(decimal, F128).unwrap();
            assert!(
                actual.to_bits().abs_diff(expected) <= 1,
                "{actual:?}: {decimal}"
            );
            assert_ne!(actual.to_bits(), Q::from_f64(actual.to_f64()).to_bits());
        }
        // Values near one and far beyond binary64's range cannot use host libm.
        assert_eq!(
            Q::from_bits(ONE + 1).ln().to_bits(),
            0x3f8effffffffffffffffffffffffffff
        );
        assert_eq!(Q::from_bits(1).sin().to_bits(), 1);
        assert_eq!(Q::from_bits(1 << 127).sin().to_bits(), 1 << 127);
        let large = Q::from_f64(1000.0).exp();
        assert!(large.to_bits() > 0x44000000000000000000000000000000);
        assert!(large.to_bits() < 0x7fff0000000000000000000000000000);
        assert!((large.ln().to_bits()).abs_diff(Q::from_f64(1000.0).to_bits()) <= 1);
        assert_eq!(
            Q::from_f64(2.0).pow(Q::from_f64(1000.0)).to_bits(),
            (16383 + 1000) << 112
        );
        assert_eq!(H::from_bits(0x3c00).exp().to_bits(), 0x4170);
        assert_eq!(B::from_bits(0x3f80).exp().to_bits(), 0x402e);
        assert_eq!(
            Q::from_f64(-1.0).ln().to_bits(),
            0x7fff8000000000000000000000000000
        );
    }

    #[test]
    fn sixteen_bit_transcendentals_agree_with_wider_independent_math() {
        use super::{BFloat16 as B, Binary16 as H};
        for bits in 0u16..=u16::MAX {
            for bfloat in [false, true] {
                let quad = if bfloat {
                    B::from_bits(bits).to_quad()
                } else {
                    H::from_bits(bits).to_quad()
                };
                let x = quad.to_f64(); // every half/bfloat value is exact in binary64
                let reference = [x.exp(), x.ln(), x.sin(), x.cos(), x.tan()];
                let actual = if bfloat {
                    let x = B::from_bits(bits);
                    [
                        x.exp().to_bits(),
                        x.ln().to_bits(),
                        x.sin().to_bits(),
                        x.cos().to_bits(),
                        x.tan().to_bits(),
                    ]
                } else {
                    let x = H::from_bits(bits);
                    [
                        x.exp().to_bits(),
                        x.ln().to_bits(),
                        x.sin().to_bits(),
                        x.cos().to_bits(),
                        x.tan().to_bits(),
                    ]
                };
                for (operation, (result, reference)) in
                    actual.into_iter().zip(reference).enumerate()
                {
                    let reference = Q::from_f64(reference);
                    let expected = if bfloat {
                        B::from_quad(reference).to_bits()
                    } else {
                        H::from_quad(reference).to_bits()
                    };
                    let canonical_nan = if bfloat { 0x7fc0 } else { 0x7e00 };
                    if expected == canonical_nan {
                        assert_eq!(result, expected, "NaN {bfloat} {bits:04x} {operation}");
                    } else {
                        assert!(result.abs_diff(expected) <= 1, "format bfloat={bfloat}, input={bits:04x}, op={operation}, result={result:04x}, expected={expected:04x}");
                    }
                }
            }
        }
    }

    #[test]
    fn integer_conversion_rounds_once_and_checks_truncated_magnitude() {
        use super::{parse_bits, BFloat16 as B, Binary16 as H, FloatFormat};
        let midpoint = (1u128 << 120) + (1u128 << 112);
        assert_eq!(B::from_u128(midpoint + 1).to_bits(), 0x7b81);
        assert_eq!(B::from_quad(Q::from_u128(midpoint + 1)).to_bits(), 0x7b80);
        assert_eq!(B::from_u128(midpoint).to_bits(), 0x7b80);
        assert_eq!(B::from_u128(midpoint - 1).to_bits(), 0x7b80);
        assert_eq!(H::from_u128(2049).to_bits(), 0x6800);
        assert_eq!(H::from_u128(2051).to_bits(), 0x6802);
        assert_eq!(
            Q::from_i128(i128::MIN).trunc_integer(),
            Some((true, 1 << 127))
        );
        assert_eq!(
            Q::from_u128(u128::MAX).to_bits(),
            0x407f0000000000000000000000000000
        );
        assert_eq!(Q::from_u128(u128::MAX).trunc_integer(), None);
        assert_eq!(Q::from_f64(-0.5).trunc_integer(), Some((false, 0)));
        assert_eq!(Q::from_f64(-3.75).trunc_integer(), Some((true, 3)));
        for invalid in [f64::INFINITY, f64::NEG_INFINITY, f64::NAN] {
            assert_eq!(Q::from_f64(invalid).trunc_integer(), None);
        }
        for exponent in 0..128 {
            let power = 1u128 << exponent;
            assert_eq!(Q::from_u128(power).trunc_integer(), Some((false, power)));
            for value in [power - 1, power, power.saturating_add(1)] {
                let decimal = value.to_string();
                assert_eq!(
                    Q::from_u128(value).to_bits(),
                    parse_bits(&decimal, FloatFormat::F128).unwrap()
                );
                assert_eq!(
                    B::from_u128(value).to_bits() as u128,
                    parse_bits(&decimal, FloatFormat::BF16).unwrap()
                );
                assert_eq!(
                    H::from_u128(value).to_bits() as u128,
                    parse_bits(&decimal, FloatFormat::F16).unwrap()
                );
            }
        }
    }

    #[test]
    fn numeric_comparison_preserves_quad_bits_and_ieee_unordered_values() {
        use std::cmp::Ordering::*;
        let values = [
            Q::from_f64(f64::NEG_INFINITY),
            Q::from_f64(-1.0),
            Q::from_bits((1 << 127) | 1),
            Q::from_bits(0),
            Q::from_bits(1),
            Q::from_bits(ONE),
            Q::from_bits(ONE + 1),
            Q::from_f64(f64::INFINITY),
        ];
        for (i, a) in values.iter().enumerate() {
            for (j, b) in values.iter().enumerate() {
                assert_eq!(a.numeric_cmp(*b), Some(i.cmp(&j)));
            }
        }
        assert_eq!(
            Q::from_bits(0).numeric_cmp(Q::from_bits(1 << 127)),
            Some(Equal)
        );
        assert_eq!(
            Q::from_bits(ONE + 1).numeric_cmp(Q::from_bits(ONE)),
            Some(Greater)
        );
        for bits in [
            0x7fff0000000000000000000000000001,
            0xffff8000000000000000000000001234,
        ] {
            for a in values {
                assert_eq!(a.numeric_cmp(Q::from_bits(bits)), None);
                assert_eq!(Q::from_bits(bits).numeric_cmp(a), None);
            }
        }
    }

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
