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

align()
{
    local speclabel=$1
    local spec=$(echo $speclabel | tr '[:upper:]' '[:lower:]')
    MakeArray ${spec}-tsa.fa
    mpirun -np 8 \
    GeneSeqerMPIl -s Arabidopsis \
                  -L species/${speclabel}/${speclabel}.gdna.fa \
                  -D ${spec}-tsa.fa \
                  -O ${spec}.gsq \
                  -p prmfileHQ -x 30 -y 45 -z 60 -w 0.8 -m 1000000 \
                  > ${spec}-gsq.log 2>&1
}

do_gaeval()
{
    local speclabel=$1
    local spec=$(echo $speclabel | tr '[:upper:]' '[:lower:]')
    ./gsq2makergff3.py < ${spec}.gsq > ${spec}-gsq.gff3
    gaeval ${spec}-gsq.gff3 species/${speclabel}/${speclabel}.iloci.gff3 \
        --tsv ${spec}-gaeval.tsv \
        > ${spec}-gaeval.gff3 \
        2> >(grep -v 'has not been previously introduced')
}

fidibus -p 2 --refr=Pdom,Pcan download prep
download_tsa pcan ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/GA/FR/GAFR01/GAFR01.1.fsa_nt.gz
download_tsa pdom ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/GE/DB/GEDB01/GEDB01.1.fsa_nt.gz
align Pcan
align Pdom
do_gaeval Pcan
do_gaeval Pdom
