#!/bin/bash

mkdir ../annotations/Mabru.PRJNA731035
cd ../annotations/Mabru.PRJNA731035

echo Mabru.PRJNA731035


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR14586322 SRR14586326 SRR14586325 SRR14586319 SRR14586320 SRR14586321 SRR14586318 SRR14586317 SRR14586316 SRR14586315 SRR14586324 SRR14586323 \
--conditions SRR14586322:A SRR14586326:A SRR14586325:A SRR14586319:B SRR14586320:B SRR14586321:B SRR14586318:C SRR14586317:C SRR14586316:C SRR14586315:D SRR14586324:D SRR14586323:D \
--genome_file ../../Genomes/Mabru.GCA_000298775.1_ASM29877v1_genomic.fa

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


