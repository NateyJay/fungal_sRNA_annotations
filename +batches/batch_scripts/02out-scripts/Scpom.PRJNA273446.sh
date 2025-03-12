#!/bin/bash

mkdir ../annotations/Scpom.PRJNA273446
cd ../annotations/Scpom.PRJNA273446

echo Scpom.PRJNA273446


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA273446.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac  -c  -a /scratch/njohnson/Scpom.PRJNA273446.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA273446.bam
rm /scratch/njohnson/Scpom.PRJNA273446.bam.bai
rm /scratch/njohnson/Scpom.PRJNA273446.depth.txt



