# extract-go-terms

A docker image for extracting Gene Ontology terms from a CSV file

# Running

The Docker image built by the [Dockerfile](Dockerfile) is designed to be used by [docker-pipeline](https://github.com/Duke-GCB/docker-pipeline).

The image's default command is an executable python script, [extract_go_terms.py](extract_go_terms.py), which replaces parsing and matching in  [go_sequence.py](https://github.com/YoderLab/MMAP/blob/a33ce0eee281d4d4aaf42ef02693c4356b7bbce1/src/core/amigo/go_sequence.py) from YoderLab/MMAP. It produces a CSV file containing unique GO terms and the number of times they occurred in the input file

# Environment Variables

|         Variable        | Description                   |  Type  | Required? | Default |
|-------------------------|-------------------------------|--------|-----------|---------|
| CONT_INPUT_BLAST_RESULTS_FILE | CSV file in [BLAST CSV format](http://www.ncbi.nlm.nih.gov/books/NBK279675/) with subject titles containing `[GO:xxxxxx]` terms | Input  | **Yes**   | |
| CONT_OUTPUT_GOTERMS_FILE | Results file, in CSV format. GO terms and counts | Output | **Yes** | |
