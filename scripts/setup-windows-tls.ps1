# Native OpenSSL headers, COFF import libraries, DLLs and command-line tools.
# The pinned vcpkg port verifies its upstream OpenSSL source with SHA512.
$ErrorActionPreference = 'Stop'
$revision = 'a49354a70d4f05a673bc9cd864b9b86f68dd92d3'
$triplet = switch ($env:RUNNER_ARCH) {
    'ARM64' { 'arm64-windows' }
    'X64' { 'x64-windows' }
    default { throw "Unsupported runner architecture: $env:RUNNER_ARCH" }
}
$install = Join-Path $env:RUNNER_TEMP 'fwp-windows-deps'
$prefix = Join-Path $install $triplet
if (!(Test-Path (Join-Path $prefix 'tools/openssl/openssl.exe')) -or
    !(Test-Path (Join-Path $prefix 'tools/curl/curl.exe'))) {
    $checkout = Join-Path $env:RUNNER_TEMP 'fwp-vcpkg'
    git init $checkout
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    git -C $checkout remote add origin https://github.com/microsoft/vcpkg.git
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    git -C $checkout fetch --depth 1 origin $revision
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    git -C $checkout checkout --detach $revision
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    & "$checkout/bootstrap-vcpkg.bat" -disableMetrics
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    $env:VCPKG_MAX_CONCURRENCY = '2'
    & "$checkout/vcpkg.exe" install "openssl[tools]:$triplet" "curl[core,openssl,http2,tool]:$triplet" "--host-triplet=$triplet" "--x-install-root=$install" --clean-after-build
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}
Add-Content $env:GITHUB_ENV 'FWP_WINDOWS_DEPS_READY=1'
$env:PATH = "$prefix/bin;$prefix/tools/openssl;$env:PATH"
Add-Content $env:GITHUB_ENV "FWP_OPENSSL_DIR=$prefix"
Add-Content $env:GITHUB_ENV 'FWP_REQUIRE_TLS=1'
Add-Content $env:GITHUB_PATH "$prefix/bin"
Add-Content $env:GITHUB_PATH "$prefix/tools/openssl"
# The system and Git curl use Schannel. Build the pinned native curl port
# explicitly with OpenSSL for these PEM client-key peer fixtures.
$curl = Join-Path $prefix 'tools/curl/curl.exe'
if (!(Test-Path $curl)) { throw "Native OpenSSL curl not found: $curl" }
$curlVersion = & $curl --version
if ($LASTEXITCODE -ne 0 -or ($curlVersion -join "`n") -notmatch 'OpenSSL/' -or ($curlVersion -join "`n") -notmatch 'HTTP2') {
    throw "TLS peer tests require the OpenSSL curl client: $curlVersion"
}
Write-Output $curlVersion
Add-Content $env:GITHUB_ENV "FWP_TEST_CURL=$curl"
& "$prefix/tools/openssl/openssl.exe" version -a
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
python scripts/check-windows-tls.py $prefix
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
