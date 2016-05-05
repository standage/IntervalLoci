# Interval loci (iLoci)

This repository (https://github.com/BrendelGroup/IntervalLoci) contains supplementary technical documentation for (Standage and Brendel, 2016) -- "the iLocus paper".
Instructions necessary to produce the results described in the paper, from primary sources to tables/figures, are described in detail.
Each individual analysis should run with no problem on a laptop or desktop computer, although reproducing all analyses requires hundreds of gigabytes of free disk space for temporary storage of raw and intermediate data files.

## How to use this documentation

The UNIX shell commands associated with each analysis are presented as a series of vignettes, interleaved with commentary, in Markdown files.
Graphics are produced in the Jupyter Notebook environment, and notebooks containing the Python code used to produce each figure (or set of related figures) is also provided.
Some vignettes depend on data produced by previous vignettes, so readers may find it easiest to complete vignettes in order.

Some long UNIX commands in this documentation are split across multiple lines.
This is done for the sake of readability.
The use of the backslash (`\`) character indicates that the following line is part of the same command.
For example, the command...

```bash
genhub-build.py --workdir=data/ \
                --genome=Pdom \
                download
```

...is identical to the command...

```bash
genhub-build.py --workdir=data/ --genome=Pdom download
```

## Software prerequisites

The majority of the data processing is done by scripts/programs associated with the following software packages.

- [GenHub](https://standage.github.io/genhub) version [0.3.7](https://github.com/standage/genhub/releases/tag/0.3.7), which relies on...
- [AEGeAn Toolkit](https://brendelgroup.github.io/AEGeAn) version [0.15.2](https://github.com/BrendelGroup/AEGeAn/releases/tag/v0.15.2), which in turn relies on...
- [GenomeTools Library](http://genometools.org) version [1.5.8](http://genometools.org/pub/genometools-1.5.8.tar.gz)

The Jupyter notebooks depend on the following Python libraries.

- jupyter
- pandas
- seaborn

## Questions or comments

If you are stuck, or if you have feedback for the authors, please feel free to send an email or (even better) open a ticket in the project's [issue tracker](https://github.com/BrendelGroup/IntervalLoci/issues).

- Daniel Standage: <daniel.standage@gmail.com>
- Volker Brendel: <vbrendel@indiana.edu>