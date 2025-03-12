#!/bin/bash

mkdir ../annotations/Cocin.PRJNA560364
cd ../annotations/Cocin.PRJNA560364

echo Cocin.PRJNA560364


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR9972093 SRR9972091 SRR9972092 SRR9972088 SRR9972090 SRR9972089 SRR9972086 SRR9972087 SRR9972094 \
--conditions SRR9972093:A SRR9972091:A SRR9972092:A SRR9972088:B SRR9972090:B SRR9972089:B SRR9972086:C SRR9972087:C SRR9972094:C \
--genome_file ../../Genomes/Cocin.GCA_000182895.1_CC3_genomic.fa

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


