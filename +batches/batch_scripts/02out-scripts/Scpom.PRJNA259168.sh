#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259168
cd ../annotations/Scpom.PRJNA259168

echo Scpom.PRJNA259168


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA259168.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac B C D -c SRR1551870:B SRR1551870:B SRR1551869:C SRR1551869:C SRR1551868:D SRR1551868:D -a /scratch/njohnson/Scpom.PRJNA259168.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA259168.bam
rm /scratch/njohnson/Scpom.PRJNA259168.bam.bai
rm /scratch/njohnson/Scpom.PRJNA259168.depth.txt



