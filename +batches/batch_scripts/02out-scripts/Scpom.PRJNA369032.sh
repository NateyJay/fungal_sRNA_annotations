#!/bin/bash

mkdir ../annotations/Scpom.PRJNA369032
cd ../annotations/Scpom.PRJNA369032

echo Scpom.PRJNA369032


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA369032.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR5208761:A -a /scratch/njohnson/Scpom.PRJNA369032.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA369032.bam
rm /scratch/njohnson/Scpom.PRJNA369032.bam.bai
rm /scratch/njohnson/Scpom.PRJNA369032.depth.txt



