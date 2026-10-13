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
