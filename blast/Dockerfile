# BLAST+ container
# Initial prototype for containerizing, but the gene identifier should conform to
# A standardized interface (e.g. https://github.com/bioboxes or http://nucleotid.es)
FROM phusion/baseimage
MAINTAINER Dan Leehr <dan.leehr@duke.edu>

# Install required libraries
RUN apt-get update && apt-get install -y \
  ncbi-blast+
