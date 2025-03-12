#!/bin/bash

mkdir ../annotations/Pabra.PRJNA931606
cd ../annotations/Pabra.PRJNA931606

echo Pabra.PRJNA931606


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR23341104 SRR23341106 SRR23341105 SRR23341109 SRR23341107 SRR23341108 SRR23341104 SRR23341106 SRR23341105 SRR23341109 SRR23341107 SRR23341108 \
--conditions SRR23341104:A SRR23341106:A SRR23341105:A SRR23341109:B SRR23341107:B SRR23341108:B SRR23341104:A SRR23341106:A SRR23341105:A SRR23341109:B SRR23341107:B SRR23341108:B \
--genome_file ../../Genomes/Pabra.GCA_000150735.2_Paracocci_br_Pb18_V2_genomic.fa

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


