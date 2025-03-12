#!/bin/bash

mkdir ../annotations/Scpom.PRJNA183638
cd ../annotations/Scpom.PRJNA183638

echo Scpom.PRJNA183638


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR630476 SRR630475 SRR630476 SRR630474 SRR630474 \
--conditions SRR630476:Z.d1 SRR630475:Z.d1 SRR630476:Z.d1 SRR630474:A SRR630474:A \
--genome_file ../../Genomes/Scpom.GCA_000002945.2_ASM294v2_genomic.fa

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


