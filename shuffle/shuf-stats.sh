#!/usr/bin/env bash
set -eo pipefail

species=$1

procedure()
{
    local species=$1
    local locustype=$2
    pfx=species/${species}/${species}
    prefix=species/${species}/${species}.${locustype}
    xtractore --type=locus --outfile=${prefix}.shuffled.fa \
        ${prefix}.shuffled.gff3 \
        ${pfx}.gdna.fa
    genhub-stats.py --${locustype} ${prefix}.shuffled.gff3 \
        ${prefix}.shuffled.fa \
        ${prefix}.shuffled.tsv
}

procedure $1 iloci &
procedure $1 miloci &
wait
