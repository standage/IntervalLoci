#!/usr/bin/env python

from __future__ import print_function
import sys

hilocus_reps = dict()
print(next(sys.stdin), end='')
for line in sys.stdin:
    values = line.strip().split('\t')
    hid = values[0]
    locid = values[1] 
    species = values[3]
    if hid in hilocus_reps and species in hilocus_reps[hid]:
        continue
    print(line, end='')
    hilocus_reps[hid] = dict()
    hilocus_reps[hid][species] = locid
