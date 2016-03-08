# Summary of ten model organism genomes

[GenHub](https://standage.github.io/genhub) version [0.3.2](https://github.com/standage/genhub/releases/tag/0.3.2) was used to retrieve genome assemblies and annotations for ten model organisms from [NCBI RefSeq](http://www.ncbi.nlm.nih.gov/refseq/), pre-process the data, compute iLoci, and compile summary statistics over the data.

```bash
genhub-build.py --cfgdir=config/ \
                --workdir=species/ \
                --numprocs=10 \
                --batch=modorg \
                download format prepare stats
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
