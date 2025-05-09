#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR22390019 SRR22390021 SRR22390022 SRR22390023 SRR22390024 SRR22390035 SRR22390036 SRR22390037 SRR22390038 SRR22390039 SRR22390041 SRR22390042 SRR22390043 SRR22390044 SRR22390045 SRR22390046 SRR22390047 SRR22390048 SRR22390049 \
--conditions SRR22390019:A SRR22390021:B SRR22390022:C SRR22390023:D SRR22390024:E SRR22390035:F SRR22390036:G SRR22390037:H SRR22390038:I SRR22390039:J SRR22390041:K SRR22390042:L SRR22390043:M SRR22390044:N SRR22390045:O SRR22390046:P SRR22390047:Q SRR22390048:R SRR22390049:S \
--genome_file ../../Genomes/Mulus.GCA_010203745.1_Muccir1_3_genomic.fa

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


