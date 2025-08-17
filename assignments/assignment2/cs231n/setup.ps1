# Build Cython extensions for assignment2 (optional optimization)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Push-Location $PSScriptRoot
try {
    if (-not (Test-Path .\setup.py -PathType Leaf)) {
        Write-Host 'setup.py not found; nothing to build.' -ForegroundColor Yellow
        exit 0
    }
    Write-Host 'Building Cython extensions (requires Microsoft C++ Build Tools)...'
    python .\setup.py build_ext --inplace
    Write-Host 'Build complete.'
} finally {
    Pop-Location
}
