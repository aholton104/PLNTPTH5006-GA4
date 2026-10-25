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

*Answer*: Your prompt: Review the shell script. List the five most important problems or improvements that could be made, starting the the most important. Provide a one-sentence reason for each. Do not change it yet.

*Answer*: Claude's suggestions, and for each, whether you agree, disagree,
or don't understand it, and why: 

1. Missing `mkdir -p "$outdir"`: I agree with this suggestion. I think it is generally best practice to include the `mkdir -p <variable>` command in a shell script since it will prevent code from failing if a dir is not present or it is already in use. 
1. No purpose/usage comment block under `set -euo pipefail`: I did not understand this suggestion. I believe it means to add a comment that explains the code in detail, but I do not think this is necessary for the shebang and safe-settings lines. 
1. No program version reported at the end: I agree, and I think that it is also best practice to include program versions so you know exactly what happened when a command is executed and by what version of the program, even if it is already provided when the command is run. 
1. Variables named inconsistently: `R1_FASTQ`/`R2_FASTQ` are uppercase: I agree that renaming the variables with lowercase for the "fastq" could help with consistency. Although, I would not make the R1 and R2 lowercase, since that would not be consistent with previous file naming convention.     
1. No argument check with `set -u`: I do not know what this suggestion means. I remember that the `set -u` command has to do with undefined variables and that a command with fail if a variable is not properly defined, as discussed in class, but I do know what an argument check means in this case. 


*Answer*: Was anything wrong, or in conflict with the course's practices?
Did Claude refer to your `CLAUDE.md` conventions?

No, I do not think any of the suggestions were inherently wrong or conflicted with what I have learned so far. The `CLAUDE.md` conventions were referenced when recommending lowercase variables and using the `mkdir -p` command. 

*Answer*: The estimated cost of this conversation (from `/usage`): $0.1093

### 11: Opus reviews your script

*Answer*: The estimated cost of this conversation (from `/usage`): $0.2359

*Answer*: Which suggestions did only one of the two models make?

Only Sonnet 5.5 made the suggestion to add a comment block for the shebang and safe-settings lines. Only Opus 5.5 made the suggestion to rework the code so that the R2 file name does not need to be typed out in full, which could lead to mismatched pairs if manually typed incorrectly.

*Answer*: Did either model claim something that you know is wrong?

No, I do not think either model made a claim that is completely wrong.

*Answer*: Did either model check its claims, for example by running commands?

No, neither model ran commands. 

*Answer*: Did Opus's review change your mind about any of your answers to question 10?

No, most of the suggestions were the same and the reasoning was worded similarly between the two outputs. I still think the suggestions are either confusing or reasonable, and my mind has not changed about what changes I would make to the script.

*Answer*: How did the costs compare? Which review would you trust more, and why?
Was the difference worth the difference in cost?

The cost was over two times greater for the Opus 5.5 model with high effort level. It would be reasonable to trust the higher effort and more capable Opus 5.5 model in most situations. However, the outputs to the same promot here were fairly similar, so I do not think the difference in cost is worth it for this exercise. 

### 12: Run the script with a non-existent file

```bash
bash scripts/trimgalore.sh ../garrigos/fastq/S00_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore/
```

The output of the command was:

```
Starting script trimgalore.sh
Sun Oct 25 06:33:05 PM EDT 2026
Input FASTQ files: ../garrigos/fastq/S00_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz
Output dir: results/trimgalore/
INFO:    Using cached SIF image
INFO:    gocryptfs not found, will not be able to use gocryptfs
Error: Input file not found: ../garrigos/fastq/S00_R1.fastq.gz
```

*Answer*: What happens, and at which point does the script stop?

An error message is printed to the terminal, and the script stops after the first argument fails when trying to name the input files. 

### 13: Claude adds a check to your script

*Answer*: Your prompt: Add a check to scripts/trimgalore that both input FASTQ files exists. Exit with an informative error message if they do not exist.

```bash
bash scripts/trimgalore.sh ../garrigos/fastq/S00_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore/
```

The output of the command was:

```
Starting script trimgalore.sh
Sun Oct 25 06:40:59 PM EDT 2026
Input FASTQ files: ../garrigos/fastq/S00_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz
Output dir: results/trimgalore/
Error: input FASTQ file not found: ../garrigos/fastq/S00_R1.fastq.gz
```

*Answer*: Does it behave the way Claude claimed it would?

Yes, it behaved the way that Claude claimed it would by printing an error message and exiting.

*Answer*: Given what you saw in question 12, how useful is this check?

In question 12, the command failed because it could not find the file name, as stated in the error message. Claude edited the code to print a near identical error message after this command failed. The check can be useful to identify what went wrong in the script, but in this case it seems to have printed almost the exact same message.

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
