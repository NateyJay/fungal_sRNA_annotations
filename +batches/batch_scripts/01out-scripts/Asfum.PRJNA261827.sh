#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1583968 SRR1583967 SRR1583964 SRR1583963 SRR1583960 SRR1583959 SRR1583956 SRR1583955 SRR1583970 SRR1583969 SRR1583966 SRR1583965 SRR1583961 SRR1583962 SRR1583957 SRR1583958 \
--conditions SRR1583968:A SRR1583967:A SRR1583964:B SRR1583963:B SRR1583960:C SRR1583959:C SRR1583956:D SRR1583955:D SRR1583970:E SRR1583969:E SRR1583966:F SRR1583965:F SRR1583961:G SRR1583962:G SRR1583957:H SRR1583958:H \
--genome_file ../../Genomes/Asfum.GCF_000002655.1_ASM265v1_genomic.fa

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


