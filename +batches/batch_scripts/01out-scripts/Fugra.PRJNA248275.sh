#!/bin/bash

mkdir ../annotations/Fugra.PRJNA248275
cd ../annotations/Fugra.PRJNA248275

echo Fugra.PRJNA248275


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1293689 SRR1293690 SRR1293691 \
--conditions SRR1293689:A SRR1293690:B SRR1293691:C \
--genome_file ../../Genomes/Fugra.GCF_000240135.3_ASM24013v3_genomic.fa

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


