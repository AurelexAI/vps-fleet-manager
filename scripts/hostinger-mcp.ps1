param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$RemainingArgs
)

$ErrorActionPreference = "Stop"
$RootDir = Split-Path -Parent $PSScriptRoot

if ([string]::IsNullOrWhiteSpace($env:HOSTINGER_API_TOKEN) -and [string]::IsNullOrWhiteSpace($env:API_TOKEN)) {
  $profilesPath = if ([string]::IsNullOrWhiteSpace($env:VPS_PROFILES_PATH)) { (Join-Path $RootDir "profiles.json") } else { $env:VPS_PROFILES_PATH }
  if (Test-Path $profilesPath) {
    $resolved = & node (Join-Path $RootDir "scripts/profiles.js") resolve --provider hostinger --format powershell
    if ($LASTEXITCODE -ne 0) {
      throw "Unable to resolve the selected hostinger account from profiles.json."
    }
    Invoke-Expression ($resolved -join [Environment]::NewLine)
  }
}

if (-not (Get-Command hostinger-api-mcp -ErrorAction SilentlyContinue)) {
  throw "hostinger-api-mcp not found in PATH. Install with: npm install -g hostinger-api-mcp"
}

if ([string]::IsNullOrWhiteSpace($env:HOSTINGER_API_TOKEN) -and [string]::IsNullOrWhiteSpace($env:API_TOKEN)) {
  throw "Missing HOSTINGER_API_TOKEN or API_TOKEN in the environment or selected profiles.json entry."
}

if ([string]::IsNullOrWhiteSpace($env:API_TOKEN)) {
  $env:API_TOKEN = $env:HOSTINGER_API_TOKEN
}

if ([string]::IsNullOrWhiteSpace($env:DEBUG)) {
  if ([string]::IsNullOrWhiteSpace($env:HOSTINGER_MCP_DEBUG)) {
    $env:DEBUG = "false"
  } else {
    $env:DEBUG = $env:HOSTINGER_MCP_DEBUG
  }
}

& hostinger-api-mcp @RemainingArgs
exit $LASTEXITCODE
