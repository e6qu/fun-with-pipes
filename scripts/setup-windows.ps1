# Native Windows C toolchain, pinned to upstream release assets and digests.
# https://github.com/mstorsjo/llvm-mingw/releases/tag/20261006
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
switch ($env:RUNNER_ARCH) {
    'ARM64' {
        $architecture = 'aarch64'
        $digest = '9a835d5179c9f3a5a783c11a7f14062a249b4765dd11add64a66786864e82ab2'
    }
    'X64' {
        $architecture = 'x86_64'
        $digest = '317492c456aa27ee607a5919f1d2d38dcdc1112516a24d0bf4b00d078f52d17a'
    }
    default { throw "Unsupported runner architecture: $env:RUNNER_ARCH" }
}
$package = "llvm-mingw-20261006-ucrt-$architecture"
$archive = Join-Path $env:RUNNER_TEMP "$package.zip"
Invoke-WebRequest "https://github.com/mstorsjo/llvm-mingw/releases/download/20261006/$package.zip" -OutFile $archive
if ((Get-FileHash $archive -Algorithm SHA256).Hash.ToLowerInvariant() -ne $digest) {
    throw 'LLVM-MinGW archive checksum mismatch'
}
Expand-Archive $archive -DestinationPath $env:RUNNER_TEMP
$compilerBin = Join-Path $env:RUNNER_TEMP "$package/bin"
Add-Content $env:GITHUB_PATH $compilerBin
Add-Content $env:GITHUB_ENV "CC=$compilerBin/$architecture-w64-mingw32-clang.exe"
& "$compilerBin/$architecture-w64-mingw32-clang.exe" --version
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
