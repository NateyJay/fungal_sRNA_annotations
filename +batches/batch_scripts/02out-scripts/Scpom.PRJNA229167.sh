#!/bin/bash

mkdir ../annotations/Scpom.PRJNA229167
cd ../annotations/Scpom.PRJNA229167

echo Scpom.PRJNA229167


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA229167.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1032901:A SRR1032901:A -a /scratch/njohnson/Scpom.PRJNA229167.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA229167.bam
rm /scratch/njohnson/Scpom.PRJNA229167.bam.bai
rm /scratch/njohnson/Scpom.PRJNA229167.depth.txt



