#!/bin/bash

mkdir ../annotations/Scpom.PRJNA168300
cd ../annotations/Scpom.PRJNA168300

echo Scpom.PRJNA168300


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA168300.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR507110:A -a /scratch/njohnson/Scpom.PRJNA168300.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA168300.bam
rm /scratch/njohnson/Scpom.PRJNA168300.bam.bai
rm /scratch/njohnson/Scpom.PRJNA168300.depth.txt



