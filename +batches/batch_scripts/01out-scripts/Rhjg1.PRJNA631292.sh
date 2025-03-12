#!/bin/bash

mkdir ../annotations/Rhjg1.PRJNA631292
cd ../annotations/Rhjg1.PRJNA631292

echo Rhjg1.PRJNA631292


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR11784190 SRR11784199 SRR11784198 SRR11784193 SRR11784192 SRR11784191 \
--conditions SRR11784190:A SRR11784199:B SRR11784198:C SRR11784193:D SRR11784192:E SRR11784191:F \
--genome_file ../../Genomes/Rhjg1.GCA_001541205.1_Rhosp1_genomic.fa

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


