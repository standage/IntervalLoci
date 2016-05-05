# 3a. *Daphnia pulex*

## Data retrieval

```bash
# Daphnia files must be downloaded manually
# https://github.com/standage/genhub/blob/master/docs/DPUL.md
genhub-build.py --workdir=data/ --genome=Turt download
genhub-build.py --workdir=data/
                --numprocs=2 \
                --genome=Dpul,Turt \
                format prepare stats
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