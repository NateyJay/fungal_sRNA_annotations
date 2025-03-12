#!/bin/bash

mkdir ../annotations/Scpom.PRJNA154563
cd ../annotations/Scpom.PRJNA154563

echo Scpom.PRJNA154563


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA154563.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR315117:A -a /scratch/njohnson/Scpom.PRJNA154563.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA154563.bam
rm /scratch/njohnson/Scpom.PRJNA154563.bam.bai
rm /scratch/njohnson/Scpom.PRJNA154563.depth.txt



