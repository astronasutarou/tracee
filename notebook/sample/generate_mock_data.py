#!/usr/bin/env python
# -*- coding: utf-8 -*-
from argparse import ArgumentParser as ap
from time import time
import numpy as np

header = '''Generated Mock Data

Parameters:
  number of objects: {n_object:d}
  number of frames: {n_frame:d}
  number of distractors: {n_distractor:d}
  object velocity: {velocity:.1f}
  object drop rate: {drop:.1f}
  field of view size: {size:d}
  random seed: {seed:d}
Columns:
  1st column: x position
  2nd column: y position
  3rd column: timestamp
'''
savefmt = ('%12.6f','%12.6f','%4d')


if __name__ == '__main__':
  parser = ap(description='generate mock data')

  parser.add_argument(
    'n_object', type=int,
    help='the number of moving objects')
  parser.add_argument(
    'n_frame', type=int,
    help='the number of frames')
  parser.add_argument(
    'n_distractor',  type=int,
    help='the number of distractors')
  parser.add_argument(
    '-v', '--velocity', type=int, default=5.0,
    help='the velocity of moving objects')
  parser.add_argument(
    '-s', '--scatter', type=float, default=0.2,
    help='scatter in the positions')
  parser.add_argument(
    '--drop', type=float, default=0.0,
    help='drop rate between [0,1]')
  parser.add_argument(
    '--seed', type=int, default=None,
    help='the seed of random generator')
  parser.add_argument(
    '--size', type=int, default=512,
    help='the size of the field of view')
  parser.add_argument(
    '--margin', type=int, default=64,
    help='margins of the field of view')
  parser.add_argument(
    '-q', '--quiet', action='store_true',
    help='disable plot')

  args = parser.parse_args()
  shape = (args.n_object,1)
  if args.seed is None:
    args.seed = round(time())%65536
  np.random.seed(args.seed)

  L = args.size-2*args.margin
  x0 = L*np.random.uniform(size=shape)+args.margin
  y0 = L*np.random.uniform(size=shape)+args.margin
  vx = args.velocity*np.random.normal(size=shape)
  vy = args.velocity*np.random.normal(size=shape)
  t = np.atleast_2d(np.arange(args.n_frame))

  x,y = (x0+vx*t).flatten(),(y0+vy*t).flatten()
  tt = np.tile(t,args.n_object).flatten()
  x += np.random.normal(0, args.scatter, size=x.shape)
  y += np.random.normal(0, args.scatter, size=y.shape)

  position = np.vstack((x,y,tt)).T
  ## remove vertices outside of the field of view
  flag = (x>0) & (x<args.size) & (y>0) & (y<args.size)
  position = position[flag,:]
  ## remove random objects
  flag = np.random.uniform(size=position.shape[0])>args.drop
  position = position[flag,:]

  ## add distractors
  if args.n_distractor>0:
    dx = np.random.uniform(args.size, size=args.n_distractor)
    dy = np.random.uniform(args.size, size=args.n_distractor)
    dt = np.random.uniform(args.n_frame, size=args.n_distractor)
    dist = np.vstack((dx,dy,dt)).T
    position = np.concatenate((position,dist))

  ## sort position list chronologically
  idx = np.argsort(position[:,2])
  position = position[idx,:]

  filename = 'mockdata_N{:03d}F{:03d}D{:03d}d{:02d}_{:04x}.txt'.format(
    args.n_object,args.n_frame,args.n_distractor,
    round(args.drop*100),args.seed)
  np.savetxt(filename, position, fmt=savefmt,
             header=header.format(**args.__dict__))

  if args.quiet is False:
    import matplotlib.pyplot as plt
    fig = plt.figure(figsize=(10,10))
    ax = fig.add_subplot()
    ax.scatter(position[:,0],position[:,1],marker='+')
    fig.tight_layout()
    plt.show()
