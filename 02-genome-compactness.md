# 2. Evaluation of genome compactness

We assessed the compactness of 10 references genomes on two related measures.

- φ (phi), the proportion of giLoci merged into miLoci
- σ (sigma), the proportion of the genome sequence occupied by miLoci

Because these measures are uninformative on small scales, (φ, σ) values were computed only for chromosome or scaffold sequences of at least 1 Mb in length.
Extremely long iiLoci (those in the top 5% of length for each species) and extremely short giLoci (those in the bottom 5%) were discarded as outliers prior to computing (φ, σ).

```bash
genhub-compact.py --workdir=data/ --length=1000000 \
                  --iqnt=0.95 --gqnt=0.05 \
                  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap \
    > phisigma-refr.tsv
```

## Different sources of annotation

To evaluate the robustness of the (φ, σ) measures with respect to annotation source, we also computed (φ, σ) values on four social insect genomes for which both community and NCBI/RefSeq annotations are available.

```bash
genhub-build.py --workdir=data/
                --numprocs=4 \
                --genome=Amel,Am32,Dqua,Dqcr,Pcan,Pccr,Pdom,Pdtl \
                download format prepare stats
```

When computing (φ, σ) values for these genomes, the same filters for outliers described above were appled.
Rather than reporting (φ, σ) values for each chromosome/scaffold sequence, however, a single pair of (φ, σ) values was reported for each genome, computed as the average (centroid) of all chromosome/scaffold-level (φ, σ) values for that species.
For any genome with (φ, σ) values whose distance from the centroid exceeds 2.25 times the average (φ, σ) distance from the centroid, these outliers were removed and the centroid recomputed.

```bash
genhub-compact.py --workdir=data/ --centroid=2.25 --length=1000000
                  --iqnt=0.95 --gqnt=0.05 \
                  Amel Am32 Dqua Dqcr Pcan Pccr Pdom Pdtl \
    > phisigma-alternates.tsv
```

## Different values of δ

To evaluate the robustness of the (φ, σ) measures with respect to the δ (delta) parameter, we recomputed iLoci at δ=300 and δ=750 for comparison with the default δ=500.

```bash
genhub-build.py --workdir=data-delta300/
                --numprocs=4 \
                --delta=300
                --genome=Scer,Cele,Crei,Mtru,Agam,Dmel,Xtro,Drer,Mmus,Hsap \
                download format prepare stats

genhub-build.py --workdir=data-delta750/
                --numprocs=4 \
                --delta=750
                --genome=Scer,Cele,Crei,Mtru,Agam,Dmel,Xtro,Drer,Mmus,Hsap \
                download format prepare stats
```

Centroid (φ, σ) values were then computed for each value of δ for comparison.

```bash
genhub-compact.py --workdir=data/ --centroid=2.25 --length=1000000 \
                  --iqnt=0.95 --gqnt=0.05 \
                  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap \
    > phisigma-refr-delta500.tsv

genhub-compact.py --workdir=data-delta300/ --centroid=2.25 --length=1000000 \
                  --iqnt=0.95 --gqnt=0.05 \
                  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap \
    > phisigma-refr-delta300.tsv

genhub-compact.py --workdir=data-delta750/ --centroid=2.25 --length=1000000 \
                  --iqnt=0.95 --gqnt=0.05 \
                  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap \
    > phisigma-refr-delta750.tsv
```

## Random gene arrangement

To investigate whether gene clustering occurs more frequently than expected by chance, we computed random arrangments of genes and re-computed iLoci and associated statistics for comparison.

```bash
cd shuffle/
parallel --gnu --jobs=10 bash shuffle.sh {} ::: Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap
cd ..

# Table 4 from the manuscript
genhub-milocus-summary.py --shuffled --workdir=sdata/ --outfmt=tex \
                          Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap
```

The (φ, σ) values of genome compactness were computed for the shuffled data for comparison with the observed data.
Centroids were computed for each genome, as described above.

```bash
genhub-compact.py --workdir=data/ --centroid=2.25 --length=1000000 --iqnt=0.95 --gqnt=0.05 \
                  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap \
    > phisigma-modorg-centroids.tsv
genhub-compact.py --workdir=data/ --shuffled --centroid=2.25 --length=1000000 --iqnt=0.95 --gqnt=0.05 \
                  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap \
    > phisigma-modorg-centroids-shuffled.tsv
```

## Figures

See [02-genome-compactness.ipynb](02-genome-compactness.ipynb) for visualizations of these data.
