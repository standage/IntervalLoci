#!/usr/bin/env bash
set -eo pipefail

# 1. Download transcripts
curl ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/GE/DB/GEDB01/GEDB01.1.fsa_nt.gz \
    | gunzip -c \
    | perl -ne 's/>gb\|([^\|]+)\|/>$1/; print' \
    > ${spec}-tsa.fa

# 2. Download genome
fidibus -p 2 --refr=Pdom,Pdtl download prep iloci breakdown stats

# 3. Splice align transcripts to genome
MakeArray pdom-tsa.fa
mpirun -np 8 \
    GeneSeqerMPIl -s Arabidopsis \
                  -L species/Pdom/Pdom.gdna.fa \
                  -D pdom-tsa.fa \
                  -O pdom-vs-pdom.gsq \
                  -p prmfileHQ -x 30 -y 45 -z 60 -w 0.8 -m 1000000 \
                  > pdom-vs-pdom.log 2>&1

# 4. Compute integrity scores
./gsq2makergff3.py < pdom-vs-pdom.gsq > pdom-vs-pdom.gff3
gaeval pdom-vs-pdom.gff3 species/Pdom/Pdom.iloci.gff3 \
    --tsv pdom-vs-pdom-gaeval.tsv \
    > pdom-vs-pdom-gaeval.gff3 \
    2> >(grep -v 'has not been previously introduced')
