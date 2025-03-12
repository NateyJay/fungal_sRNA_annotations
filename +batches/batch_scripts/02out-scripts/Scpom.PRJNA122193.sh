#!/bin/bash

mkdir ../annotations/Scpom.PRJNA122193
cd ../annotations/Scpom.PRJNA122193

echo Scpom.PRJNA122193


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA122193.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR035947:A -a /scratch/njohnson/Scpom.PRJNA122193.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA122193.bam
rm /scratch/njohnson/Scpom.PRJNA122193.bam.bai
rm /scratch/njohnson/Scpom.PRJNA122193.depth.txt



