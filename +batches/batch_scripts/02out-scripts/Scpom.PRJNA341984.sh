#!/bin/bash

mkdir ../annotations/Scpom.PRJNA341984
cd ../annotations/Scpom.PRJNA341984

echo Scpom.PRJNA341984


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA341984.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A D -c SRR4190396:A SRR4190385:A SRR4190351:D SRR4190352:D -a /scratch/njohnson/Scpom.PRJNA341984.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA341984.bam
rm /scratch/njohnson/Scpom.PRJNA341984.bam.bai
rm /scratch/njohnson/Scpom.PRJNA341984.depth.txt



