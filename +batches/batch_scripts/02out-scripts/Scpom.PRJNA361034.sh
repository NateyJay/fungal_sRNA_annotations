#!/bin/bash

mkdir ../annotations/Scpom.PRJNA361034
cd ../annotations/Scpom.PRJNA361034

echo Scpom.PRJNA361034


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA361034.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR5168055:A -a /scratch/njohnson/Scpom.PRJNA361034.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA361034.bam
rm /scratch/njohnson/Scpom.PRJNA361034.bam.bai
rm /scratch/njohnson/Scpom.PRJNA361034.depth.txt



