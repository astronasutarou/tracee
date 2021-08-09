#!/usr/bin/env python
# -*- coding: utf-8 -*-
import numpy as np
import tracee

# Load the data table.
# The table should have three columns.
filename = 'sample/mockdata_N006F030D500d00_b7e8.txt'
data = np.loadtxt(filename)

# Generate a parameter set.
param = tracee.default_parameters()
param.limit = 10  # Set the minimum number of points to 10.

# Call tracee.extract to identify tracklets.
# The function returns a list of Tracklet instances.
# The Tracklet instance contains
#   - tail: the starting point.
#   - head: the terminal point.
#   - members: a list of the associated points.
tracklet = tracee.extract(data, n_neighbor=3, param=param)
