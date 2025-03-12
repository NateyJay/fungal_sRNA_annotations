#!/bin/bash

mkdir ../annotations/Scpom.PRJNA575857
cd ../annotations/Scpom.PRJNA575857

echo Scpom.PRJNA575857


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA575857.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR10231453:A -a /scratch/njohnson/Scpom.PRJNA575857.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA575857.bam
rm /scratch/njohnson/Scpom.PRJNA575857.bam.bai
rm /scratch/njohnson/Scpom.PRJNA575857.depth.txt



