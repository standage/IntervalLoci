# 3a. *Daphnia pulex*

## Data retrieval

```bash
# Daphnia files must be downloaded manually
# http://genome.jgi.doe.gov/Dappu1/Dappu1.download.ftp.html
fidibus --workdir=data/ \
        --numprocs=2 \
        --refr=Turt \
        --local \
        --label=Dpul \
        --gdna=Daphnia_pulex.fasta.gz \
        --gff3=FrozenGeneCatalog20110204.gff3.gz \
        --prot=FrozenGeneCatalog20110204.proteins.fasta.gz \
        download prep iloci breakdown stats
```

## Summary

```bash
genhub-ilocus-summary.py --workdir=data/ --outfmt=tex Dpul
genhub-pilocus-summary.py --workdir=data/ --outfmt=tex Dpul
genhub-milocus-summary.py --workdir=data/ --outfmt=tex Dpul
```

## Compactness

```bash
genhub-compact.py --workdir=data/ --length=2000000 \
                  --iqnt=0.95 --gqnt=0.05 \
                  Amel Agam Dmel Dpul Tcas Turt \
    > phisigma-dpul.tsv
```