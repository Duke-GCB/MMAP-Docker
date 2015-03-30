# glimmer

A docker image for running [Glimmer](https://ccb.jhu.edu/software/glimmer/).

> Glimmer is a system for finding genes in microbial DNA, especially the genomes of bacteria, archaea, and viruses

# Running

The Docker image built by the [Dockerfile](Dockerfile) is designed to be used by [docker-pipeline](https://github.com/Duke-GCB/docker-pipeline).

Glimmer binaries are installed in /opt, as well as ELPH. The image's default command, [glimmer.sh](glimmer.sh), is modeled after [ run_glimmer.py](https://github.com/YoderLab/MMAP/blob/a33ce0eee281d4d4aaf42ef02693c4356b7bbce1/src/core/component/run_glimmer.py) from YoderLab/MMAP.

# Environment Variables

|         Variable        | Description                   |  Type  | Required? |
|-------------------------|-------------------------------|--------|-----------|
| CONT_INPUT_CONTIGS_FILE | FASTA file containing contigs | Input  | **Yes**   |
| CONT_OUTPUT_ORFS_FILE   | Results file, to contain ORFs | Output | **Yes**   |
