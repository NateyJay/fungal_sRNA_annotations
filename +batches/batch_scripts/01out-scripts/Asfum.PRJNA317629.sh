#!/bin/bash

mkdir ../annotations/Asfum.PRJNA317629
cd ../annotations/Asfum.PRJNA317629

echo Asfum.PRJNA317629


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3344727 SRR3344728 SRR3344697 SRR3344698 SRR3344714 SRR3344713 SRR3344682 SRR3344681 SRR3344690 SRR3344689 SRR3344719 SRR3344720 SRR3344706 SRR3344705 SRR3344674 SRR3344673 \
--conditions SRR3344727:A SRR3344728:A SRR3344697:A SRR3344698:A SRR3344714:A SRR3344713:A SRR3344682:A SRR3344681:A SRR3344690:B SRR3344689:B SRR3344719:B SRR3344720:B SRR3344706:B SRR3344705:B SRR3344674:B SRR3344673:B \
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


