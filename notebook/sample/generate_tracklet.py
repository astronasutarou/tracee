#!/usr/bin/env python
# -*- coding: utf-8 -*-
from argparse import ArgumentParser as ap
import numpy as np
import tracee


if __name__ == '__main__':
  parser = ap(description='dump tracklet')

  parser.add_argument(
    'input', type=str, help='input file name')
  parser.add_argument(
    'k', type=int, help='the number of neighbor')
  parser.add_argument(
    'output', type=str, help='output file name')
  parser.add_argument(
    '-L', '--limit', type=int, default=10,
    help='shortest tracklet to be extracted')

  args = parser.parse_args()

  data = np.loadtxt(args.input)
  param = tracee.default_parameters()
  param.limit = args.limit
  tracklet = tracee.extract(data, n_neighbor=args.k, param=param)

  v0 = np.array([t.s for t in tracklet])
  v1 = np.array([t.e for t in tracklet])
  segment = np.hstack((v0,v1))

  print(segment)
  fmt = ('%.3f','%.3f','%d','%.3f','%.3f','%d')
  np.savetxt(args.output, segment, fmt=fmt)
