#!/bin/bash

mkdir ../annotations/Scscl.PRJNA477286
cd ../annotations/Scscl.PRJNA477286

echo Scscl.PRJNA477286


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7407892 SRR7407904 SRR7407905 SRR7407908 SRR7407907 SRR7407906 SRR7407903 SRR7407909 SRR7407902 SRR7407896 SRR7407899 SRR7407898 SRR7407900 SRR7407901 SRR7407893 \
--conditions SRR7407892:A SRR7407904:A SRR7407905:A SRR7407908:B SRR7407907:B SRR7407906:B SRR7407903:C SRR7407909:C SRR7407902:C SRR7407896:D SRR7407899:D SRR7407898:D SRR7407900:E SRR7407901:E SRR7407893:E \
--genome_file ../../Genomes/Scscl.GCA_000146945.2_ASM14694v2_genomic.fa

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


