#!/bin/bash

mkdir ../annotations/Putri.PRJNA266709
cd ../annotations/Putri.PRJNA266709

echo Putri.PRJNA266709


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1646809 SRR1646807 \
--conditions SRR1646809:A SRR1646807:A \
--genome_file ../../Genomes/Putri.GCF_026914185.1_ASM2691418v1_genomic.fa

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


