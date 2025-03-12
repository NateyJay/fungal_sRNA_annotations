#!/bin/bash

mkdir ../annotations/Fugra.PRJNA683746
cd ../annotations/Fugra.PRJNA683746

echo Fugra.PRJNA683746


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA683746.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR13222421:A SRR13222412:A SRR13222420:A SRR13222416:B SRR13222417:B SRR13222418:B -a /scratch/njohnson/Fugra.PRJNA683746.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fugra.PRJNA683746.bam
rm /scratch/njohnson/Fugra.PRJNA683746.bam.bai
rm /scratch/njohnson/Fugra.PRJNA683746.depth.txt



