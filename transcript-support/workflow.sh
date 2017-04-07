#!/usr/bin/env bash
set -eo pipefail

download_tsa()
{
    local spec=$1
    local url=$2
    curl $url \
        | gunzip -c \
        | perl -ne 's/>gb\|([^\|]+)\|/>$1/; print' \
        > ${spec}-tsa.fa
}

align_pdom()
{
    MakeArray pdom-tsa.fa
    mpirun -np 8 \
    GeneSeqerMPIl -s Arabidopsis \
                  -L species/Pdom/Pdom.gdna.fa \
                  -D pdom-tsa.fa \
                  -O pdom-vs-pdom.gsq \
                  -p prmfileHQ -x 30 -y 45 -z 60 -w 0.8 -m 1000000 \
                  > pdom-vs-pdom.log 2>&1
}

align_pcan_pmet()
{
    MakeArray pcan-tsa.fa
    mpirun -np 8 \
    GeneSeqerMPIl -s Arabidopsis \
                  -L species/Pdom/Pdom.gdna.fa \
                  -D pcan-tsa.fa \
                  -O pcan-vs-pdom.gsq \
                  -p prmfile -x 16 -y 24 -z 48 -w 0.8 -m 1000000 \
                  > pcan-vs-pdom.log 2>&1
    
    MakeArray pmet-tsa.fa
    mpirun -np 8 \
    GeneSeqerMPIl -s Arabidopsis \
                  -L species/Pdom/Pdom.gdna.fa \
                  -D pmet-tsa.fa \
                  -O pmet-vs-pdom.gsq \
                  -p prmfile -x 16 -y 24 -z 48 -w 0.8 -m 1000000 \
                  > pmet-vs-pdom.log 2>&1
}

do_gaeval()
{
    local spec=$1
    ./gsq2makergff3.py < ${spec}-vs-pdom.gsq > ${spec}-vs-pdom.gff3
    gaeval pdom-vs-pdom.gff3 species/Pdom/Pdom.iloci.gff3 \
        > ${spec}-vs-pdom-gaeval.gff3 \
        2> >(grep -v 'has not been previously introduced')
    perl -ne 'm/gaeval_coverage=([^;\n]+)/ and print "$1\n"' \
        < ${spec}-vs-pdom-gaeval.gff3 \
        > ${spec}-vs-pdom-coverage.txt
    perl -ne 'm/gaeval_integrity=([^;\n]+)/ and print "$1\n"' \
        < ${spec}-vs-pdom-gaeval.gff3 \
        > ${spec}-vs-pdom-integrity.txt
}

#fidibus -p 4 --refr=Pdom,Pdtl,Pcan,Pccr download prep iloci breakdown stats
#download_tsa pcan ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/GA/FR/GAFR01/GAFR01.1.fsa_nt.gz
#download_tsa pdom ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/GE/DB/GEDB01/GEDB01.1.fsa_nt.gz
#download_tsa pmet ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/GD/HQ/GDHQ01/GDHQ01.1.fsa_nt.gz
#align_pdom
#align_pcan_pmet
#gsq_to_gff3 pcan-vs-pdom.gsq pcan-vs-pdom.gff3
#gsq_to_gff3 pdom-vs-pdom.gsq pdom-vs-pdom.gff3
#gsq_to_gff3 pmet-vs-pdom.gsq pmet-vs-pdom.gff3
do_gaeval pcan
do_gaeval pdom
do_gaeval pmet
