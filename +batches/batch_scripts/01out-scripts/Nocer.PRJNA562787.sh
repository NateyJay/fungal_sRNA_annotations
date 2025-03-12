#!/bin/bash

mkdir ../annotations/Nocer.PRJNA562787
cd ../annotations/Nocer.PRJNA562787

echo Nocer.PRJNA562787


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR10034571 SRR10034573 SRR10034572 SRR10034578 SRR10034570 SRR10034579 \
--conditions SRR10034571:A SRR10034573:A SRR10034572:A SRR10034578:B SRR10034570:B SRR10034579:B \
--genome_file ../../Genomes/Nocer.GCF_000988165.1_ASM98816v1_genomic.fa

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


