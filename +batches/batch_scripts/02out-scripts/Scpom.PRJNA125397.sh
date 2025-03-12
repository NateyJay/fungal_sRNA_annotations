#!/bin/bash

mkdir ../annotations/Scpom.PRJNA125397
cd ../annotations/Scpom.PRJNA125397

echo Scpom.PRJNA125397


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA125397.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR035639:A SRR035883:A SRR035642:A SRR035641:A SRR035640:A -a /scratch/njohnson/Scpom.PRJNA125397.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA125397.bam
rm /scratch/njohnson/Scpom.PRJNA125397.bam.bai
rm /scratch/njohnson/Scpom.PRJNA125397.depth.txt



