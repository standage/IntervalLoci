# Summary of ten model organism genomes

[GenHub](https://standage.github.io/genhub) version [0.3.4](https://github.com/standage/genhub/releases/tag/0.3.4) was used to retrieve genome assemblies and annotations for ten model organisms from [NCBI RefSeq](http://www.ncbi.nlm.nih.gov/refseq/), pre-process the data, compute iLoci, and compile summary statistics over the data.

```bash
genhub-build.py --cfgdir=config/ \
                --workdir=species/ \
                --numprocs=10 \
                --batch=modorg \
                download format prepare stats
```

A table giving a breakdown of iLocus counts by type was produced with the following command.

```bash
for species in Scer Cele Crei Mtru Dmel Agam Xtro Drer Mmus Hsap
do
    echo ""
    echo -n $species$'\t'
    perl -ne 'm/iLocus_type=([^;\n]+)/ and print "$1\n"' < species/${species}/${species}.iloci.gff3 \
        | sort \
        | uniq -c \
        | tr '\n' '\t'
done
```

The custom Python script `ilocus_summary.py` was used to generate summary tables for piLoci, niLoci, iiLoci, and miLoci.

```bash
echo "piLocus"
for species in Scer Cele Crei Mtru Dmel Agam Xtro Drer Mmus Hsap
do
    ./ilocus_summary.py --gff3=species/${species}/${species}.iloci.gff3 \
                        --type=piLocus \
                        --premrnas=species/${species}/${species}.pre-mrnas.tsv \
                        species/${species}/${species}.iloci.tsv \
        | tail -n 1
done

for loctype in niLocus iiLocus miLocus
do
    echo ""
    echo $loctype
    for species in Scer Cele Crei Mtru Dmel Agam Xtro Drer Mmus Hsap
    do
        ./ilocus_summary.py --gff3=species/${species}/${species}.iloci.gff3 \
                            --type=${loctype} \
                            species/${species}/${species}.iloci.tsv \
            | tail -n 1
    done
done
```

Genome *compactness* was measured by calculating the following two statistics on each chromosome or scaffold at least 1 Mb in length.
- the mean over all sequences of the percentage of sequence occupied by miLoci
- the mean over all sequences of the percentage of genes contained in miLoci
The custom Python script `compactness.py` was used to compute these statistics, and the Jupyter notebook `compactness.ipynb` was used to draw a scatterplot of these statistics.

```bash
echo $'Species\tAvgPercOcc\tAvgPercGene' > compactness.tsv
for species in Scer Cele Crei Mtru Dmel Agam Xtro Drer Mmus Hsap
do
    ./compactness.py --species=$species \
                     --length=1000000 \
                     species/${species}/${species}.miloci.gff3 \
        | tail -n 1 \
        >> compactness.tsv
done
```
