#!/bin/bash

mkdir ../annotations/Tratr.PRJNA508370
cd ../annotations/Tratr.PRJNA508370

echo Tratr.PRJNA508370


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8280354 SRR8280352 SRR8280353 SRR8280361 SRR8280363 SRR8280362 SRR8280359 SRR8280360 SRR8280358 SRR8280356 SRR8280357 SRR8280355 \
--conditions SRR8280354:A SRR8280352:A SRR8280353:A SRR8280361:B SRR8280363:B SRR8280362:B SRR8280359:C SRR8280360:C SRR8280358:C SRR8280356:D SRR8280357:D SRR8280355:D \
--genome_file ../../Genomes/Tratr.GCA_000171015.2_TRIAT_v2.0_genomic.fa

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


