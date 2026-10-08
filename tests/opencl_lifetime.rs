//! OpenCL API ownership, exercised with a loader-visible fake implementation.
//! This checks resource cleanup without claiming hardware GPU coverage.
use fwp::ir::*;
use std::process::Command;

const STATE: &str = r#"
struct state { int context, queue, finish, release_queue, release_context, unload, bad, at_exit; };
"#;

#[test]
fn opencl_load_failures_and_library_unload_release_external_owners() {
    let program = Program {
        funcs: vec![Func {
            name: "available".into(),
            arity: 0,
            locals: vec![],
            ty: MT::con("std::Bool"),
            body: Body::Prim("device.gpu-available".into()),
        }],
        exports: vec![("available".into(), 0)],
        ..Program::default()
    };
    let (generated, header) = fwp::cgen::generate_library(&program, "gpu").unwrap();
    let stub = format!(
        r#"
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <stdio.h>
{STATE}
static struct state fallback={{.at_exit=1}};static struct state *s=&fallback;static int mode;static int platform,device,context,queue;
void fake_setup(struct state *state,int m){{s=state;mode=m;}}
static void __attribute__((destructor)) unloaded(void){{if(s){{s->unload++;if(s->at_exit)puts(s->bad||s->context!=1||s->queue!=1||
 s->finish!=1||s->release_queue!=1||s->release_context!=1?"bad cleanup":"released");}}}}
int32_t clGetPlatformIDs(uint32_t n,void **p,uint32_t *count){{
 if(count)*count=mode==1?0:1;if(n&&p)*p=&platform;return 0;
}}
#ifndef MISSING_SYMBOL
int32_t clGetDeviceIDs(void *p,uint64_t ty,uint32_t n,void **d,uint32_t *count){{
 (void)p;(void)ty;if(count)*count=1;if(n&&d)*d=&device;return 0;
}}
#endif
int32_t clGetDeviceInfo(void *d,uint32_t key,size_t size,void *out,size_t *n){{
 (void)d;(void)key;const char *v="cl_khr_fp64";if(n)*n=strlen(v)+1;
 if(size<strlen(v)+1)return -1;strcpy(out,v);return 0;
}}
void *clCreateContext(const intptr_t *props,uint32_t n,const void **ds,void *fn,void *arg,int32_t *err){{
 (void)props;(void)n;(void)ds;(void)fn;(void)arg;
 if(mode==2){{*err=-12;return 0;}}*err=0;s->context++;return &context;
}}
void *clCreateCommandQueue(void *ctx,void *d,uint64_t props,int32_t *err){{
 (void)d;(void)props;if(ctx!=&context)s->bad=1;
 if(mode==3){{*err=-13;return 0;}}*err=0;s->queue++;return &queue;
}}
int32_t clFinish(void *q){{if(q!=&queue)s->bad=1;s->finish++;return 0;}}
int32_t clReleaseCommandQueue(void *q){{if(q!=&queue||s->release_context)s->bad=1;s->release_queue++;return 0;}}
int32_t clReleaseContext(void *c){{if(c!=&context||s->queue!=s->release_queue)s->bad=1;s->release_context++;return 0;}}
int32_t clCreateProgramWithSource(void){{return -1;}}
int32_t clBuildProgram(void){{return -1;}}
int32_t clGetProgramBuildInfo(void){{return -1;}}
int32_t clCreateKernel(void){{return -1;}}
int32_t clCreateBuffer(void){{return -1;}}
int32_t clSetKernelArg(void){{return -1;}}
int32_t clEnqueueNDRangeKernel(void){{return -1;}}
int32_t clEnqueueReadBuffer(void){{return -1;}}
int32_t clReleaseMemObject(void){{return -1;}}
int32_t clReleaseKernel(void){{return -1;}}
int32_t clReleaseProgram(void){{return -1;}}
"#
    );
    let host = format!(
        r#"
#include <dlfcn.h>
#include <stdlib.h>
#include <stdbool.h>
{STATE}
static struct state s;
int main(int argc,char **argv){{
 if(argc!=4)return 30;int mode=atoi(argv[3]);
 void *fake=dlopen(argv[1],RTLD_NOW|RTLD_LOCAL);if(!fake)return 31;
 void (*setup)(struct state *,int)=dlsym(fake,"fake_setup");if(!setup)return 32;setup(&s,mode);
 void *lib=dlopen(argv[2],RTLD_NOW|RTLD_LOCAL);if(!lib)return 33;
 bool (*available)(void)=dlsym(lib,"available");if(!available)return 34;
 if(available()!=(mode==0)||available()!=(mode==0))return 1;
 if(mode&&s.context!=s.release_context)return 2;
 if(dlclose(fake))return 35;
 if(mode&&s.unload!=1)return 3;
 if(dlclose(lib))return 36;
 if(s.bad||s.context!=s.release_context)return 2;
 if(s.queue!=s.release_queue||s.finish!=(mode==0?1:0))return 4;
 if(s.unload!=1)return 3;
 return 0;
}}
"#
    );
    let static_host = format!(
        r#"
#include <dlfcn.h>
#include <stdbool.h>
#include <stdio.h>
{STATE}
extern bool available(void);
static struct state s;
int main(int argc,char **argv){{
 if(argc!=2)return 30;void *fake=dlopen(argv[1],RTLD_NOW|RTLD_LOCAL);if(!fake)return 31;
 void (*setup)(struct state *,int)=dlsym(fake,"fake_setup");if(!setup)return 32;setup(&s,0);s.at_exit=1;
 if(!available()||!available())return 1;dlclose(fake);puts("main");return 0;
}}
"#
    );
    let controls = [
        (
            "        fwp_cl.release_queue(fwp_cl.queue);",
            "        /* missing queue release */",
            2,
        ),
        (
            "        fwp_cl.release_context(fwp_cl.context);",
            "        /* missing context release */",
            2,
        ),
        (
            "        dlclose(fwp_cl.library);",
            "        /* missing loader release */",
            3,
        ),
        (
            "        fwp_cl.finish(fwp_cl.queue);",
            "        /* missing queue drain */",
            4,
        ),
        (
            "    fwp_caf_finish();\n    fwp_cl_finish();",
            "    fwp_caf_finish(); /* missing library GPU finish */",
            2,
        ),
    ];
    let dir = std::env::temp_dir().join(format!("fwp-opencl-owners-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let lib = dir.join(format!("libgpu.{}", fwp::cgen::shared_library_extension()));
    let fake = dir.join(format!("libfake.{}", fwp::cgen::shared_library_extension()));
    let exe = dir.join("host");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_library(&generated, &header, &lib, opt, fwp::cgen::LibKind::Shared)
            .unwrap();
        fwp::cgen::compile_c(&host, &exe, opt).unwrap();
        for mode in 0..=4 {
            let source = if mode == 4 {
                format!("#define MISSING_SYMBOL 1\n{stub}")
            } else {
                stub.clone()
            };
            fwp::cgen::compile_library(&source, "", &fake, opt, fwp::cgen::LibKind::Shared)
                .unwrap();
            let out = Command::new(&exe)
                .args([&fake, &lib])
                .arg(mode.to_string())
                .env("FWP_OPENCL_LIB", &fake)
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "{opt}, mode {mode}: {:?}: {}",
                out.status.code(),
                String::from_utf8_lossy(&out.stderr)
            );
        }
        fwp::cgen::compile_library(&stub, "", &fake, opt, fwp::cgen::LibKind::Shared).unwrap();
        let archive = dir.join("libgpu.a");
        fwp::cgen::compile_library(
            &generated,
            &header,
            &archive,
            opt,
            fwp::cgen::LibKind::Static,
        )
        .unwrap();
        let previous = fwp::ffi::links();
        fwp::ffi::set_links(vec![archive.to_string_lossy().into_owned()]);
        let result = fwp::cgen::compile_c(&static_host, &dir.join("static-host"), opt);
        fwp::ffi::set_links(previous);
        result.unwrap();
        let out = Command::new(dir.join("static-host"))
            .arg(&fake)
            .env("FWP_OPENCL_LIB", &fake)
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "static {opt}: {:?}",
            out.status.code()
        );
        assert_eq!(String::from_utf8_lossy(&out.stdout), "main\nreleased\n");
        let mut executable = program.clone();
        executable.main = Some(0);
        let source = fwp::cgen::generate(&executable).unwrap();
        fwp::cgen::compile_c(&source, &dir.join("program"), opt).unwrap();
        let out = Command::new(dir.join("program"))
            .env("FWP_OPENCL_LIB", &fake)
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "executable {opt}: {:?}: {}",
            out.status.code(),
            String::from_utf8_lossy(&out.stderr)
        );
        assert_eq!(String::from_utf8_lossy(&out.stdout), "released\n");
        let exit_registration =
            "    if (atexit(fwp_lib_finish)) fwp_trap(\"cannot register library cleanup\");";
        assert!(generated.contains(exit_registration));
        let broken = generated.replacen(
            exit_registration,
            "    /* missing early exit registration */",
            1,
        );
        fwp::cgen::compile_library(&broken, &header, &archive, opt, fwp::cgen::LibKind::Static)
            .unwrap();
        let previous = fwp::ffi::links();
        fwp::ffi::set_links(vec![archive.to_string_lossy().into_owned()]);
        let result = fwp::cgen::compile_c(&static_host, &dir.join("static-control"), opt);
        fwp::ffi::set_links(previous);
        result.unwrap();
        let out = Command::new(dir.join("static-control"))
            .arg(&fake)
            .env("FWP_OPENCL_LIB", &fake)
            .output()
            .unwrap();
        assert!(out.status.success());
        // Darwin terminates images before archive destructors; Linux may run
        // the archive destructor first, so its ordinary unload path suffices.
        if cfg!(target_os = "macos") {
            assert_eq!(String::from_utf8_lossy(&out.stdout), "main\nbad cleanup\n");
        }
        let broken = source.replacen(
            "    fwp_caf_finish();\n    fwp_cl_finish();",
            "    fwp_caf_finish(); /* missing executable GPU finish */",
            1,
        );
        assert_ne!(broken, source);
        fwp::cgen::compile_c(&broken, &dir.join("executable-control"), opt).unwrap();
        let out = Command::new(dir.join("executable-control"))
            .env("FWP_OPENCL_LIB", &fake)
            .output()
            .unwrap();
        assert!(out.status.success());
        assert_eq!(String::from_utf8_lossy(&out.stdout), "bad cleanup\n");
        for (needle, replacement, expected) in controls {
            assert!(generated.contains(needle), "missing control {needle}");
            let broken = generated.replacen(needle, replacement, 1);
            fwp::cgen::compile_library(&broken, &header, &lib, opt, fwp::cgen::LibKind::Shared)
                .unwrap();
            let out = Command::new(&exe)
                .args([&fake, &lib])
                .arg("0")
                .env("FWP_OPENCL_LIB", &fake)
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{opt}, control {needle}: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
