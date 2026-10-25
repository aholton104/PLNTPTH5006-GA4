# AI diary

## 2026-10-25

- **Asked:** Add a check to `scripts/trimgalore.sh` that both input FASTQ files exist, with an informative error if not.
- **Changed:** `scripts/trimgalore.sh` (loop over R1/R2 with `[[ -f ]]`; prints the missing file to stderr and exits 1, before running TrimGalore).
- **Tested:** Nonexistent inputs give the error and exit code 1.
- **Decision:** Reported only the first missing file, then exited, rather than collecting all missing files (simpler).
- **Note:** `doc/ai/ai-diary.md` did not exist, so I created it.
