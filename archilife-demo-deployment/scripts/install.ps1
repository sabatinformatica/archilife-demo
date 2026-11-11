#requires -RunAsAdministrator
[CmdletBinding()]
param(
  [string]$BranchConfig = (Join-Path $PSScriptRoot '..\config\branch.example.json'),
  [string]$InstallRoot = 'C:\ProgramData\ArchiLifeDemo'
)
$ErrorActionPreference = 'Stop'

Write-Host '=== ArchiLife Demo - instalador de sucursal ===' -ForegroundColor Cyan
if (-not (Test-Path $BranchConfig)) { throw "No existe la configuración: $BranchConfig" }
$config = Get-Content $BranchConfig -Raw | ConvertFrom-Json
New-Item -ItemType Directory -Force -Path $InstallRoot | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $InstallRoot 'logs') | Out-Null
$config | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $InstallRoot 'branch.json') -Encoding UTF8

Write-Host '[1/5] Verificando Node.js...'
$node = Get-Command node.exe -ErrorAction SilentlyContinue
if (-not $node) { throw 'Node.js no está instalado. En el siguiente incremento se incorporará instalación desatendida desde paquete oficial versionado.' }
node --version

Write-Host '[2/5] Verificando MySQL...'
$mysql = Get-Service -Name MySQL* -ErrorAction SilentlyContinue
if (-not $mysql) { throw 'No se encontró el servicio MySQL. En el siguiente incremento se incorporará instalación y configuración desatendida.' }

Write-Host '[3/5] Preparando directorios...'
# El despliegue de backend/frontend se copiará aquí desde el paquete de release.

Write-Host '[4/5] Firewall...'
# Las reglas definitivas se limitarán al perfil de red privada y a la subred LAN.

Write-Host '[5/5] Verificación...'
Write-Host "Sucursal: $($config.branchCode) - $($config.branchName)"
Write-Host 'Base de instalación preparada. Falta desplegar el paquete de aplicación y registrar los servicios.' -ForegroundColor Yellow
