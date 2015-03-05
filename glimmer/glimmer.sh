#!/bin/bash

set -e

# This is a script for a docker image to run Glimmer
# It translates environment variables and wraps glimmer commands
#
# CONT prefix means this variable is expected to be set in the container at runtime

# INPUTS
#
# CONT_INPUT_CONTIGS_FILE - a fasta file containing contigs

# OUTPUTS

# CONT_OUTPUT_ORFS_FILE - Results file, containing ORFs

# Check that variables are set
[ -z "$CONT_INPUT_CONTIGS_FILE" ] && echo "Error: The CONT_INPUT_CONTIGS_FILE variable must be set" && exit 1

# Check that output file does not exist
# These break if there are spaces
[ -e "$CONT_OUTPUT_ORFS_FILE" ] && echo "Error: output file at $CONT_OUTPUT_ORFS_FILE already exists" && exit 1

# Check that output file is writable
[ ! -w $(dirname "$CONT_OUTPUT_ORFS_FILE") ] && echo "Error: output file $CONT_OUTPUT_ORFS_FILE is not writable" && exit 1

# - GLIMMER = g3-iterated.csh from the glimmer scripts dir. calls glimmer3 and elph
# - EXTRACT = extract from glimmer bin dir

# Variables are valid, run glimmer
# First glimmer, then extract, then number
GLIMMER_BIN=`which g3-iterated.csh`
EXTRACT_BIN=`which extract`
NUMBER_BIN=`which number_orfs.py`

# Tag is used by g3-iterated as the base name for a bunch of output files
TAG=$(basename $CONT_INPUT_CONTIGS_FILE)-glimmer

# g3-iterated writes its tag files in current working directory, so we should cd there
WORKDIR=$(dirname $CONT_OUTPUT_ORFS_FILE)
cd $WORKDIR

GLIMMER_CMD="$GLIMMER_BIN $CONT_INPUT_CONTIGS_FILE $TAG"
GLIMMER_VERSION=$(cat $GLIMMER_DIR/VERSION)
# Extract command reads a coords file generated by g3-iterated
EXTRACT_CMD="$EXTRACT_BIN $CONT_INPUT_CONTIGS_FILE $TAG.coords > $TAG.extract"
NUMBER_CMD="$NUMBER_BIN $TAG.extract $CONT_OUTPUT_ORFS_FILE"

echo
echo "Starting $0..."
echo "$GLIMMER_VERSION"
echo "Running glimmer:"
echo "$GLIMMER_CMD"
sh -c "$GLIMMER_CMD"

echo "Running extract:"
echo "$EXTRACT_CMD"
sh -c "$EXTRACT_CMD"

echo "Running number:"
echo "$NUMBER_CMD"
sh -c "$NUMBER_CMD"
