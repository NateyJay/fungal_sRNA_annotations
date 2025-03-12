#!/bin/bash

mkdir ../annotations/Mucir.PRJNA200295
cd ../annotations/Mucir.PRJNA200295

echo Mucir.PRJNA200295


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1576768 \
--conditions SRR1576768:A \
--genome_file ../../Genomes/Mucir.GCA_000401635.1_Muco_sp_1006Ph_V1_genomic.fa

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


