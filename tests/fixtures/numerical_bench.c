#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#ifndef PROFILE
#define PROFILE 0
#endif
static uint64_t requested,calls,live_bytes,peak_bytes;
static uint64_t now_ns(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC,&t);return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;}
static void *allocate(size_t n){void *p=malloc(n);if(!p)abort();if(PROFILE){calls++;requested+=n;live_bytes+=n;if(live_bytes>peak_bytes)peak_bytes=live_bytes;}return p;}
static void release(void *p,size_t n){if(PROFILE)live_bytes-=n;free(p);}
static uint64_t bits(double x){uint64_t b;memcpy(&b,&x,8);return b;}
static double consume_array(double *input,size_t n){
    double sum=-0.0;for(size_t i=0;i<n;i++){double mapped=input[i]*3.0;mapped=mapped+1.0;sum=mapped+sum;}
    release(input,n*8);return sum;
}
static void matrix_kernel(const double *a,const double *b,double *out,size_t m,size_t k,size_t n){
    const size_t tile=32;
    for(size_t ib=0;ib<m;ib+=tile)for(size_t kb=0;kb<k;kb+=tile)for(size_t jb=0;jb<n;jb+=tile){
        size_t ie=ib+tile<m?ib+tile:m,ke=kb+tile<k?kb+tile:k,je=jb+tile<n?jb+tile:n;
        for(size_t i=ib;i<ie;i++)for(size_t q=kb;q<ke;q++)for(size_t j=jb;j<je;j++){
            double product=a[i*k+q]*b[q*n+j];out[i*n+j]=product+out[i*n+j];
        }
    }
}
int main(int argc,char **argv){
    if(argc!=2)return 1;int matrix=!strcmp(argv[1],"matrix");
    const size_t elements=65537,m=65,k=67,n=63,rounds=8;
    puts("{\"samples\":[");
    for(size_t sample=0;sample<5;sample++){
        requested=calls=live_bytes=peak_bytes=0;uint64_t kernel_ns=0,hash=1469598103934665603ULL,start=now_ns();
        for(size_t round=0;round<rounds;round++){
            if(!matrix){
                double *a=allocate(elements*8);for(size_t i=0;i<elements;i++)a[i]=((double)(int)((i+round)%19)-9.0)/4.0;
                __asm__ volatile("" : "+r"(a) :: "memory");uint64_t before=now_ns();double result=consume_array(a,elements);kernel_ns+=now_ns()-before;
                hash=(hash^bits(result))*1099511628211ULL;
            }else{
                double *a=allocate(m*k*8),*b=allocate(k*n*8),*out=allocate(m*n*8);memset(out,0,m*n*8);
                for(size_t i=0;i<m*k;i++)a[i]=((double)(int)((i+round)%19)-9.0)/4.0;
                for(size_t i=0;i<k*n;i++)b[i]=((double)(int)((i+round)%13)-6.0)/8.0;
                __asm__ volatile("" : "+r"(a), "+r"(b) :: "memory");uint64_t before=now_ns();matrix_kernel(a,b,out,m,k,n);kernel_ns+=now_ns()-before;
                for(size_t i=0;i<m*n;i++)hash=(hash^bits(out[i]))*1099511628211ULL;
                release(out,m*n*8);release(a,m*k*8);release(b,k*n*8);
            }
        }
        uint64_t elapsed=now_ns()-start;if(live_bytes)return 2;
        printf("%s{\"allocationInclusiveNs\":%llu,\"kernelNs\":%llu,\"hash\":\"%016llx\",\"requests\":%llu,\"requestedBytes\":%llu,\"livePayloadBytes\":%llu,\"peakPayloadBytes\":%llu}",sample?",\n":"",(unsigned long long)elapsed,(unsigned long long)kernel_ns,(unsigned long long)hash,(unsigned long long)calls,(unsigned long long)requested,(unsigned long long)live_bytes,(unsigned long long)peak_bytes);
    }
    puts("]}");return 0;
}
