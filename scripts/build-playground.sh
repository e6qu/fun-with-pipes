#!/bin/sh
# Build the playground (web/): fwp itself compiled to WebAssembly
# (web/fwp.wasm) and the example programs (web/examples/). Then serve the
# directory over HTTP, for example:
#
#   scripts/build-playground.sh && python3 -m http.server -d web 8000
#
# Needs the Rust target: rustup target add wasm32-wasip1
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"

cargo build --release --target wasm32-wasip1
cp target/wasm32-wasip1/release/fwp.wasm web/fwp.wasm

# Examples: the tutorials that fwp.wasm can run, then two programs from examples/. Each is
# web/examples/<name>.fwp; index.txt lists the names in order, each
# followed by " <name>.in" when the example comes with standard input.
out=web/examples
rm -rf "$out"
mkdir -p "$out"
: > "$out/index.txt"
for dir in docs/tutorials/*/; do
    name=$(basename "$dir")
    [ -f "$dir/main.fwp" ] || continue
    # what the WebAssembly build of fwp cannot run: tasks, sockets, C
    if grep -qE '(task|channel|tcp|udp|http)\.|foreign "C"' "$dir/main.fwp"; then
        continue
    fi
    cp "$dir/main.fwp" "$out/$name.fwp"
    echo "$name" >> "$out/index.txt"
done
cp examples/hello.fwp "$out/hello.fwp"
echo hello >> "$out/index.txt"
cp examples/wordfreq.fwp "$out/wordfreq.fwp"
cp tests/run/wordfreq.in "$out/wordfreq.in"
echo "wordfreq wordfreq.in" >> "$out/index.txt"

echo "built web/fwp.wasm ($(wc -c < web/fwp.wasm) bytes) and $(wc -l < "$out/index.txt") examples"
