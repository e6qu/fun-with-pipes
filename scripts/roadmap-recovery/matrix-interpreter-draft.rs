// Internal specialization primitives borrow immutable matrix storage.
type MatrixProduct<'a> = (usize, usize, usize, &'a [Value], &'a [Value]);
fn matrix_product_shape<'a>(b: &'a Value, a: &'a Value) -> Option<MatrixProduct<'a>> {
    let (Value::Record(a), Value::Record(b)) = (a, b) else { return None; };
    if a.len()!=3 || b.len()!=3 { return None; }
    let (m,k,br,n)=(usize::try_from(int(&a[2])).ok()?,usize::try_from(int(&a[0])).ok()?,usize::try_from(int(&b[2])).ok()?,usize::try_from(int(&b[0])).ok()?);
    if br!=k { return None; }
    let (Value::Array(left),Value::Array(right))=(&a[1],&b[1]) else {return None;};
    let limit=(usize::MAX-8)/8;
    let (ak,bk,out)=(m.checked_mul(k)?,k.checked_mul(n)?,m.checked_mul(n)?);
    if ak>limit || bk>limit || out>limit || left.len()!=ak || right.len()!=bk {return None;}
    Some((m,k,n,left,right))
}
fn matrix_product(b: &Value,a: &Value) -> R<Value> {
    let Some((m,k,n,left,right))=matrix_product_shape(b,a) else {return trap("invalid internal matrix shape");};
    let mut result=vec![0.0f64;m*n];
    if n!=0 && k!=0 {
        for ib in (0..m).step_by(32) {
            for kb in (0..k).step_by(32) {
                for jb in (0..n).step_by(32) {
                    for i in ib..(ib+32).min(m) {
                        for q in kb..(kb+32).min(k) {
                            let x=left[i*k+q].as_f64().unwrap();
                            for j in jb..(jb+32).min(n) {
                                let product=x*right[q*n+j].as_f64().unwrap();
                                result[i*n+j]=product+result[i*n+j];
                            }
                        }
                    }
                }
            }
        }
    }
    Ok(f64_array(&result))
}
