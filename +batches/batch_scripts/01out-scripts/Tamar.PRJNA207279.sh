#!/bin/bash

mkdir ../annotations/Tamar.PRJNA207279
cd ../annotations/Tamar.PRJNA207279

echo Tamar.PRJNA207279


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR922412 SRR906436 \
--conditions SRR922412:A SRR906436:A \
--genome_file ../../Genomes/Tamar.GCF_009556855.1_ASM955685v1_genomic.fa

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


