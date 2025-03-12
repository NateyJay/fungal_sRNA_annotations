#!/bin/bash

mkdir ../annotations/Scpom.PRJNA235985
cd ../annotations/Scpom.PRJNA235985

echo Scpom.PRJNA235985


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA235985.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1137061:A SRR1137061:A -a /scratch/njohnson/Scpom.PRJNA235985.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA235985.bam
rm /scratch/njohnson/Scpom.PRJNA235985.bam.bai
rm /scratch/njohnson/Scpom.PRJNA235985.depth.txt



