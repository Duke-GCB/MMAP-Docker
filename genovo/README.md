# genovo

A docker image for running [Genovo](http://cs.stanford.edu/group/genovo/).
> Metagenomic de novo Sequencing

# Running

The Docker image built by the [Dockerfile](Dockerfile) is designed to be used by [docker-pipeline](https://github.com/Duke-GCB/docker-pipeline).

Genovo binaries are installed in /opt. The image's default command, [genovo.sh](genovo.sh), is modeled after [run_genovo.py](https://github.com/YoderLab/MMAP/blob/a33ce0eee281d4d4aaf42ef02693c4356b7bbce1/src/core/component/run_genovo.py) from YoderLab/MMAP.

# Environment Variables

|         Variable        | Description                   |  Type  | Required? | Default |
|-------------------------|-------------------------------|--------|-----------|---------|
| CONT_INPUT_READS_FILE   | FASTA file containing reads to assemble | Input  | **Yes**   | |
| CONT_OUTPUT_CONTIGS_FILE | Results file, to contain contigs | Output | **Yes** | |
| CONT_INPUT_ASSEMBLE_ITERATIONS | The number of iterations to run when assembling | Parameter | No   | 10 |
| CONT_INPUT_FINALIZE_CUTOFF | he minimum length to use when outputting assembled contig | Parameter | No   | 250 |
