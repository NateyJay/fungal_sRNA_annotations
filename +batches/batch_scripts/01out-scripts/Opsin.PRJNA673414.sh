#!/bin/bash

mkdir ../annotations/Opsin.PRJNA673414
cd ../annotations/Opsin.PRJNA673414

echo Opsin.PRJNA673414


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR12952906 SRR12952905 SRR12952904 SRR12952902 SRR12952903 SRR12952901 SRR12952900 SRR12952899 SRR12952898 \
--conditions SRR12952906:A SRR12952905:A SRR12952904:A SRR12952902:B SRR12952903:B SRR12952901:B SRR12952900:C SRR12952899:C SRR12952898:C \
--genome_file ../../Genomes/Opsin.GCA_012934285.1_ASM1293428v1_genomic.fa

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


