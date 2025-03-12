#!/bin/bash

mkdir ../annotations/Scpom.PRJNA382810
cd ../annotations/Scpom.PRJNA382810

echo Scpom.PRJNA382810


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA382810.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR5445684:A SRR5445683:A SRR5445672:A -a /scratch/njohnson/Scpom.PRJNA382810.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA382810.bam
rm /scratch/njohnson/Scpom.PRJNA382810.bam.bai
rm /scratch/njohnson/Scpom.PRJNA382810.depth.txt



