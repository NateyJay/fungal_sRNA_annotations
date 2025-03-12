#!/bin/bash

mkdir ../annotations/Nacas.PRJNA354404
cd ../annotations/Nacas.PRJNA354404

echo Nacas.PRJNA354404


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8838457 SRR8838456 SRR8838455 SRR8838454 \
--conditions SRR8838457:Z.d1 SRR8838456:Z.d1 SRR8838455:A SRR8838454:A \
--genome_file ../../Genomes/Nacas.GCA_000237345.1_ASM23734v1_genomic.fa

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


