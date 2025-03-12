#!/bin/bash

mkdir ../annotations/Plost.PRJNA448380
cd ../annotations/Plost.PRJNA448380

echo Plost.PRJNA448380


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR6926089 SRR6926090 SRR6926088 SRR6926082 SRR6926081 SRR6926080 SRR6926073 SRR6926072 SRR6926071 SRR6926055 SRR6926054 SRR6926053 SRR6926045 SRR6926046 SRR6926044 SRR6926063 SRR6926064 SRR6926062 \
--conditions SRR6926089:A SRR6926090:A SRR6926088:A SRR6926082:B SRR6926081:B SRR6926080:B SRR6926073:C SRR6926072:C SRR6926071:C SRR6926055:D SRR6926054:D SRR6926053:D SRR6926045:E SRR6926046:E SRR6926044:E SRR6926063:F SRR6926064:F SRR6926062:F \
--genome_file ../../Genomes/Plost.GCA_014466165.1_ASM1446616v1_genomic.fa

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


