# Windows PowerShell version of get_datasets.sh for assignment3
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# For assignment 3 only the imagenet_val and COCO captioning archives are used via specific scripts.
# Provide the same small ImageNet val fetch here for convenience.
if (-not (Test-Path 'imagenet_val_25.npz' -PathType Leaf)) {
    $imagenetUrl = 'http://cs231n.stanford.edu/imagenet_val_25.npz'
    Invoke-WebRequest -Uri $imagenetUrl -OutFile 'imagenet_val_25.npz'
    Write-Host 'Downloaded imagenet_val_25.npz'
} else {
    Write-Host 'imagenet_val_25.npz already exists, skipping download.'
}
