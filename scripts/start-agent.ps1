$ErrorActionPreference = "Stop"
$RootDir = Split-Path -Parent $PSScriptRoot
Set-Location $RootDir

if (-not (Get-Command codex -ErrorAction SilentlyContinue)) {
  throw "codex not found. Run scripts/bootstrap-windows.ps1 first."
}

codex $args
