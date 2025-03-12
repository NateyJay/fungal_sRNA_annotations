#!/bin/bash

mkdir ../annotations/Scscl.PRJNA607657
cd ../annotations/Scscl.PRJNA607657

echo Scscl.PRJNA607657


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA607657.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR11117983:A SRR11117991:A SRR11117992:A -a /scratch/njohnson/Scscl.PRJNA607657.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA607657.bam
rm /scratch/njohnson/Scscl.PRJNA607657.bam.bai
rm /scratch/njohnson/Scscl.PRJNA607657.depth.txt



