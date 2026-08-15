# Tải zapret-win-bundle (zapret2: winws2.exe + cygwin + blockcheck2) về module repo.
# Nguồn: https://github.com/bol-van/zapret-win-bundle (master, ~16MB)
# Cách dùng:  powershell -NoProfile -ExecutionPolicy Bypass -File scripts/download_zapret_binaries.ps1
# Kết quả:    <repo-root>\bundle\zapret-win-bundle\  (chứa zapret-winws\winws2.exe, blockcheck\zapret2\blockcheck2.sh)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot   # <repo-root>/scripts -> <repo-root>
$destRoot = Join-Path $repoRoot "bundle"       # <repo-root>/bundle

$url = "https://github.com/bol-van/zapret-win-bundle/archive/refs/heads/master.zip"
$zip = Join-Path $env:TEMP "zapret-win-bundle.zip"
$extract = Join-Path $env:TEMP "zapret-win-bundle-extract"

Write-Host "Downloading $url ..."
Invoke-WebRequest -Uri $url -OutFile $zip
Write-Host "Extracting..."
if (Test-Path $extract) { Remove-Item -Recurse -Force $extract }
Expand-Archive -Path $zip -DestinationPath $extract -Force

$final = Join-Path $destRoot "zapret-win-bundle"
if (Test-Path $final) { Remove-Item -Recurse -Force $final }
New-Item -ItemType Directory -Force -Path $destRoot | Out-Null
Move-Item (Join-Path $extract "zapret-win-bundle-master") $final

Remove-Item $zip -Force

Write-Host ""
Write-Host "Bundle: $final"
Write-Host "   winws2:     $final\zapret-winws\winws2.exe"
Write-Host "   blockcheck2: $final\blockcheck\zapret2\blockcheck2.sh"
