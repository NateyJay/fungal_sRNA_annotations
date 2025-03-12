#!/bin/bash

mkdir ../annotations/Pustr.PRJNA355964
cd ../annotations/Pustr.PRJNA355964

echo Pustr.PRJNA355964


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR5082569 SRR5078242 \
--conditions SRR5082569:A SRR5078242:A \
--genome_file ../../Genomes/Pustr.GCF_021901695.1_Pst134E36_v1_pri_genomic.fa

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


