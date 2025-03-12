#!/bin/bash

mkdir ../annotations/Peita.PRJNA576793
cd ../annotations/Peita.PRJNA576793

echo Peita.PRJNA576793


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR10257020 SRR10257021 SRR10257022 SRR10257028 SRR10257027 SRR10257026 SRR10257025 SRR10257024 SRR10257023 \
--conditions SRR10257020:A SRR10257021:A SRR10257022:A SRR10257028:Z.d2 SRR10257027:Z.d2 SRR10257026:Z.d2 SRR10257025:Y.d1 SRR10257024:Y.d1 SRR10257023:Y.d1 \
--genome_file ../../Genomes/Peita.GCA_002116305.1_ASM211630v1_genomic.fa

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


