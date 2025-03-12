#!/bin/bash

mkdir ../annotations/Fubra.PRJNA510758
cd ../annotations/Fubra.PRJNA510758

echo Fubra.PRJNA510758


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fubra.PRJNA510758.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR8362135:A SRR8362142:A SRR8362136:A SRR8362137:B SRR8362133:B SRR8362138:B SRR8362145:C SRR8362134:C SRR8362146:C -a /scratch/njohnson/Fubra.PRJNA510758.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fubra.PRJNA510758.bam
rm /scratch/njohnson/Fubra.PRJNA510758.bam.bai
rm /scratch/njohnson/Fubra.PRJNA510758.depth.txt



