import argparse
import os
import subprocess

try:
    from PyPDF2 import PdfMerger

    MERGE = True
except ImportError:
    print("Could not find PyPDF2. Leaving pdf files unmerged.")
    MERGE = False


def main(files, pdf_name):
    # Try classic LaTeX-based PDF export; on Windows without LaTeX fallback to webpdf
    to_format_candidates = ["pdf", "webpdf"]

    def export_one(f, to_format):
        args = [
            "jupyter",
            "nbconvert",
            "--log-level",
            "CRITICAL",
            "--to",
            to_format,
            f,
        ]
        # For webpdf, nbconvert needs pyppeteer or playwright; we try without extra args
        subprocess.run(args, check=True)
        print("Created PDF {} (via {}).".format(f, to_format))

    for f in files:
        last_exc = None
        for to_format in to_format_candidates:
            try:
                export_one(f, to_format)
                last_exc = None
                break
            except Exception as e:
                last_exc = e
        if last_exc is not None:
            raise last_exc
    if MERGE:
        pdfs = [f.split(".")[0] + ".pdf" for f in files]
        merger = PdfMerger()
        for pdf in pdfs:
            merger.append(pdf)
        merger.write(pdf_name)
        merger.close()
        for pdf in pdfs:
            os.remove(pdf)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    # We pass in a explicit notebook arg so that we can provide an ordered list
    # and produce an ordered PDF.
    parser.add_argument("--notebooks", type=str, nargs="+", required=True)
    parser.add_argument("--pdf_filename", type=str, required=True)
    args = parser.parse_args()
    main(args.notebooks, args.pdf_filename)
