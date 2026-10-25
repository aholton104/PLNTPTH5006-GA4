# GA4 answers - Abigail Holton

------------------------------------------------------------------------

## Part A: Your project dir and Git repo

### 1: Create subdirs, and copy `CLAUDE.md` and a FastQC report


### 2: Initialize a Git repository, and commit your first files

------------------------------------------------------------------------

## Part B: A TrimGalore script --- without genAI


### 3: A TrimGalore container, its help info, and three options

*Answer*: The container link (URI) is: oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4. 

Code to run `trim_galore --help` with the container:

```bash
apptainer exec oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4 trim_galore --help
```

*Answer*: The option to indicate that the reads are paired-end: `--paired`.

*Answer*: The option to set the output dir: `-o <OUTPUT_DIR>` or `--output_dir <OUTPUT_DIR>`.

*Answer*: The option to run FastQC on the trimmed FASTQ files: `--fastqc`.

### 4: Default thresholds

*Answer*: A) The default base quality score threshold: 20.

*Answer*: B) The default read length threshold: 20 (18 for smallRNA adapter).

### 5: Write the `trimgalore.sh` script

### 6: Run the script for sample `S63`, and check the output files

Code to run the script:

```bash
bash scripts/trimgalore.sh ../garrigos/fastq/S63_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore
```

Code to list the output files:

```bash
ls results/trimgalore/
```

The output of the command was:

```
S63_R1.fastq.gz_trimming_report.json
S63_R1.fastq.gz_trimming_report.txt
S63_R1_val_1.fastqc.html
S63_R1_val_1.fastqc.zip
S63_R1_val_1.fq.gz
S63_R2.fastq.gz_trimming_report.json
S63_R2.fastq.gz_trimming_report.txt
S63_R2_val_1.fastqc.html
S63_R2_val_1.fastqc.zip
S63_R2_val_1.fq.gz
```

*Answer*: What each type of output file contains: The `*_fastqc.html` files for R1 and R2 can be previewed to see visual representations of per base sequence qualities and other data provided by the FASTQC report. The `*_fastqc.zip` is a compressed file that serves as a different format of the same FASTQC results as the `*_fastqc.html` files. Likewise, the `*_trimming_report.json` and `*_trimming_report.txt` files contain the same information for R1 and R2 files. The `.txt` file is more human-readable than the `.json` file, but both provide a summary of the trimming process, script, and FASTQ files. This includes the total reads and basepairs processed, as well as an overview of removed sequences. The `*_fq.gz` files for R1 and R2 are compressed files that would contain the trimmed sequences for each read. 

Initially, my script failed because I put the variable for the output dir in the incorrect place, so it was not properly defined. I fixed it by moving the variable from the end of the command to after the `--output_dir` option.

### 7: Trimming results

*Answer*: Which adapter sequence TrimGalore looked for, and how it decided on this: The adapter sequence was AGATCGGAAGAGC (Illumina) which was determined by scanning the reads for a specific sequence typically at the beginning or end of a read that corresponds to a predetermined adapter sequence which is then used for trimming. 

*Answer*: Percentage of reads with adapters in R1 and R2: R1 had 13.0% and R2 has 10.1% of reads with adapters. 

*Answer*: In R1 and R2, were more bases removed by quality trimming or by adapter trimming? More bases were removed by quality trimming than by adapter trimming as indicated by the length and count of sequences removed for matching the adapter sequence.

*Answer*: Percentage of read pairs that were removed: 7.40% of sequence pairs were removed. 

### 8: Poly-G trimming

*Answer*: Did TrimGalore do poly-G trimming, and did you have to tell it to? Yes, poly-G trimming was enabled, but it was auto-detected. Poly-G trimming can be disabled by including an option (`--no_poly_g`) in the command within the script. 

*Answer*: What TrimGalore concludes about the sequencing technology: TrimGalore determines that Illumina sequencing technology was used based on the specific adapter sequence detected. 

