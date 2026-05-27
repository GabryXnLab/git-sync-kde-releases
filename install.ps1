# GitSync KDE — Installer Windows
# Scarica l'ultima versione e la configura per l'avvio automatico
# Eseguire con: powershell -ExecutionPolicy Bypass -File install.ps1

$ErrorActionPreference = "Stop"

$Repo    = "GabryXnLab/git-sync-kde-releases"
$AppName = "GitSync KDE"
$ExeName = "gitsync-kde.exe"
$InstallDir = Join-Path $env:LOCALAPPDATA "gitsync-kde"
$ExePath    = Join-Path $InstallDir $ExeName

Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     GitSync KDE — Windows Installer   ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Recupera ultima versione
Write-Host "Recupero ultima versione disponibile..." -ForegroundColor Yellow
$ApiUrl  = "https://api.github.com/repos/$Repo/releases/latest"
$Release = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "User-Agent" = "gitsync-kde-installer" }
$Tag     = $Release.tag_name

if (-not $Tag) {
    Write-Host "ERRORE: impossibile recuperare la versione." -ForegroundColor Red
    exit 1
}

Write-Host "Ultima versione: $Tag" -ForegroundColor Green

$AssetUrl = ($Release.assets | Where-Object { $_.name -eq $ExeName }).browser_download_url
if (-not $AssetUrl) {
    Write-Host "ERRORE: asset $ExeName non trovato nella release $Tag." -ForegroundColor Red
    exit 1
}

# Download
Write-Host "Download in corso..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
Invoke-WebRequest -Uri $AssetUrl -OutFile $ExePath -UseBasicParsing
Write-Host "Binario installato in: $ExePath" -ForegroundColor Green

# Autostart tramite registro
Write-Host "Configurazione avvio automatico..." -ForegroundColor Yellow
$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
Set-ItemProperty -Path $RegPath -Name "GitSyncKDE" -Value "`"$ExePath`""
Write-Host "Avvio automatico configurato." -ForegroundColor Green

Write-Host ""
Write-Host "✓ GitSync KDE $Tag installato con successo!" -ForegroundColor Green
Write-Host "  Avvia subito con: $ExePath"
Write-Host "  Oppure effettua il logout/login per l'avvio automatico."
Write-Host ""

# Avvia subito
$choice = Read-Host "Vuoi avviare GitSync KDE adesso? [S/n]"
if ($choice -ne "n" -and $choice -ne "N") {
    Start-Process $ExePath
}
