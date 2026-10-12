use std::hint::black_box;
use std::time::Instant;
#[cfg(memory_profile)]
mod memory {
    use std::alloc::{GlobalAlloc,Layout,System};use std::sync::atomic::{AtomicU64,Ordering::Relaxed};
    pub static CALLS:AtomicU64=AtomicU64::new(0);pub static REQUESTED:AtomicU64=AtomicU64::new(0);pub static LIVE:AtomicU64=AtomicU64::new(0);pub static PEAK:AtomicU64=AtomicU64::new(0);
    pub struct Counted;
    unsafe impl GlobalAlloc for Counted {
        unsafe fn alloc(&self,l:Layout)->*mut u8 {let p=unsafe{System.alloc(l)};if !p.is_null(){CALLS.fetch_add(1,Relaxed);REQUESTED.fetch_add(l.size() as u64,Relaxed);let live=LIVE.fetch_add(l.size() as u64,Relaxed)+l.size() as u64;PEAK.fetch_max(live,Relaxed);}p}
        unsafe fn dealloc(&self,p:*mut u8,l:Layout){LIVE.fetch_sub(l.size() as u64,Relaxed);unsafe{System.dealloc(p,l)}}
    }
    #[global_allocator]static ALLOCATOR:Counted=Counted;
    pub fn snapshot()->[u64;4]{[CALLS.load(Relaxed),REQUESTED.load(Relaxed),LIVE.load(Relaxed),PEAK.load(Relaxed)]}
    pub fn peak_reset(){PEAK.store(LIVE.load(Relaxed),Relaxed);}
}
#[cfg(not(memory_profile))]mod memory{pub fn snapshot()->[u64;4]{[0;4]}pub fn peak_reset(){}}
fn consume_array(input:Vec<f64>)->f64 {let mut sum=-0.0;for x in input{let mapped=x*3.0;let mapped=mapped+1.0;sum=mapped+sum;}sum}
fn matrix_kernel(a:&[f64],b:&[f64],out:&mut[f64],m:usize,k:usize,n:usize){
    const TILE:usize=32;
    for ib in (0..m).step_by(TILE){for kb in (0..k).step_by(TILE){for jb in (0..n).step_by(TILE){
        for i in ib..(ib+TILE).min(m){for q in kb..(kb+TILE).min(k){for j in jb..(jb+TILE).min(n){
            let product=a[i*k+q]*b[q*n+j];let prior=out[i*n+j];out[i*n+j]=product+prior;
        }}}
    }}}
}
fn main(){
    let matrix=std::env::args().nth(1).unwrap()=="matrix";let(elements,m,k,n,rounds)=(65537,65,67,63,8);
    println!("{{\"samples\":[");
    for sample in 0..5 {
        memory::peak_reset();let before_memory=memory::snapshot();let mut kernel_ns=0u128;let mut hash=1469598103934665603u64;let start=Instant::now();
        for round in 0..rounds{
            if !matrix{
                let input:Vec<f64>=(0..elements).map(|i|(((i+round)%19) as i32-9) as f64/4.0).collect();
                let before=Instant::now();let value=consume_array(black_box(input));kernel_ns+=before.elapsed().as_nanos();hash=(hash^value.to_bits()).wrapping_mul(1099511628211);
            }else{
                let a:Vec<f64>=(0..m*k).map(|i|(((i+round)%19) as i32-9) as f64/4.0).collect();
                let b:Vec<f64>=(0..k*n).map(|i|(((i+round)%13) as i32-6) as f64/8.0).collect();
                let mut out=vec![0.0;m*n];let before=Instant::now();matrix_kernel(black_box(&a),black_box(&b),&mut out,m,k,n);kernel_ns+=before.elapsed().as_nanos();
                for x in out{hash=(hash^x.to_bits()).wrapping_mul(1099511628211);}
            }
        }
        let elapsed=start.elapsed().as_nanos();let after=memory::snapshot();assert_eq!(after[2],before_memory[2]);
        println!("{}{{\"allocationInclusiveNs\":{},\"kernelNs\":{},\"hash\":\"{:016x}\",\"requests\":{},\"requestedBytes\":{},\"livePayloadBytes\":{},\"peakPayloadBytes\":{}}}",if sample==0{""}else{","},elapsed,kernel_ns,hash,after[0]-before_memory[0],after[1]-before_memory[1],after[2]-before_memory[2],after[3]-before_memory[2]);
    }
    println!("]}}");
}
