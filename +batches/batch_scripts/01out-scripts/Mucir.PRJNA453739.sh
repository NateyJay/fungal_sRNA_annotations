#!/bin/bash

mkdir ../annotations/Mucir.PRJNA453739
cd ../annotations/Mucir.PRJNA453739

echo Mucir.PRJNA453739


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7068271 SRR7068276 \
--conditions SRR7068271:A SRR7068276:A \
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


