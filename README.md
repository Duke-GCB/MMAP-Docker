Dockerfiles for MMAP
====================

This directory contains [http://docker.com](Docker) files for containerizing the components of the MMAP analysis pipeline. It is a work-in-progress, as an effort to make the operation modular and scalable, taking cues from [bioboxes](https://github.com/bioboxes).

Working
-------

So far, we have containers created for

- [Genovo](genovo)
- [Glimmer](glimmer)
- [MINE](mine)
- [GO sequence data & NCBI BLAST+](go-blast)

To-Do
-----

- Extract the orchestration from the data processing in the python code, and containerize the processing, so that the orchestration could be run under something like galaxy.
- Abstract the specific tool interface to things like assembler, making modularity possible.

Usage notes
-----------

In general, binaries are installed and available in path, can be run as:

`docker run dleehr/genovo assemble ...`
`docker run dleehr/genovo finalize ...`
`docker run dleehr/glimmer glimmer3 ...`

The mine image incorporates a shell script to wrap the jar file:

`docker run dleehr/mine mine.sh ...`

And the go-blast image has the GO sequence data as a protein database: `/blastdb/go-seqdb`:

`docker run -v /Users/dcl9/Code/python/MMAP/data:/input dleehr/go-blast blastx -db /blastdb/go-seqdb -query /input/AE014075_subTiny5.fasta`

Note that to pass files as arguments, the files must be on a volume that is mounted
