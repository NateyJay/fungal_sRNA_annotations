#!/bin/bash

mkdir ../annotations/Vedah.PRJNA819185
cd ../annotations/Vedah.PRJNA819185

echo Vedah.PRJNA819185


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR18490847 SRR18490848 SRR18490849 SRR18490853 SRR18490856 SRR18490857 \
--conditions SRR18490847:A SRR18490848:A SRR18490849:A SRR18490853:B SRR18490856:B SRR18490857:B \
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


