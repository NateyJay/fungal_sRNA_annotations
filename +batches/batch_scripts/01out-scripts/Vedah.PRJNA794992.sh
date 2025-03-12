#!/bin/bash

mkdir ../annotations/Vedah.PRJNA794992
cd ../annotations/Vedah.PRJNA794992

echo Vedah.PRJNA794992


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR17460083 SRR17460084 SRR17460085 \
--conditions SRR17460083:A SRR17460084:A SRR17460085:A \
--genome_file ../../Genomes/Vedah.GCA_000150675.2_ASM15067v2_genomic.fa

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


