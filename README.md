Dockerfiles for MMAP
====================

This directory contains Dockerfiles for building [Docker](http://docker.com) images, encapsulating steps of the [MMAP](https://github.com/Duke-GCB/MMAP) analysis pipeline into containers.

Each image implements a step in the pipeline, and should be treated as a single command. Parameters are sent to the containers by setting environment variables, taking cues from [bioboxes](https://github.com/bioboxes).

Images
----------

See README.md in each subdirectory for further details.

- [Genovo](genovo) - [Genovo](http://cs.stanford.edu/group/genovo/) assembler
- [Glimmer](glimmer) - [Glimmer](https://ccb.jhu.edu/software/glimmer/) gene finder
- [go-blast](go-blast) - [NCBI BLAST+](http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)  configured to use a local BLAST database containing Gene Ontology terms
- [makeblastdb-go](makeblastdb-go) - Downloads GO annotated sequences from archive.geneontology.org and converts sequence to an NCBI BLAST+ compatible format.
- [extract-go-terms](extract-go-terms) - Simple python script that counts/extracts the GO terms from the go-blast results
- [mine](mine) - [MINE - maximal information-based nonparametric exploration](http://www.exploredata.net/Downloads/MINE-Application)

To-Do
-----

- CSV merging - preprocessing for [mine](mine)

Usage notes
-----------

These images are designed to be run within `docker-pipeline`, and treated as simple Unix-style command-line tools. Information is passed to container execution by configuring volumes and setting environment variables.  For example:

    # Running genovo to assemble reads into contigs
    docker run \
      -v /Users/dcl9/Data/reads:/mnt/input:ro \
      -v /Users/dcl9/Data/contigs:/mnt/output \
      -e CONT_INPUT_READS_FILE=/mnt/input/reads.fasta \
      -e CONT_OUTPUT_CONTIGS_FILE=/mnt/output/contigs.fasta \
      -e CONT_INPUT_ASSEMBLE_ITERATIONS=10 \
      dleehr/genovo

Note that the input volume is mounted read-only, and the file paths passed in the environment variables are paths from inside the container.

The environment variables are validated and interpreted by simple wrapper scripts inside the image, which execute the underlying command. These scripts are configured as the image's `CMD`, allowing each image to be treated like a Unix-style command-line tool.

The wrapper scripts output the commands they will execute, as well as underyling tool versions.