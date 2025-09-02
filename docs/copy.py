from pathlib import Path

def main():
    cwd_file = Path(__file__)
    cwd = cwd_file.parent
    root = cwd.parent
    readme = root / "README.md"
    index_qmd = cwd / "index.qmd"
    index_qmd.write_text(readme.read_text())

if __name__ == "__main__":
    main()