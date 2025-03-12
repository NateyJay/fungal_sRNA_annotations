#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA481323
cd ../annotations/Rhirr.PRJNA481323

echo Rhirr.PRJNA481323


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7525701 SRR7525700 SRR7525699 SRR7525692 SRR7525691 SRR7525690 \
--conditions SRR7525701:C SRR7525700:C SRR7525699:C SRR7525692:D SRR7525691:D SRR7525690:D \
--genome_file ../../Genomes/Rhirr.GCF_000439145.1_ASM43914v3_genomic.fa

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


