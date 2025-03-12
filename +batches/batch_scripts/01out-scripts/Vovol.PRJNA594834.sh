#!/bin/bash

mkdir ../annotations/Vovol.PRJNA594834
cd ../annotations/Vovol.PRJNA594834

echo Vovol.PRJNA594834


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR10727288 SRR10727296 SRR10727297 SRR10727289 SRR10727290 SRR10727291 SRR10727292 SRR10727293 SRR10727294 SRR10727299 SRR10727298 SRR10727295 \
--conditions SRR10727288:A SRR10727296:A SRR10727297:A SRR10727289:B SRR10727290:B SRR10727291:B SRR10727292:C SRR10727293:C SRR10727294:C SRR10727299:D SRR10727298:D SRR10727295:D \
--genome_file ../../Genomes/Vovol.GCA_000349905.1_VVO_genomic.fa

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


