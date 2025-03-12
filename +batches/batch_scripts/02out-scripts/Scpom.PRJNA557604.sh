#!/bin/bash

mkdir ../annotations/Scpom.PRJNA557604
cd ../annotations/Scpom.PRJNA557604

echo Scpom.PRJNA557604


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA557604.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR9866296:A -a /scratch/njohnson/Scpom.PRJNA557604.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA557604.bam
rm /scratch/njohnson/Scpom.PRJNA557604.bam.bai
rm /scratch/njohnson/Scpom.PRJNA557604.depth.txt



