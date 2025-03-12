#!/bin/bash

mkdir ../annotations/Fugra.PRJNA431527
cd ../annotations/Fugra.PRJNA431527

echo Fugra.PRJNA431527


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR21707787 SRR21708809 SRR6516242 SRR6516243 SRR6516244 SRR6516245 \
--conditions SRR21707787:A SRR21708809:A SRR6516242:B SRR6516243:B SRR6516244:C SRR6516245:C \
--genome_file ../../Genomes/Fugra.GCF_000240135.3_ASM24013v3_genomic.fa

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


