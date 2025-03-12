#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA900007
cd ../annotations/Rhsol.PRJNA900007

echo Rhsol.PRJNA900007


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR22252428 SRR22252429 SRR22252430 SRR22252431 SRR22252432 SRR22252433 SRR22252434 SRR22252445 SRR22252444 \
--conditions SRR22252428:B SRR22252429:B SRR22252430:C SRR22252431:C SRR22252432:D SRR22252433:E SRR22252434:E SRR22252445:H SRR22252444:H \
--genome_file ../../Genomes/Rhsol.GCA_016906535.1_ASM1690653v1_genomic.fa

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


