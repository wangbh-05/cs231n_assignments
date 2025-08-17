# Windows PowerShell version of collectSubmission.sh for assignment 3
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$CODE = @(
    "cs231n/rnn_layers.py",
    "cs231n/transformer_layers.py",
    "cs231n/classifiers/rnn.py",
    "cs231n/gan_pytorch.py",
    "cs231n/simclr/contrastive_loss.py",
    "cs231n/simclr/data_utils.py",
    "cs231n/simclr/utils.py"
)
$NOTEBOOKS = @(
    "RNN_Captioning.ipynb",
    "Transformer_Captioning.ipynb",
    "Generative_Adversarial_Networks.ipynb",
    "Self_Supervised_Learning.ipynb",
    "LSTM_Captioning.ipynb"
)
$PDFS = @(
    "RNN_Captioning.ipynb",
    "Transformer_Captioning.ipynb",
    "Generative_Adversarial_Networks.ipynb"
)

$FILES = $CODE + $NOTEBOOKS
$ZIP_FILENAME = "a3_code_submission.zip"
$PDF_FILENAME = "a3_inline_submission.pdf"

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
python .\makepdf.py --notebooks $PDFS --pdf_filename $PDF_FILENAME

Write-Host "### Done! Please submit $ZIP_FILENAME and $PDF_FILENAME to Gradescope. ###"
