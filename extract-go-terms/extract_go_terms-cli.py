#!/usr/bin/env python

import argparse
from extract_go_terms import extract

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('blast_csv')
  parser.add_argument('goterms_csv')
  args = parser.parse_args()
  try:
    extract(args.blast_csv, args.goterms_csv)
  except Exception as e:
    print "Unable to extract GO Terms: {}".format(e)
    exit(1)
