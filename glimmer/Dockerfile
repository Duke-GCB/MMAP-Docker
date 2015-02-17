# Glimmer container
# Puts Glimmer 'glimmer3' and other binaries in path.
# Initial prototype for containerizing, but the gene identifier should conform to
# A standardized interface (e.g. https://github.com/bioboxes or http://nucleotid.es)
FROM phusion/baseimage
MAINTAINER Dan Leehr <dan.leehr@duke.edu>

# Install required libraries
RUN apt-get update && apt-get install -y \
  build-essential

# Get Glimmer
ENV GLIMMER_VERSION 302b
ENV GLIMMER_DIR /opt/glimmer/
RUN mkdir -p $GLIMMER_DIR
# This extracts a directory called 'glimmer3.02'
RUN curl -SL https://ccb.jhu.edu/software/glimmer/glimmer$GLIMMER_VERSION.tar.gz | tar -xzC $GLIMMER_DIR
# Hard-coding the path
RUN cd $GLIMMER_DIR/glimmer3.02/src && make

# Add to path
ENV PATH $GLIMMER_DIR/glimmer3.02/bin:$PATH

