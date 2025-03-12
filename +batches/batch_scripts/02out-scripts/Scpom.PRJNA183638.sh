#!/bin/bash

mkdir ../annotations/Scpom.PRJNA183638
cd ../annotations/Scpom.PRJNA183638

echo Scpom.PRJNA183638


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA183638.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR630474:A SRR630474:A -a /scratch/njohnson/Scpom.PRJNA183638.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA183638.bam
rm /scratch/njohnson/Scpom.PRJNA183638.bam.bai
rm /scratch/njohnson/Scpom.PRJNA183638.depth.txt



