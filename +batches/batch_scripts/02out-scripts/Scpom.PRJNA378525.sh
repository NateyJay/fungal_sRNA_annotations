#!/bin/bash

mkdir ../annotations/Scpom.PRJNA378525
cd ../annotations/Scpom.PRJNA378525

echo Scpom.PRJNA378525


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA378525.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR5320763:A SRR5320764:A -a /scratch/njohnson/Scpom.PRJNA378525.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA378525.bam
rm /scratch/njohnson/Scpom.PRJNA378525.bam.bai
rm /scratch/njohnson/Scpom.PRJNA378525.depth.txt



