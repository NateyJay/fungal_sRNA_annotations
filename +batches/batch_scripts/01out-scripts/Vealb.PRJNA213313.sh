#!/bin/bash

mkdir ../annotations/Vealb.PRJNA213313
cd ../annotations/Vealb.PRJNA213313

echo Vealb.PRJNA213313


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR943043 \
--conditions SRR943043:A \
--genome_file ../../Genomes/Vealb.GCA_002851705.1_ASM285170v1_genomic.fa

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


