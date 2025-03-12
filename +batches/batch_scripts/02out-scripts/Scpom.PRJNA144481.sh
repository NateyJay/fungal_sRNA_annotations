#!/bin/bash

mkdir ../annotations/Scpom.PRJNA144481
cd ../annotations/Scpom.PRJNA144481

echo Scpom.PRJNA144481


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA144481.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR307706:A -a /scratch/njohnson/Scpom.PRJNA144481.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA144481.bam
rm /scratch/njohnson/Scpom.PRJNA144481.bam.bai
rm /scratch/njohnson/Scpom.PRJNA144481.depth.txt



