#!/bin/bash

mkdir ../annotations/Scscl.PRJNA746614
cd ../annotations/Scscl.PRJNA746614

echo Scscl.PRJNA746614


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR15142509 SRR15142508 SRR15142507 SRR15142505 SRR15142504 SRR15142506 \
--conditions SRR15142509:A SRR15142508:A SRR15142507:A SRR15142505:B SRR15142504:B SRR15142506:B \
--genome_file ../../Genomes/Scscl.GCA_000146945.2_ASM14694v2_genomic.fa

echo "
downloading..."
yasma.py download -o .

echo "
finding adapters..."
yasma.py adapter -o .

echo "
trimming..."
yasma.py trim -o . --cores 28

echo "
aligning..."
yasma.py align -o . --cores 28


