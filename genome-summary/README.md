# Summary of ten model organism genomes

[GenHub](https://standage.github.io/genhub) version [0.3.7](https://github.com/standage/genhub/releases/tag/0.3.7) was used to retrieve genome assemblies and annotations for ten model organisms from [NCBI RefSeq](http://www.ncbi.nlm.nih.gov/refseq/), pre-process the data, compute iLoci, and compile summary statistics over the data.

```bash
genhub-build.py --cfgdir=config/ \
                --workdir=species/ \
                --numprocs=10 \
                --batch=modorg \
                download format prepare stats
```

Summaries of iLocus composition for these genomes were computed with the following commands.

```bash
genhub-ilocus-summary.py --outfmt=tex Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap
genhub-pilocus-summary.py --outfmt=tex Scer Cele Crei Mtru Agam Dmel Xtro Drer Mmus Hsap
```
