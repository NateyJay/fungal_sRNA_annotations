#!/bin/bash

mkdir ../annotations/Pabra.PRJNA480504
cd ../annotations/Pabra.PRJNA480504

echo Pabra.PRJNA480504


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7505898 SRR7505898 SRR7505896 SRR7505896 SRR7505897 SRR7505897 SRR7505894 SRR7505895 SRR7505891 SRR7505899 SRR7505892 SRR7505893 SRR7505894 SRR7505895 SRR7505891 SRR7505899 SRR7505892 SRR7505893 \
--conditions SRR7505898:A SRR7505898:A SRR7505896:A SRR7505896:A SRR7505897:A SRR7505897:A SRR7505894:B SRR7505895:B SRR7505891:B SRR7505899:B SRR7505892:B SRR7505893:B SRR7505894:C SRR7505895:C SRR7505891:C SRR7505899:C SRR7505892:C SRR7505893:C \
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


