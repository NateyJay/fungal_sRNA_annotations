#!/bin/bash

mkdir ../annotations/Scpom.PRJNA322455
cd ../annotations/Scpom.PRJNA322455

echo Scpom.PRJNA322455


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA322455.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac B -c SRR3571005:B SRR3571006:B -a /scratch/njohnson/Scpom.PRJNA322455.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA322455.bam
rm /scratch/njohnson/Scpom.PRJNA322455.bam.bai
rm /scratch/njohnson/Scpom.PRJNA322455.depth.txt



