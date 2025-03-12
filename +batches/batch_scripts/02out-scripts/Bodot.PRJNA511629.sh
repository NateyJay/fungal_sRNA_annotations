#!/bin/bash

mkdir ../annotations/Bodot.PRJNA511629
cd ../annotations/Bodot.PRJNA511629

echo Bodot.PRJNA511629


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bodot.PRJNA511629.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR8374850:A SRR8374847:B SRR8374848:C SRR8374849:D -a /scratch/njohnson/Bodot.PRJNA511629.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bodot.PRJNA511629.bam
rm /scratch/njohnson/Bodot.PRJNA511629.bam.bai
rm /scratch/njohnson/Bodot.PRJNA511629.depth.txt



