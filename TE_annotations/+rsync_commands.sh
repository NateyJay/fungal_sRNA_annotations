
### sending to zorzal

rsync -arv ../+genomes/+genome_files.txt nate@zorzal:/home/nate/TE_annotations
rsync -arv ./*.py nate@zorzal:/home/nate/TE_annotations



### retrieving from zorzal

# rsync -arv --exclude="*.fa" nate@zorzal:/home/nate/TE_annotations/genomes/* genomes/

rsync -arv nate@zorzal:/home/nate/TE_annotations/genomes/*/*.gff3 annotations/


