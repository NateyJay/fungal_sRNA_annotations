#!/bin/bash

mkdir ../annotations/Caalb.PRJNA715092
cd ../annotations/Caalb.PRJNA715092

echo Caalb.PRJNA715092


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR14535487 SRR14535484 SRR14535488 SRR14535480 SRR14535479 SRR14535478 \
--conditions SRR14535487:A SRR14535484:A SRR14535488:A SRR14535480:B SRR14535479:B SRR14535478:B \
--genome_file ../../Genomes/Caalb.GCF_000182965.3_ASM18296v3_genomic.fa

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


