## copying the master table to darwin
scp /Volumes/YASMA/master_table.xlsx njohnson@darwin:/home2/njohnson/fungi_annotations/batch_scripts


## moving config scripts to darwin
# scp 01-make_alignments.py njohnson@darwin:/home2/njohnson/fungi_annotations/batch_scripts
# scp 02-make_annotations.py njohnson@darwin:/home2/njohnson/fungi_annotations/batch_scripts
# scp 03-make_extras.py njohnson@darwin:/home2/njohnson/fungi_annotations/batch_scripts
# scp 05-make_counts.py njohnson@darwin:/home2/njohnson/fungi_annotations/batch_scripts

scp *.py njohnson@darwin:/home2/njohnson/fungi_annotations/batch_scripts


## downloading all the annotations
rsync -arv --exclude="*.bam" --exclude="*.bai" --exclude="*.sra" --exclude="*.sralite" --exclude="*.fq" --exclude="*.fastq" --exclude="*.fq.gz"  --exclude="*.fasta" --exclude="*.fa.gz"  --exclude="locus_*.eps" --exclude="locus_*.txt" --exclude="*.fa" njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations

rsync -arv --exclude="*.sra" --exclude="*.sralite" --exclude="*.fq" --exclude="*.fq.gz" --exclude="*.fasta" --exclude="*.fa.gz"njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations


## troubleshooting

rsync -arv --exclude="*.sra" --exclude="*.sralite"  njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/Scjap.PRJNA770349 ../Scjap.PRJNA770349
rsync -arv --exclude="*.sra" --exclude="*.sralite"  njohnson@darwin:/home2/njohnson/fungi_annotations/Genomes/Scjap* ../+genomes
rsync -arv --exclude="*.sra" --exclude="*.sralite"  njohnson@darwin:/home2/njohnson/fungi_annotations/Genomes/Comil* ../+genomes

## getting all the genomes
rsync -arv --exclude="*.sra" --exclude="*.sralite"  njohnson@darwin:/home2/njohnson/fungi_annotations/Genomes/*.fa* ../+genomes

## getting alignment metadata
rsync -arv -narv --prune-empty-dirs --include="*.txt" --include="*/" --include="*/align/" --exclude="*" njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations

rsync -narv --prune-empty-dirs --include="*/hairpin/"  --exclude="*" njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations

## getting hairpins.txt files
rsync -arv -f"+ */" -f"+ */hairpin/" -f"+ */hairpin/*/" -f"+ */hairpin/*/hairpins.txt" -f"- *" njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations

## get a hairpin
scp njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/Plery.PRJNA450159/hairpin/A/folds/locus_1767.sub121-t.eps ../+annotations
scp njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/Asfla.PRJNA816993/hairpin/A/folds/locus_2944.side1.eps  ../hairpins
scp njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/Scscl.PRJNA678586/hairpin/A/folds/locus_1595.sub86-t.eps ../hairpins


## get hairpin files from input file

rsync -arv --files-from=../fungal_sRNA_annotations/03-hairpin_eps_files.txt njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations




#### cloning to the fungal_srnas drive on the NAS

rsync -arv --exclude="*.sra" --exclude="*.sralite" --exclude="*.fq" --exclude="*.fq.gz" --exclude="*.fasta" --exclude="*.fa.gz" --exclude="*.eps" njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ /Volumes/fungal_srnas/+annotations


rsync -arv --exclude="*.sra" --exclude="*.sralite" --exclude="*.fq" --exclude="*.fastq" --exclude="*.fa" --exclude="*.fasta" --exclude="*.gz" --exclude="*.eps" --exclude="*.bam" --exclude="*.bam.bai" njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ /Volumes/fungal_srnas/+annotations

## just the bams
# rsync -nzarv --prune-empty-directories --include "*.bam" --exclude="*" njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ /Volumes/fungal_srnas/+annotations 
# rsync -narv --prune-empty-dirs --include="alignment.bam" --include="*/align/" --exclude="*" ../+annotations/ ./
rsync -narv --prune-empty-dirs --include="alignment.bam" --include="*/" --include="*/align/" --exclude="*" njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ /Volumes/fungal_srnas/+annotations

# no clue why this wont work....
rsync -narv --prune-empty-dirs --include="*.txt" --include="*/" --include="*/align/" --exclude="*" njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations