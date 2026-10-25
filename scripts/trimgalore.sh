#!/bin/bash
set -euo pipefail

# TrimGalore Container
CONTAINER=oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4

# Placeholder variables
R1_FASTQ=$1
R2_FASTQ=$2
outdir=$3

# Initial Logging
echo "Starting script trimgalore.sh"
date
echo "Input FASTQ files: $R1_FASTQ $R2_FASTQ"
echo "Output dir: $outdir"

# Check that the input files exist
for fastq in "$R1_FASTQ" "$R2_FASTQ"; do
    if [[ ! -f "$fastq" ]]; then
        echo "Error: input FASTQ file not found: $fastq" >&2
        exit 1
    fi
done

# Run TrimGalore
apptainer exec "$CONTAINER" trim_galore --paired --output_dir "$outdir" --fastqc "$R1_FASTQ" "$R2_FASTQ"

# Final Logging
echo
echo "Successfully finished script trimgalore.sh"
date