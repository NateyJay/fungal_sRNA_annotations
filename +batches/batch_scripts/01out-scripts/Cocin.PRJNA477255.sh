#!/bin/bash

mkdir ../annotations/Cocin.PRJNA477255
cd ../annotations/Cocin.PRJNA477255

echo Cocin.PRJNA477255


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7403493 SRR7403495 SRR7403494 SRR7403496 SRR7403497 SRR7403498 \
--conditions SRR7403493:A SRR7403495:A SRR7403494:A SRR7403496:B SRR7403497:B SRR7403498:B \
--genome_file ../../Genomes/Cocin.GCA_000182895.1_CC3_genomic.fa

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


