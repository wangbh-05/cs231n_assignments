# NOTE: Windows PowerShell version of collectSubmission.sh
# Creates zip and PDF for submission without requiring bash/zip/find

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$CODE = @(
    "cs231n/classifiers/k_nearest_neighbor.py",
    "cs231n/classifiers/linear_classifier.py",
    "cs231n/classifiers/linear_svm.py",
    "cs231n/classifiers/softmax.py",
    "cs231n/classifiers/fc_net.py",
    "cs231n/optim.py",
    "cs231n/solver.py",
    "cs231n/layers.py"
)

$NOTEBOOKS = @(
    "knn.ipynb",
    "svm.ipynb",
    "softmax.ipynb",
    "two_layer_net.ipynb",
    "features.ipynb"
)

$FILES = $CODE + $NOTEBOOKS
$ZIP_FILENAME = "a1_code_submission.zip"
$PDF_FILENAME = "a1_inline_submission.pdf"

# Check files exist
foreach ($f in $FILES) {
    if (-not (Test-Path -Path $f -PathType Leaf)) {
        Write-Host "Required file $f not found, exiting." -ForegroundColor Red
        exit 1
    }
}

# Build list of all .py files recursively (exclude makepdf.py)
$pyFiles = Get-ChildItem -Recurse -Filter *.py | Where-Object { $_.Name -ne 'makepdf.py' } | ForEach-Object { $_.FullName }

Write-Host "### Zipping files ###"
if (Test-Path $ZIP_FILENAME) { Remove-Item $ZIP_FILENAME -Force }

# Compress-Archive requires paths; include notebooks and py files
Compress-Archive -Path ($NOTEBOOKS + $pyFiles) -DestinationPath $ZIP_FILENAME -Force

Write-Host "### Creating PDFs ###"
python .\makepdf.py --notebooks $NOTEBOOKS --pdf_filename $PDF_FILENAME

Write-Host "### Done! Please submit $ZIP_FILENAME and $PDF_FILENAME to Gradescope. ###"
