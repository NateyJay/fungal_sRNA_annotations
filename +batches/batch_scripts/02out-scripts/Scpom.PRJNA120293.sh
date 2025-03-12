#!/bin/bash

mkdir ../annotations/Scpom.PRJNA120293
cd ../annotations/Scpom.PRJNA120293

echo Scpom.PRJNA120293


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA120293.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR035547:A -a /scratch/njohnson/Scpom.PRJNA120293.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA120293.bam
rm /scratch/njohnson/Scpom.PRJNA120293.bam.bai
rm /scratch/njohnson/Scpom.PRJNA120293.depth.txt



