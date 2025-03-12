#!/bin/bash

mkdir ../annotations/Agbis.PRJNA770841
cd ../annotations/Agbis.PRJNA770841

echo Agbis.PRJNA770841


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR16308470 \
--conditions SRR16308470:A \
--genome_file ../../Genomes/Agbis.GCA_000300575.2_ASM30057v2_genomic.fa

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


