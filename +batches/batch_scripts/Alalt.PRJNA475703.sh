#!/bin/bash

mkdir ../annotations/Alalt.PRJNA475703
cd ../annotations/Alalt.PRJNA475703

echo Alalt.PRJNA475703


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7294210 SRR7294208 SRR7294207 SRR7294209 \
--conditions SRR7294210:A SRR7294208:A SRR7294207:B SRR7294209:B \
--genome_file ../../Genomes/Alalt.GCA_001642055.1_Altal1_genomic.fa

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


