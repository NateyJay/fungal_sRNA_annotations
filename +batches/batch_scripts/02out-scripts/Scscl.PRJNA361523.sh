#!/bin/bash

mkdir ../annotations/Scscl.PRJNA361523
cd ../annotations/Scscl.PRJNA361523

echo Scscl.PRJNA361523


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA361523.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR5181384:A SRR5180343:B -a /scratch/njohnson/Scscl.PRJNA361523.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA361523.bam
rm /scratch/njohnson/Scscl.PRJNA361523.bam.bai
rm /scratch/njohnson/Scscl.PRJNA361523.depth.txt



