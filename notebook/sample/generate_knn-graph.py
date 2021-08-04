#!/usr/bin/env python
# -*- coding: utf-8 -*-
from argparse import ArgumentParser as ap
import numpy as np
import tracee


if __name__ == '__main__':
  parser = ap(description='dump k-NN graph')

  parser.add_argument(
    'input', type=str, help='input file name')
  parser.add_argument(
    'k', type=int, help='the number of neighbor')
  parser.add_argument(
    'output', type=str, help='output file name')

  args = parser.parse_args()

  data = np.loadtxt(args.input)
  edge = tracee.generate_edge(data, args.k, 200)

  v0 = data[edge[:,0],:]
  v1 = data[edge[:,1],:]
  els = np.hstack((v0,v1))

  print(els)
  fmt = ('%.3f','%.3f','%d','%.3f','%.3f','%d')
  np.savetxt(args.output, els, fmt=fmt)
