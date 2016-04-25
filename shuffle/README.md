# Random gene arrangement

To investigate whether gene clustering occurs more frequently than expected by chance, we computed random arrangments of genes and re-computed iLoci and associated statistics for comparison.

```bash
parallel --gnu --jobs=10 bash shuffle.sh {} ::: Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap
genhub-milocus-summary.py --shuffled --workdir=species --outfmt=tex \
                          Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap
```

The (phi, sigma) values of genome compactness were computed for the shuffled data for comparison with the observed data.
A single (phi, sigma) value was reported for each genome, computed as the average (centroid) of all (phi, sigma) values for that species.
For any genome with (phi, sigma) values whose distance from the centroid exceeds 2.25 times the average (phi, sigma) distance from the centroid, these outliers are removed and the centroid is recomputed.

```bash
genhub-compact.py --centroid=2.25 --length=1000000 --iqnt=0.95 --gqnt=0.05 \
                  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap \
    > phisigma-modorg-centroids.tsv
genhub-compact.py --shuffled --centroid=2.25 --length=1000000 --iqnt=0.95 --gqnt=0.05 \
                  Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap \
    > phisigma-modorg-shuffled-centroids.tsv
```