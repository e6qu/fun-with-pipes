//! Dense F64 linear algebra kernels for the interpreter. The C runtime
//! (runtime/fwp_rt_prims.c) implements the same algorithms with the same
//! operation order, so results agree bit for bit.

/// Solve a·x = b by Gaussian elimination with partial pivoting.
pub fn lu_solve(n: usize, a: &[f64], b: &[f64]) -> Option<Vec<f64>> {
    let mut a = a.to_vec();
    let mut x = b.to_vec();
    for k in 0..n {
        let mut p = k;
        for i in k + 1..n {
            if a[i * n + k].abs() > a[p * n + k].abs() {
                p = i;
            }
        }
        if a[p * n + k] == 0.0 {
            return None;
        }
        if p != k {
            for j in 0..n {
                a.swap(k * n + j, p * n + j);
            }
            x.swap(k, p);
        }
        for i in k + 1..n {
            let f = a[i * n + k] / a[k * n + k];
            for j in k..n {
                a[i * n + j] -= f * a[k * n + j];
            }
            x[i] -= f * x[k];
        }
    }
    for i in (0..n).rev() {
        let mut s = x[i];
        for j in i + 1..n {
            s -= a[i * n + j] * x[j];
        }
        x[i] = s / a[i * n + i];
    }
    Some(x)
}

pub fn det(n: usize, a: &[f64]) -> f64 {
    let mut a = a.to_vec();
    let mut d = 1.0;
    for k in 0..n {
        let mut p = k;
        for i in k + 1..n {
            if a[i * n + k].abs() > a[p * n + k].abs() {
                p = i;
            }
        }
        if a[p * n + k] == 0.0 {
            return 0.0;
        }
        if p != k {
            for j in 0..n {
                a.swap(k * n + j, p * n + j);
            }
            d = -d;
        }
        d *= a[k * n + k];
        for i in k + 1..n {
            let f = a[i * n + k] / a[k * n + k];
            for j in k..n {
                a[i * n + j] -= f * a[k * n + j];
            }
        }
    }
    d
}

/// Gauss–Jordan inverse with partial pivoting.
pub fn inverse(n: usize, a: &[f64]) -> Option<Vec<f64>> {
    let mut a = a.to_vec();
    let mut inv = vec![0.0; n * n];
    for i in 0..n {
        inv[i * n + i] = 1.0;
    }
    for k in 0..n {
        let mut p = k;
        for i in k + 1..n {
            if a[i * n + k].abs() > a[p * n + k].abs() {
                p = i;
            }
        }
        if a[p * n + k] == 0.0 {
            return None;
        }
        if p != k {
            for j in 0..n {
                a.swap(k * n + j, p * n + j);
                inv.swap(k * n + j, p * n + j);
            }
        }
        let d = a[k * n + k];
        for j in 0..n {
            a[k * n + j] /= d;
            inv[k * n + j] /= d;
        }
        for i in 0..n {
            if i != k {
                let f = a[i * n + k];
                for j in 0..n {
                    a[i * n + j] -= f * a[k * n + j];
                    inv[i * n + j] -= f * inv[k * n + j];
                }
            }
        }
    }
    Some(inv)
}

pub fn cholesky(n: usize, a: &[f64]) -> Option<Vec<f64>> {
    let mut l = vec![0.0; n * n];
    for i in 0..n {
        for j in 0..=i {
            let mut s = a[i * n + j];
            for k in 0..j {
                s -= l[i * n + k] * l[j * n + k];
            }
            if i == j {
                if s <= 0.0 {
                    return None;
                }
                l[i * n + j] = s.sqrt();
            } else {
                l[i * n + j] = s / l[j * n + j];
            }
        }
    }
    Some(l)
}

/// Modified Gram–Schmidt: a (m×n) = q (m×n) · r (n×n).
pub fn qr(m: usize, n: usize, a: &[f64]) -> (Vec<f64>, Vec<f64>) {
    let mut q = a.to_vec();
    let mut r = vec![0.0; n * n];
    for j in 0..n {
        for i in 0..j {
            let mut d = 0.0;
            for k in 0..m {
                d += q[k * n + i] * q[k * n + j];
            }
            r[i * n + j] = d;
            for k in 0..m {
                q[k * n + j] -= d * q[k * n + i];
            }
        }
        let mut s = 0.0;
        for k in 0..m {
            s += q[k * n + j] * q[k * n + j];
        }
        let norm = s.sqrt();
        r[j * n + j] = norm;
        if norm != 0.0 {
            for k in 0..m {
                q[k * n + j] /= norm;
            }
        }
    }
    (q, r)
}

/// Conjugate gradient for symmetric positive-definite a.
pub fn cg(max_iter: i64, tol: f64, n: usize, a: &[f64], b: &[f64]) -> Vec<f64> {
    let dot = |x: &[f64], y: &[f64]| {
        let mut s = 0.0;
        for i in 0..n {
            s += x[i] * y[i];
        }
        s
    };
    let mut x = vec![0.0; n];
    let mut r = b.to_vec();
    let mut p = r.clone();
    let mut rs = dot(&r, &r);
    let mut ap = vec![0.0; n];
    for _ in 0..max_iter.max(0) {
        if rs.sqrt() <= tol {
            break;
        }
        for i in 0..n {
            let mut s = 0.0;
            for j in 0..n {
                s += a[i * n + j] * p[j];
            }
            ap[i] = s;
        }
        let alpha = rs / dot(&p, &ap);
        for i in 0..n {
            x[i] += alpha * p[i];
            r[i] -= alpha * ap[i];
        }
        let rs_new = dot(&r, &r);
        let beta = rs_new / rs;
        for i in 0..n {
            p[i] = r[i] + beta * p[i];
        }
        rs = rs_new;
    }
    x
}
