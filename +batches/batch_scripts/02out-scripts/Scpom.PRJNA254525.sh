#!/bin/bash

mkdir ../annotations/Scpom.PRJNA254525
cd ../annotations/Scpom.PRJNA254525

echo Scpom.PRJNA254525


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA254525.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1508480:A SRR1508480:A -a /scratch/njohnson/Scpom.PRJNA254525.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA254525.bam
rm /scratch/njohnson/Scpom.PRJNA254525.bam.bai
rm /scratch/njohnson/Scpom.PRJNA254525.depth.txt