*Answer*: Was more poly-G trimming done in R1 or R2? (Optional: any idea why?) More poly-G trimming was done in R2, though I am not sure why. 

### 9: Compare the FastQC reports before and after trimming

*Answer*: At least two differences between the reports,
and whether things look better in terms of pass/warn/fail status: The trimmed R1 file displays fewer sequences and bases, as well as short sequence lengths compared to the raw R1 file. The summary is the same, except for the per base N content, which went from a warning status to a passing status. 

*Answer*: Were the short reads with only `N`s removed?
If so, was that due to the length threshold, or something else? Short reads with only `N`s were removed, as indicated in the per base N content graphs for raw and trimmed R1 FASTQC reports. The short reads are likely removed due to their length not meeting the minmal length requirements. 

*Answer*: Something you didn't expect or are confused about: Something I am confused about and would like to learn more about is interpreting the .txt files and the overview of removed sequences, paired-end validation, and other values that represent the trimming process so I can better understand the modifications made. 

------------------------------------------------------------------------

## Part C: Bring in genAI

<!-- Export the conversations for questions 10, 11, 13, and 14 to `doc/ai`. -->

### 10: Sonnet reviews your script

*Answer*: Your prompt:

*Answer*: Claude's suggestions, and for each, whether you agree, disagree,
or don't understand it, and why:

*Answer*: Was anything wrong, or in conflict with the course's practices?
Did Claude refer to your `CLAUDE.md` conventions?

*Answer*: The estimated cost of this conversation (from `/usage`):

### 11: Opus reviews your script

*Answer*: The estimated cost of this conversation (from `/usage`):

*Answer*: Which suggestions did only one of the two models make?

*Answer*: Did either model claim something that you know is wrong?

*Answer*: Did either model check its claims, for example by running commands?

*Answer*: Did Opus's review change your mind about any of your answers to question 10?

*Answer*: How did the costs compare? Which review would you trust more, and why?
Was the difference worth the difference in cost?

### 12: Run the script with a non-existent file

```bash
# Your command:
```

The output of the command was:

```
```

*Answer*: What happens, and at which point does the script stop?

### 13: Claude adds a check to your script

*Answer*: Your prompt:

```bash
# Your command to test the updated script:
```

The output of the command was:

```
```

*Answer*: Does it behave the way Claude claimed it would?

*Answer*: Given what you saw in question 12, how useful is this check?

### 14: Claude writes a loop

*Answer*: Your prompt:

The loop that Claude wrote:

```bash
# Paste Claude's loop here
```

*Answer*: Does it run the script once per sample?

*Answer*: Does it get the correct R2 file for each R1 file?

*Answer*: Does it only run for the 7 `S6` samples?

*Answer*: Did you change the loop? If so, what did you change and why?

### 15: Test and run the loop

The loop with `echo`, to test it:

```bash
# Your loop:
```

The output of the loop was:

```
```

<!-- You don't need to paste the output of the loop that ran TrimGalore -->

```bash
# Your command(s) to check the output files:
```

The output of the command(s) was:

```
```

*Answer*: Are all 7 samples represented?

### 16: A summary command

*Answer*: Your prompt:

```bash
# The command you got from Claude:
```

The output of the command was:

```
```

*Answer*: Did the output look right? If not, what did you do?

*Answer*: Does the value for `S63` match your answer to question 7?

*Answer*: In your own words, how does the command work?

### 17: Document your genAI use

<!-- No command/output needed here -- we check your `doc/ai` dir in the repo directly. -->

### 18: Update your `CLAUDE.md`

*Answer*: What you added to `CLAUDE.md`, and why:

*Answer*: Did Claude follow the new instruction?

### 19: Reflection

*Answer*:

------------------------------------------------------------------------

## Part D: Publish your repo on GitHub

### 20: Create a GitHub repository, push, and create an Issue

<!-- No command/output needed here -- we check your GitHub repo directly. -->
