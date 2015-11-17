# xgenovo container

FROM phusion/baseimage
MAINTAINER Dan Leehr <dan.leehr@duke.edu>

# Install required libraries
RUN apt-get update && apt-get install -y \
  libgsl0ldbl

# Xgenovo is distributed on Google Drive as Xgenovo.tar.gz.
# https://docs.google.com/file/d/0B48F8o_nwW-nTTliZ3RlWVFhOEU
# There is no simple way to download a file from Google Drive
# so Xgenovo.tar.gz is included in the Docker repo

# ADD will extract the tar file
ADD Xgenovo.tar.gz /opt/

# Using pre-built binaries
WORKDIR /opt/Xgenovo

# Precompiled binaries are included but not compiled
RUN chmod +x assemble finalize

ENV PATH /opt/Xgenovo:$PATH
