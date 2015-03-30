# makeblastdb-go

A docker image for building an [NCBI BLAST+](http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download) database, from Gene Ontology sequences at http://archive.geneontology.org

# Running

blast+ is installed via apt-get, which provides makeblastdb. The image's default command, [makeblastdb-go.sh](makeblastdb-go.sh), downloads the sequence and builds 

# Environment Variables

|         Variable        | Description                   |  Type  | Required? | Default |
|-------------------------|-------------------------------|--------|-----------|---------|
| BLASTDB   | Output directory for creating the _go-seqdb_ database | Output  | No   | /go-blastdb |

## Notes

1. The output directory defaults to `/go-blastdb`, which is marked as docker volume in the Dockerfile