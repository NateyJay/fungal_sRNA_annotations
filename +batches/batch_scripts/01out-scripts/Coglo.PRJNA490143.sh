#!/bin/bash

mkdir ../annotations/Coglo.PRJNA490143
cd ../annotations/Coglo.PRJNA490143

echo Coglo.PRJNA490143


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7814092 SRR7814094 SRR7814093 \
--conditions SRR7814092:A SRR7814094:A SRR7814093:A \
--genome_file ../../Genomes/Coglo.GCA_011800055.1_NFU_CgLc1_1.0_genomic.fa

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


