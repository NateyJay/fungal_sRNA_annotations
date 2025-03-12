#!/bin/bash

mkdir ../annotations/Bocin.PRJNA282704
cd ../annotations/Bocin.PRJNA282704

echo Bocin.PRJNA282704


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA282704.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR3130005:A SRR2002965:B -a /scratch/njohnson/Bocin.PRJNA282704.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA282704.bam
rm /scratch/njohnson/Bocin.PRJNA282704.bam.bai
rm /scratch/njohnson/Bocin.PRJNA282704.depth.txt



