#!/bin/bash

mkdir ../annotations/Maory.PRJNA504419
cd ../annotations/Maory.PRJNA504419

echo Maory.PRJNA504419


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8170848 SRR8170849 SRR8170850 SRR8170852 \
--conditions SRR8170848:A SRR8170849:A SRR8170850:B SRR8170852:B \
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


