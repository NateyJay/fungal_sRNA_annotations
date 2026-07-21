datasets summary genome taxon --inputfile +species_list.txt --reference --assembly-version latest --as-json-lines > genomes.jsonl
dataformat tsv genome --fields accession,organism*,annotinfo*,assmstats* --inputfile genomes.jsonl > genomes.tsv

datasets download genome taxon --inputfile +species_list.txt --dehydrated --reference --filename genomes.zip --assembly-version latest --include gff3
unzip -o genomes.zip -d dehydrated
datasets rehydrate --directory dehydrated