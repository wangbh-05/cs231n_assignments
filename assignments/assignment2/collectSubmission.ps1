# Windows PowerShell version of collectSubmission.sh for assignment 2
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$CODE = @(
    "cs231n/layers.py",
    "cs231n/classifiers/fc_net.py",
    "cs231n/optim.py",
    "cs231n/solver.py",
    "cs231n/classifiers/cnn.py"
)

$NOTEBOOKS = @(
    "FullyConnectedNets.ipynb",
    "BatchNormalization.ipynb",
    "Dropout.ipynb",
    "ConvolutionalNetworks.ipynb",
    "PyTorch.ipynb"
)

$FILES = $CODE + $NOTEBOOKS
$ZIP_FILENAME = "a2_code_submission.zip"
$PDF_FILENAME = "a2_inline_submission.pdf"

foreach ($f in $FILES) {
    if (-not (Test-Path -Path $f -PathType Leaf)) {
        Write-Host "Required file $f not found, exiting." -ForegroundColor Red
        exit 1
    }
}

$pyFiles = Get-ChildItem -Recurse -Filter *.py,*.pyx | Where-Object { $_.Name -ne 'makepdf.py' } | ForEach-Object { $_.FullName }

Write-Host "### Zipping files ###"
if (Test-Path $ZIP_FILENAME) { Remove-Item $ZIP_FILENAME -Force }
Compress-Archive -Path ($NOTEBOOKS + $pyFiles) -DestinationPath $ZIP_FILENAME -Force

Write-Host "### Creating PDFs ###"
python .\makepdf.py --notebooks $NOTEBOOKS --pdf_filename $PDF_FILENAME

Write-Host "### Done! Please submit $ZIP_FILENAME and $PDF_FILENAME to Gradescope. ###"
