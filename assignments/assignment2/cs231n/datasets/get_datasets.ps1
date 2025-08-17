# Windows PowerShell version of get_datasets.sh for assignment2
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Test-Path 'cifar-10-batches-py' -PathType Container)) {
    $cifarUrl = 'http://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz'
    $cifarTgz = 'cifar-10-python.tar.gz'
    $imagenetUrl = 'http://cs231n.stanford.edu/imagenet_val_25.npz'

    Write-Host 'Downloading CIFAR-10 ...'
    Invoke-WebRequest -Uri $cifarUrl -OutFile $cifarTgz

    Write-Host 'Extracting CIFAR-10 ...'
    tar -xzf $cifarTgz
    Remove-Item $cifarTgz -Force

    Write-Host 'Downloading imagenet_val_25.npz ...'
    Invoke-WebRequest -Uri $imagenetUrl -OutFile 'imagenet_val_25.npz'
} else {
    Write-Host 'Dataset directory already exists, skipping download.'
}
