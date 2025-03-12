#!/bin/bash

mkdir ../annotations/Bocin.PRJNA978613
cd ../annotations/Bocin.PRJNA978613

echo Bocin.PRJNA978613


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR24797115 SRR24797116 \
--conditions SRR24797115:A SRR24797116:A \
--genome_file ../../Genomes/Bocin.GCF_000143535.2_ASM14353v4_genomic.fa

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


