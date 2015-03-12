#!/bin/bash

set -e

# This is a script for a docker image to run MINE, a java program
# See http://www.exploredata.net/Usage-instructions/Parameters for parameters
# It translates environment variables and wraps MINE commands
#
# CONT prefix means this variable is expected to be set in the container at runtime

# INPUTS
#
# CONT_INPUT_CSV_FILE - A csv file containing the data
# CONT_INPUT_COMPARE_STYLE - variables to compare. Defaults to'-allPairs'
# CONT_INPUT_CV - % which need data for both variables before variables are compared Defaults to 0
# CONT_INPUT_EXP - The exponent in the equation B(n) = nα. Default value is 0.6
# CONT_INPUT_CLUMPS - clump factor. Default is 15

# OUTPUTS

# CONT_OUTPUT_RESULTS_CSV_FILE - Results file in CSV format

# Check that variables are set
[ -z "$CONT_INPUT_CSV_FILE" ] && echo "Error: The CONT_INPUT_CSV_FILE variable must be set" && exit 1

# Check that output file does not exist
# These break if there are spaces
[ -e "$CONT_OUTPUT_RESULTS_CSV_FILE" ] && echo "Error: output file at $CONT_OUTPUT_RESULTS_CSV_FILE already exists" && exit 1

# Check that output file is writable
[ ! -w $(dirname "$CONT_OUTPUT_RESULTS_CSV_FILE") ] && echo "Error: output file $CONT_OUTPUT_RESULTS_CSV_FILE is not writable" && exit 1


JAVA_BIN=`which java`
MINE_JAR=$MINE_DIR/MINE.jar
JAVA_OPTS="-Xmx1024m"
COMPARE_STYLE="-allPairs"
CV="0.0"
EXP="0.6"
CLUMPS="15"
JOBID="jobid"

# If non-default values provided to container, use them
if [ ! -z "$CONT_INPUT_COMPARE_STYLE" ]; then
  COMPARE_STYLE=$CONT_INPUT_COMPARE_STYLE
fi

if [ ! -z "$CONT_INPUT_CV" ]; then
  CV=$CONT_INPUT_CV
fi

if [ ! -z "$CONT_INPUT_EXP" ]; then
  EXP=$CONT_INPUT_EXP
fi

if [ ! -z "$CONT_INPUT_CLUMPS" ]; then
  CLUMPS=$CONT_INPUT_CLUMPS
fi

# MINE writes files to the same directory as the input file
# Since the input directory is mounted read-only, we have to symlink that
# file into a writable directory and use the symlink

WORKDIR=`mktemp -d`
ln -s $CONT_INPUT_CSV_FILE $WORKDIR
WORKDIR_INPUT_CSV_FILE=$WORKDIR/$(basename $CONT_INPUT_CSV_FILE)
# MINE writes a Results.csv and Status.txt file in the workdir
WORKDIR_RESULTS_CSV_FILE=$WORKDIR_INPUT_CSV_FILE,$JOBID,Results.csv
WORKDIR_STATUS_FILE=$WORKDIR_INPUT_CSV_FILE,$JOBID,Status.txt

MINE_CMD="$JAVA_BIN $JAVA_OPTS -jar $MINE_JAR $WORKDIR_INPUT_CSV_FILE $COMPARE_STYLE cv=$CV exp=$EXP c=$CLUMPS id=$JOBID"

echo
echo "Starting $0..."
echo "$MINE_CMD"
sh -c "$MINE_CMD"

mv "$WORKDIR_RESULTS_CSV_FILE" "$CONT_OUTPUT_RESULTS_CSV_FILE"
