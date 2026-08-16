<#
.SYNOPSIS
    Script otomatis untuk merilis APK Beta ke GitHub Releases CloudStreamXR-Beta,
    memperbarui update.json, dan memicu pembersihan cache jsDelivr CDN.
.EXAMPLE
    .\publish_beta.ps1 -ApkPath "E:\proyyek\cloudsterm\CloudStream\app\build\outputs\apk\prerelease\release\app-prerelease-release.apk" -VersionName "4.8.0-BETA" -VersionCode 79781056 -Changelog "Fix SSL & Video OkHttp"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$ApkPath,

    [Parameter(Mandatory=$false)]
    [string]$VersionName = "4.8.0-BETA",

    [Parameter(Mandatory=$false)]
    [int]$VersionCode = 79781056,

    [Parameter(Mandatory=$false)]
    [string]$Changelog = "Pembaruan otomatis CloudStreamXR Beta",

    [Parameter(Mandatory=$false)]
    [bool]$ForceUpdate = $false
)

$ErrorActionPreference = "Stop"

$repo = "xr3ed/CloudStreamXR-Beta"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "==> [1/4] Memeriksa file APK..." -ForegroundColor Cyan
if (-not (Test-Path $ApkPath)) {
    Write-Error "File APK tidak ditemukan pada: $ApkPath"
}

$buildTime = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
$tag = "$VersionName-$((Get-Date).ToString('ddMMyyHHmm'))"
$apkFileName = "CloudStreamXR-Beta_$buildTime.apk"

# Salin APK dengan nama unik
$tempApk = Join-Path $env:TEMP $apkFileName
Copy-Item -Path $ApkPath -Destination $tempApk -Force

Write-Host "==> [2/4] Mengunggah Release ke GitHub ($repo Tag: $tag)..." -ForegroundColor Cyan
gh release create $tag $tempApk --repo $repo --title "CloudStreamXR Beta $tag" --notes $Changelog --prerelease

$apkDownloadUrl = "https://github.com/$repo/releases/download/$tag/$apkFileName"
Write-Host "    APK URL: $apkDownloadUrl" -ForegroundColor Green

Write-Host "==> [3/4] Memperbarui update.json..." -ForegroundColor Cyan
$updateJsonPath = Join-Path $scriptDir "update.json"
$updateData = @{
    versionCode = $VersionCode
    versionName = $VersionName
    apkUrl      = $apkDownloadUrl
    changelog   = $Changelog
    forceUpdate = $ForceUpdate
    buildTime   = $buildTime
}

$jsonContent = $updateData | ConvertTo-Json -Depth 4
[System.IO.File]::WriteAllText($updateJsonPath, $jsonContent, [System.Text.Encoding]::UTF8)

Write-Host "==> [4/4] Melakukan Commit dan Push ke Branch main..." -ForegroundColor Cyan
Push-Location $scriptDir
try {
    git add update.json
    git commit -m "Update update.json to $tag"
    git push origin main
    Write-Host "==> Rilis Berhasil! Workflow Purge CDN jsDelivr otomatis terpicu." -ForegroundColor Green
} finally {
    Pop-Location
    if (Test-Path $tempApk) { Remove-Item $tempApk -Force }
}
