#!/bin/bash

mkdir ../annotations/Scpom.PRJNA727318
cd ../annotations/Scpom.PRJNA727318

echo Scpom.PRJNA727318


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA727318.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR14420089:A -a /scratch/njohnson/Scpom.PRJNA727318.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA727318.bam
rm /scratch/njohnson/Scpom.PRJNA727318.bam.bai
rm /scratch/njohnson/Scpom.PRJNA727318.depth.txt



