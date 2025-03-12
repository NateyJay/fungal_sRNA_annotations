#!/bin/bash

mkdir ../annotations/Scscl.PRJNA348385
cd ../annotations/Scscl.PRJNA348385

echo Scscl.PRJNA348385


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7407892 SRR7407904 SRR7407905 SRR7407900 SRR7407901 SRR7407893 SRR7407896 SRR7407899 SRR7407898 SRR7407903 SRR7407909 SRR7407902 SRR7407908 SRR7407907 SRR7407906 \
--conditions SRR7407892:A SRR7407904:A SRR7407905:A SRR7407900:B SRR7407901:B SRR7407893:B SRR7407896:C SRR7407899:C SRR7407898:C SRR7407903:D SRR7407909:D SRR7407902:D SRR7407908:E SRR7407907:E SRR7407906:E \
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


