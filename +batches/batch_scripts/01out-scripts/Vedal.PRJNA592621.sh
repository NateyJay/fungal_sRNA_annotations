#!/bin/bash

mkdir ../annotations/Vedal.PRJNA592621
cd ../annotations/Vedal.PRJNA592621

echo Vedal.PRJNA592621


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR10572981 SRR10572980 \
--conditions SRR10572981:A SRR10572980:B \
--genome_file ../../Genomes/Vedal.GCA_000150675.2_ASM15067v2_genomic.fa

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


