#!/bin/bash

mkdir ../annotations/Vedah.PRJNA198742
cd ../annotations/Vedah.PRJNA198742

echo Vedah.PRJNA198742


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR833802 \
--conditions SRR833802:A \
--genome_file ../../Genomes/Vedah.GCA_000150675.2_ASM15067v2_genomic.fa

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


