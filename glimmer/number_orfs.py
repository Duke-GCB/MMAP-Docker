#!/usr/bin/env python

import sys

def number_orfs(input_orfs, output_orfs):
  '''
  Numbers the text on lines beginning with > in a fasta file
  '''
  count = 0
  with open(input_orfs, 'r') as inputfile:
    with open(output_orfs, 'w') as outputfile:
      for line in inputfile:
        if line.startswith('>'):
          line = '>{}_{}'.format(count, line[1:])
          count = count + 1
        outputfile.write(line)

if __name__ == '__main__':
  try:
    if len(sys.argv) != 3:
      raise Exception('Error, must provide an input file and output file')
    input_orfs, output_orfs = sys.argv[1], sys.argv[2]
    number_orfs(input_orfs, output_orfs)
  except Exception as e:
    print e.message
    exit(1)
