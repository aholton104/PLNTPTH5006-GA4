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

# Run TrimGalore
apptainer exec "$CONTAINER" trim_galore --paired --output_dir "$outdir" --fastqc "$R1_FASTQ" "$R2_FASTQ"

# Final Logging
echo
echo "Successfully finished script trimgalore.sh"
date