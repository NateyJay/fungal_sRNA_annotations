#!/bin/bash

mkdir ../annotations/Tacam.PRJNA268267
cd ../annotations/Tacam.PRJNA268267

echo Tacam.PRJNA268267


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Tacam.PRJNA268267.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR1662192:A SRR1662191:B -a /scratch/njohnson/Tacam.PRJNA268267.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Tacam.PRJNA268267.bam
rm /scratch/njohnson/Tacam.PRJNA268267.bam.bai
rm /scratch/njohnson/Tacam.PRJNA268267.depth.txt



