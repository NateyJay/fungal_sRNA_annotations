#!/bin/bash

mkdir ../annotations/Hicap.PRJNA514312
cd ../annotations/Hicap.PRJNA514312

echo Hicap.PRJNA514312


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Hicap.PRJNA514312.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR8428949:A SRR8428948:A SRR8428944:B SRR8428943:B -a /scratch/njohnson/Hicap.PRJNA514312.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Hicap.PRJNA514312.bam
rm /scratch/njohnson/Hicap.PRJNA514312.bam.bai
rm /scratch/njohnson/Hicap.PRJNA514312.depth.txt



