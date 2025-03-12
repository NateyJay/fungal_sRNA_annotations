#!/bin/bash

mkdir ../annotations/Maory.PRJNA751253
cd ../annotations/Maory.PRJNA751253

echo Maory.PRJNA751253


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA751253.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR15316624:A SRR15316625:B -a /scratch/njohnson/Maory.PRJNA751253.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Maory.PRJNA751253.bam
rm /scratch/njohnson/Maory.PRJNA751253.bam.bai
rm /scratch/njohnson/Maory.PRJNA751253.depth.txt



