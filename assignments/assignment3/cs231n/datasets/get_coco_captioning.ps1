# Windows PowerShell version of get_coco_captioning.sh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$zipUrl = 'http://cs231n.stanford.edu/coco_captioning.zip'
$zipFile = 'coco_captioning.zip'

Invoke-WebRequest -Uri $zipUrl -OutFile $zipFile

# Expand-Archive is built into PowerShell 5+
Expand-Archive -Path $zipFile -DestinationPath . -Force
Remove-Item $zipFile -Force

Write-Host 'COCO captioning dataset downloaded and extracted.'
