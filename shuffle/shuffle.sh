species=$1

locuspocus --verbose --delta=0 --skipends --outfile=species/${species}/${species}.iloci.0d.gff3 species/${species}/${species}.gff3
./shuffle_iloci.py --seed=54321 --out=species/${species}/${species}.shuffled.genes.gff3 species/${species}/${species}.iloci.0d.gff3
locuspocus --verbose --delta=500 --skipends --cds --namefmt="${species}ILCshuf-%06lu" --outfile=species/${species}/${species}.iloci.shuffled.gff3 species/${species}/${species}.shuffled.genes.gff3
miloci.py < species/${species}/${species}.iloci.shuffled.gff3 > species/${species}/${species}.miloci.shuffled.gff3
xtractore --type=locus --outfile=species/${species}/${species}.iloci.shuffled.fa species/${species}/${species}.iloci.shuffled.gff3 species/${species}/${species}.gdna.fa
xtractore --type=locus --outfile=species/${species}/${species}.miloci.shuffled.fa species/${species}/${species}.miloci.shuffled.gff3 species/${species}/${species}.gdna.fa
genhub-stats.py --species=${species} --iloci species/${species}/${species}.iloci.shuffled.gff3 species/${species}/${species}.iloci.shuffled.fa species/${species}/${species}.iloci.shuffled.tsv
genhub-stats.py --species=${species} --miloci species/${species}/${species}.miloci.shuffled.gff3 species/${species}/${species}.miloci.shuffled.fa species/${species}/${species}.miloci.shuffled.tsv
