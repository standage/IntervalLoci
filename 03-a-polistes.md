# 3a. *Polistes dominula*

## Summary

```bash
genhub-ilocus-summary.py --workdir=data/ --outfmt=tex Pdom
genhub-pilocus-summary.py --workdir=data/ --outfmt=tex Pdom
genhub-milocus-summary.py --workdir=data/ --outfmt=tex Pdom
```

## Compactness

```bash
fidibus --workdir=data/ \
        --numprocs=3 \
        --refr=Aech,Amel,Nvit \
        download prep iloci breakdown stats
genhub-compact.py --workdir=data/ --length=2000000 \
                  --iqnt=0.95 --gqnt=0.05 \
                  Amel Agam Aech Dmel Pdom Nvit \
    > phisigma-pdom.tsv
```

## Composition: r1.2 vs RefSeq

Definitely increase `--numprocs` for these steps if your machine is capable.

```bash
# Skip several previously downloaded genomes
fidibus --workdir=data/ --numprocs=4 \
        --refr=Acep,Ador,Aflo,Bimp,Bter,Cbir,Cflo,Hsal,Lhum,Mrot,Pbar,Sinv,Tcas \
        download prep iloci breakdown stats

cd pdom/r1.2/
fidibus --workdir=../../data/ \
        --numprocs=4 \
        --refr=Acep,Ador,Aech,Aflo,Amel,Bimp,Bter,Cbir,Cflo,Dmel,Dqua,Hsal,Lhum,Mrot,Nvit,Pbar,Pcan,Pdtl,Sinv,Tcas \
        cluster
../conserved.py --workdir=../../data/ GenHub.hiloci.tsv Amel Bter Cflo Hsal Pcan Pdtl Nvit \
    > hiloci-conserved-r1.2.tsv
../breakdown.py --counts <(cat ../../data/*/*.iloci.tsv) \
                GenHub.hiloci.tsv hiloci-conserved-r1.2.tsv \
    > breakdown-counts-r1.2.tsv
../breakdown.py <(cat ../../data/*/*.iloci.tsv) \
                GenHub.hiloci.tsv hiloci-conserved-r1.2.tsv \
    > breakdown-bp-r1.2.tsv

cd ../refseq/
fidibus --workdir=../../data/ \
        --numprocs=4 \
        --refr=Acep,Ador,Aech,Aflo,Amel,Bimp,Bter,Cbir,Cflo,Dmel,Dqua,Hsal,Lhum,Mrot,Nvit,Pbar,Pcan,Pdom,Sinv,Tcas \
        cluster
../conserved.py --workdir=../../data/ GenHub.hiloci.tsv Amel Bter Cflo Hsal Pcan Pdtl Nvit \
    > hiloci-conserved-refseq.tsv
../breakdown.py --counts <(cat ../../data/*/*.iloci.tsv) \
                GenHub.hiloci.tsv hiloci-conserved-refseq.tsv \
    > breakdown-counts-refseq.tsv
../breakdown.py <(cat ../../data/*/*.iloci.tsv) \
                GenHub.hiloci.tsv hiloci-conserved-refseq.tsv \
    > breakdown-bp-refseq.tsv
```