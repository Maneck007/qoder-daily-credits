"""Build the Windows distribution from an explicit list of public files."""
import argparse
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parents[1]
FILES = ("install.bat", "install-helper.ps1", "install-qoder-windows.ps1",
         "qoder_signin.py", "使用说明.txt", "LICENSE", "README.md", "UPSTREAM.md", "upstream.json")


def build(output):
    output = Path(output)
    output.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(output, "w", zipfile.ZIP_DEFLATED) as archive:
        for name in FILES:
            archive.write(ROOT / name, name)
    return output


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default=str(ROOT / "dist/qoder-daily-credits-win-v0.1.0.zip"))
    print(build(parser.parse_args().output))
