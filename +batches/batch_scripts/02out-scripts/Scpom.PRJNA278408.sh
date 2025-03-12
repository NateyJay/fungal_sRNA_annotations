#!/bin/bash

mkdir ../annotations/Scpom.PRJNA278408
cd ../annotations/Scpom.PRJNA278408

echo Scpom.PRJNA278408


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA278408.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1916774:A SRR1916773:A SRR1916772:A SRR1916771:A -a /scratch/njohnson/Scpom.PRJNA278408.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA278408.bam
rm /scratch/njohnson/Scpom.PRJNA278408.bam.bai
rm /scratch/njohnson/Scpom.PRJNA278408.depth.txt



