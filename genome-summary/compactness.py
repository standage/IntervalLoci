#!/usr/bin/env python

from __future__ import division
from __future__ import print_function
import argparse
import re
import sys


parser = argparse.ArgumentParser()
parser.add_argument('--species', metavar='SPEC', help='optional species label')
parser.add_argument('-l', '--length', metavar='LEN', default=1000000, type=int,
                    help='length threshold; default is 1000000 (1 Mb)')
parser.add_argument('gff3', type=argparse.FileType('r'), help='miLocus GFF3')
args = parser.parse_args()

milocus_space = dict()
milocus_gene_count = dict()
total_space = dict()
total_gene_count = dict()
for line in args.gff3:
    if '\tlocus\t' not in line:
        continue

    values = line.split('\t')
    seqid = values[0]
    if seqid not in milocus_space:
        milocus_space[seqid] = 0
        milocus_gene_count[seqid] = 0
        total_space[seqid] = 0
        total_gene_count[seqid] = 0

    start = int(values[3]) - 1
    end = int(values[4])
    length = end - start
    attrs = values[8]
    efflenmatch = re.search('effective_length=(\d+)', attrs)
    assert efflenmatch
    efflen = int(efflenmatch.group(1))
    genecount = 0
    genecountmatch = re.search('child_gene=(\d+)', attrs)
    if genecountmatch:
        genecount = int(genecountmatch.group(1))
    total_space[seqid] += efflen
    total_gene_count[seqid] += genecount
    if 'iLocus_type=miLocus' in line:
        milocus_space[seqid] += efflen
        milocus_gene_count[seqid] += genecount

if(args.species):
    print('Species', end='\t')
print('AvgPercOcc', 'AvgPercGene', sep='\t')
perc_occ = list()
perc_gene = list()
for seqid in milocus_space:
    if total_space[seqid] < args.length:
        continue
    if args.species in ['Mmus', 'Hsap'] and ('NW_' in seqid or 'NT_' in seqid):
        continue
    po = milocus_space[seqid] / total_space[seqid]
    pg = milocus_gene_count[seqid] / total_gene_count[seqid]
    perc_occ.append(po)
    perc_gene.append(pg)
    if(args.species):
        print(args.species, end='\t')
    print('{:.4f}\t{:.4f}\t{}'.format(po, pg, seqid))
