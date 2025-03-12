#!/bin/bash

mkdir ../annotations/Crneo.PRJNA526042
cd ../annotations/Crneo.PRJNA526042

echo Crneo.PRJNA526042


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Crneo.PRJNA526042.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR8697600:A SRR8697601:A -a /scratch/njohnson/Crneo.PRJNA526042.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Crneo.PRJNA526042.bam
rm /scratch/njohnson/Crneo.PRJNA526042.bam.bai
rm /scratch/njohnson/Crneo.PRJNA526042.depth.txt



