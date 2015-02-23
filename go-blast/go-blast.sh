#!/bin/bash

set -e

# This is a script for a docker image to perform BLAST queries against the
# Gene Ontology dataset.
# It translates environment variables and wraps the NCBI BLAST+ blastx command

# CONT prefix means this variable is expected to be set in the container at runtime

# INPUTS
#
# CONT_INPUT_ORFS_FILE - A file containing sequence ORFs to query
# CONT_INPUT_BLAST_DB - The path to the blastdb to use, with no extension
# CONT_BLAST_EVALUE - BLAST evalue, defaults to 1e-15

# OUTPUTS

# CONT_OUTPUT_BLAST_RESULTS - Results file, in BLAST CSV format with titles.

# Check that variables are set
[ -z "$CONT_INPUT_ORFS_FILE" ] && echo "Error: The CONT_INPUT_ORFS_FILE variable must be set" && exit 1
[ -z "$CONT_INPUT_BLAST_DB" ] && echo "Error: The CONT_INPUT_BLAST_DB variable must be set" && exit 1
[ -z "$CONT_OUTPUT_BLAST_RESULTS" ] && echo "Error: The CONT_OUTPUT_BLAST_RESULTS variable must be set" && exit 1

# Check that input files are readable
[ ! -r "$CONT_INPUT_ORFS_FILE" ] && echo "Error: input file $CONT_INPUT_ORFS_FILE does not exist or cannot be read" && exit 1
[ ! -r "$CONT_INPUT_BLAST_DB.pin" ] && echo "Error: BLAST DB at $CONT_INPUT_BLAST_DB does not exist or cannot be read" && exit 1

# Check that output file does not exist
# These break if there are spaces
[ -e "$CONT_OUTPUT_BLAST_RESULTS" ] && echo "Error: output file at $CONT_OUTPUT_BLAST_RESULTS already exists" && exit 1

# Check that output file is writable
[ ! -w $(dirname "$CONT_OUTPUT_BLAST_RESULTS") ] && echo "Error: output file $CONT_OUTPUT_BLAST_RESULTS is not writable" && exit 1

# Variables are valid, now run blast
BLAST_BIN=`which blastx`
BLAST_DBCMD=`which blastdbcmd`
# BLAST format 10 means csv. std is the set of standard fields, and stitle
# causes the subject titles to be included, which contain the GO terms.
BLAST_OUTFMT="10 std stitle"
BLAST_EVALUE="1e-15"

# If evalue provided to container, use it
if [ ! -z "$CONT_BLAST_EVALUE" ]; then
  BLAST_EVALUE=$CONT_BLAST_EVALUE
fi

CMD="$BLAST_BIN -db $CONT_INPUT_BLAST_DB -query $CONT_INPUT_ORFS_FILE -out $CONT_OUTPUT_BLAST_RESULTS -evalue \"$BLAST_EVALUE\" -outfmt '$BLAST_OUTFMT'"

echo
echo "Starting $0..."
echo "$($BLAST_BIN -version)"
echo "$($BLAST_DBCMD -db $CONT_INPUT_BLAST_DB -info)"
echo "Command:"
echo "$CMD"
echo

sh -c "$CMD"
