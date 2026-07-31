# ==============================================================================
# ==============================================================================
# FERRAMENTA-ON.PS1 - BOOTSTRAP / LAUNCHER ONLINE DO DANUTILS
# REPOSITÓRIO: https://github.com/Felipindoplay/DanUtils
# ==============================================================================

$DanUtils_GitHub_Raw_URL = "https://raw.githubusercontent.com/Felipindoplay/DanUtils/main/DanUtils.ps1"

# 1. Verifica privilégios de administrador (se não tiver, auto-eleva)
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Elevando permissões para Execução Online do DanUtils..." -ForegroundColor Yellow
    Start-Process powershell -ArgumentList "-NoLogo -NoProfile -ExecutionPolicy Bypass -Command `"& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; irm '$DanUtils_GitHub_Raw_URL' | iex }`"" -Verb RunAs
    exit
}

# 2. Execução em memória via GitHub
Write-Host "Baixando e inicializando DanUtils via GitHub (Felipindoplay)..." -ForegroundColor Cyan
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
irm $DanUtils_GitHub_Raw_URL | iex