#!/bin/bash

set -e

# This is a script for a docker image to run Genovo
# It translates environment variables and wraps genovo command
#
# CONT prefix means this variable is expected to be set in the container at runtime

# INPUTS (see http://cs.stanford.edu/group/genovo/MANUAL)
#
# CONT_INPUT_READS_FILE - A fasta file containing reads to assemble
# CONT_INPUT_ASSEMBLE_ITERATIONS - The number of iterations to run when assembling - defaults to 10
# CONT_INPUT_FINALIZE_CUTOFF - The minimum length to use when outputting assembled contigs, defaults to 250

# OUTPUTS

# CONT_OUTPUT_CONTIGS_FILE - Results file, in fasta format.

# Check that variables are set
[ -z "$CONT_INPUT_READS_FILE" ] && echo "Error: The CONT_INPUT_READS_FILE variable must be set" && exit 1
[ -z "$CONT_OUTPUT_CONTIGS_FILE" ] && echo "Error: The CONT_OUTPUT_CONTIGS_FILE variable must be set" && exit 1

# Check that input files are readable
[ ! -r "$CONT_INPUT_READS_FILE" ] && echo "Error: input file $CONT_INPUT_READS_FILE does not exist or cannot be read" && exit 1

# Check that output file does not exist
# These break if there are spaces
[ -e "$CONT_OUTPUT_CONTIGS_FILE" ] && echo "Error: output file at $CONT_OUTPUT_CONTIGS_FILE already exists" && exit 1

# Check that output file is writable
[ ! -w $(dirname "$CONT_OUTPUT_CONTIGS_FILE") ] && echo "Error: output file $CONT_OUTPUT_CONTIGS_FILE is not writable" && exit 1

# Variables are valid, run genovo
# First assemble, then finalize
ASSEMBLE_BIN=`which assemble`
FINALIZE_BIN=`which finalize`
ASSEMBLE_ITERATIONS="10"
FINALIZE_CUTOFF="250"

# If non-default values provided to container, use them
if [ ! -z "$CONT_INPUT_ASSEMBLE_ITERATIONS" ]; then
  ASSEMBLE_ITERATIONS=$CONT_INPUT_ASSEMBLE_ITERATIONS
fi

if [ ! -z "$CONT_INPUT_FINALIZE_CUTOFF" ]; then
  FINALIZE_CUTOFF=$CONT_INPUT_FINALIZE_CUTOFF
fi

# Intermediate file must be in writable directory
# Could be temporary
DUMP_FILE=$CONT_OUTPUT_CONTIGS_FILE.dump

ASSEMBLE_CMD="$ASSEMBLE_BIN $CONT_INPUT_READS_FILE $ASSEMBLE_ITERATIONS $DUMP_FILE"
FINALIZE_CMD="$FINALIZE_BIN $FINALIZE_CUTOFF $CONT_OUTPUT_CONTIGS_FILE $DUMP_FILE"
GENOVO_VERSION=`head -n 1 $(dirname $ASSEMBLE_BIN)/MANUAL`

echo
echo "Starting $0..."
echo "$GENOVO_VERSION" # Manual is out of date and reports 0.3 for 0.4
echo "Commands:"
echo "$ASSEMBLE_CMD"
echo "$FINALIZE_CMD"
echo

sh -c "$ASSEMBLE_CMD" && sh -c "$FINALIZE_CMD"
