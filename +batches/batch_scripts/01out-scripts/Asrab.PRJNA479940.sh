#!/bin/bash

mkdir ../annotations/Asrab.PRJNA479940
cd ../annotations/Asrab.PRJNA479940

echo Asrab.PRJNA479940


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR12847934 SRR12847935 SRR12847938 SRR12847939 SRR12847941 SRR12847940 SRR12847945 SRR12847944 SRR12847949 SRR12847948 \
--conditions SRR12847934:A SRR12847935:A SRR12847938:B SRR12847939:B SRR12847941:C SRR12847940:C SRR12847945:D SRR12847944:D SRR12847949:E SRR12847948:E \
--genome_file ../../Genomes/Asrab.GCA_004011695.2_ASM401169v2_genomic.fa

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


