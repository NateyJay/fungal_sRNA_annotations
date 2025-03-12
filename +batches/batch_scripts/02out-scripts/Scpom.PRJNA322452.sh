#!/bin/bash

mkdir ../annotations/Scpom.PRJNA322452
cd ../annotations/Scpom.PRJNA322452

echo Scpom.PRJNA322452


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA322452.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR3570942:A SRR3570943:A -a /scratch/njohnson/Scpom.PRJNA322452.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA322452.bam
rm /scratch/njohnson/Scpom.PRJNA322452.bam.bai
rm /scratch/njohnson/Scpom.PRJNA322452.depth.txt



