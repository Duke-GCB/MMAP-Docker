Dockerfiles for MMAP
====================

This directory contains [Docker](http://docker.com) files for containerizing the components of the MMAP analysis pipeline. It is a work-in-progress, as an effort to make the operation modular and scalable, taking cues from [bioboxes](https://github.com/bioboxes).

Working
-------

So far, we have containers created for

- [Genovo](genovo)
- [Glimmer](glimmer)
- [MINE](mine)
- [NCBI BLAST+](blast)
- [Converting GO seqdb to blastdb](makeblastdb-go)

To-Do
-----

- Extract the orchestration from the data processing in the python code, and containerize the processing, so that the orchestration could be run under something like galaxy.
- Abstract the specific tool interface to things like assembler, making modularity possible.
- version tracking, explicit logging of versions of things, including data container.
- Put it all together

Usage notes
-----------

In general, binaries are installed and available in path, can be run as:

    docker run dleehr/genovo assemble <args>
    docker run dleehr/genovo finalize <args>
    docker run dleehr/glimmer glimmer3 <args>

The mine image incorporates a shell script to wrap the jar file:

    docker run dleehr/mine mine.sh <args>

There are two blast-related container images. The first, [makeblastdb-go](makeblastdb-go)  downloads the GO sequence data and converts it to an NCBI blastdb. This is only needed to create a database, which should be reused.

    docker run -v /Users/dcl9/Data/go-blastdb/:/go-blastdb dleehr/makeblastdb-go

On success, the go-seqdb database will be created. Note that no command or arguments are needed.

The other blast-related container simply installs `ncbi-blast+`, and can be used as such:

    docker run \
        -it \
        -v /Users/dcl9/Data/fasta:/input \
        -v /Users/dcl9/Data/output:/output \
        -v /Users/dcl9/Data/go-blastdb:/go-blastdb \
        dleehr/blast \
        blastx \
        -db /go-blastdb/go-seqdb \
        -query /input/AE014075_subTiny5.fasta \
        -out /output/AE014075_subTiny5.out

Note that to pass files as arguments, the files must be on a volume, e.g. one that is shared from the host.
