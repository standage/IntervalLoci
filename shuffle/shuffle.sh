species=$1

locuspocus --verbose --delta=0 --skipends --outfile=species/${species}/${species}.iloci.0d.gff3 species/${species}/${species}.gff3
./shuffle_iloci.py --seed=54321 --out=species/${species}/${species}.shuffled.genes.gff3 species/${species}/${species}.iloci.0d.gff3
locuspocus --verbose --delta=500 --skipends --cds --namefmt="${species}ILCshuf-%06lu" --outfile=species/${species}/${species}.iloci.shuffled.gff3 species/${species}/${species}.shuffled.genes.gff3
miloci.py < species/${species}/${species}.iloci.shuffled.gff3 > species/${species}/${species}.miloci.shuffled.gff3
