#!/bin/bash

mkdir ../annotations/Maory.PRJNA751253
cd ../annotations/Maory.PRJNA751253

echo Maory.PRJNA751253


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR15316624 SRR15316625 \
--conditions SRR15316624:A SRR15316625:B \
--genome_file ../../Genomes/Maory.GCF_000002495.2_MG8_genomic.fa

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


