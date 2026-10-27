#!/usr/bin/env bash
# Keep the compiler, linker and WASI compiler-runtime libraries on LLVM 18.
# An unversioned Ubuntu clang package can advance independently of those libs.
set -euo pipefail

test "${GITHUB_ACTIONS:-}" = true
test "$(uname -s)" = Linux
: "${GITHUB_ENV:?GitHub environment file is required}"
: "${GITHUB_PATH:?GitHub path file is required}"

sudo apt-get -o Acquire::http::Timeout=30 -o Acquire::https::Timeout=30 \
    -o APT::Update::Error-Mode=any update
sudo env DEBIAN_FRONTEND=noninteractive apt-get \
    -o Acquire::http::Timeout=30 -o Acquire::https::Timeout=30 \
    -o DPkg::Lock::Timeout=60 install -y \
    clang-18 llvm-18 lld-18 wabt wasi-libc \
    libclang-rt-18-dev-wasm32 libc++-18-dev-wasm32

printf '/usr/lib/llvm-18/bin\n' >> "$GITHUB_PATH"
printf 'FWP_WASM_CC=/usr/bin/clang-18\n' >> "$GITHUB_ENV"
/usr/bin/clang-18 --version
/usr/bin/clang-18 --print-resource-dir

# Fail here with the linker diagnostic, before spending time building fwp.
wasi_probe_dir=$(mktemp -d)
trap 'rm -rf "$wasi_probe_dir"' EXIT
printf 'int main(void) { return 0; }\n' > "$wasi_probe_dir/probe.c"
/usr/bin/clang-18 --target=wasm32-wasi -fuse-ld=/usr/bin/wasm-ld-18 \
    "$wasi_probe_dir/probe.c" -o "$wasi_probe_dir/probe.wasm"
