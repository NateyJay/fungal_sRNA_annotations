#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3130367 SRR3130368 SRR3130369 SRR3130370 SRR3130371 SRR3130372 SRR3130373 SRR3130374 \
--conditions SRR3130367:A SRR3130368:B SRR3130369:C SRR3130370:D SRR3130371:E SRR3130372:F SRR3130373:G SRR3130374:H \
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


