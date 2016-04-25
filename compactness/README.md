# Evaluation of genome compactness

The (phi, sigma) measures of genome compactness were computed for each chromosome or scaffold of at least 1 Mb in length for ten model organisms.
Extremely long iiLoci (those in the top 5% of length for each species) and extremely short giLoci (those in the bottom 5%) were discarded as outliers prior to computing (phi, sigma).

```bash
genhub-compact.py --length=1000000 --iqnt=0.95 --gqnt=0.05 \
                  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap \
    > phisigma-modorg.tsv
```

The (phi, sigma) values were also computed for four genomes for which both community and NCBI/RefSeq annotations are available.
A single (phi, sigma) value was reported for each genome, computed as the average (centroid) of all (phi, sigma) values for that species.
For any species with (phi, sigma) values with a distance from the centroid that exceeds 2.25 times the average distance from the centroid, these outliers are removed and the centroid is recomputed.

```bash
genhub-compact.py --centroid=2.25 --length=1000000 --iqnt=0.95 --gqnt=0.05 \
                  Amel Am32 Dqua Dqcr Pcan Pccr Pdom Pdtl \
    > phisigma-alternates-centroids.tsv
```

See [compactness.ipynb](compactness.ipynb) for visualizations of these data.
