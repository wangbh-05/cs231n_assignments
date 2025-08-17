# Windows PowerShell version of get_imagenet_val.sh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$imagenetUrl = 'http://cs231n.stanford.edu/imagenet_val_25.npz'
Invoke-WebRequest -Uri $imagenetUrl -OutFile 'imagenet_val_25.npz'
Write-Host 'Downloaded imagenet_val_25.npz'
