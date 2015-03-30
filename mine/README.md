# mine

A docker image for running [MINE](http://www.exploredata.net/Downloads/MINE-Application).
> The maximal information coefficient (MIC) is a measure of two-variable dependence designed specifically for rapid exploration of many-dimensional data sets. MIC is part of a larger family of maximal information-based nonparametric exploration (MINE) statistics, which can be used not only to identify important relationships in data sets but also to characterize them.

# Running

The Docker image built by the [Dockerfile](Dockerfile) is designed to be used by [docker-pipeline](https://github.com/Duke-GCB/docker-pipeline).

MINE is installed in /opt. The image's default command, [mine.sh](mine.sh), is modeled after [ run_MINE.py](https://github.com/YoderLab/MMAP/blob/a33ce0eee281d4d4aaf42ef02693c4356b7bbce1/src/core/component/run_MINE.py) from YoderLab/MMAP.

# Environment Variables

|         Variable        | Description                   |  Type  | Required? | Default |
|-------------------------|-------------------------------|--------|-----------|---------|
| CONT_INPUT_CSV_FILE | CSV file containing the data | Input  | **Yes**   | |
| CONT_OUTPUT_RESULTS_CSV_FILE | Results in CSV format | Output | **Yes** | |
| CONT_INPUT_COMPARE_STYLE | variables to compare | Parameter | No | -allPairs |
| CONT_INPUT_CV | % which need data for both variables before variables are compared | Parameter | No | 0 |
| CONT_INPUT_EXP | The exponent in the equation B(n) = nα | Parameter | No | 0.6 |
| CONT_INPUT_CLUMPS | Clump Factor | Parameter | No | 15 |
