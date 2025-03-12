#!/bin/bash

mkdir ../annotations/Scpom.PRJNA177799
cd ../annotations/Scpom.PRJNA177799

echo Scpom.PRJNA177799


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA177799.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR593453:A -a /scratch/njohnson/Scpom.PRJNA177799.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA177799.bam
rm /scratch/njohnson/Scpom.PRJNA177799.bam.bai
rm /scratch/njohnson/Scpom.PRJNA177799.depth.txt



