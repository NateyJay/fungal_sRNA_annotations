#!/bin/bash

mkdir ../annotations/Scpom.PRJNA383112
cd ../annotations/Scpom.PRJNA383112

echo Scpom.PRJNA383112


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA383112.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR5453498:A -a /scratch/njohnson/Scpom.PRJNA383112.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA383112.bam
rm /scratch/njohnson/Scpom.PRJNA383112.bam.bai
rm /scratch/njohnson/Scpom.PRJNA383112.depth.txt



