#!/bin/bash

mkdir ../annotations/Trasp.PRJNA638238
cd ../annotations/Trasp.PRJNA638238

echo Trasp.PRJNA638238


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Trasp.PRJNA638238.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR11961845:A -a /scratch/njohnson/Trasp.PRJNA638238.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Trasp.PRJNA638238.bam
rm /scratch/njohnson/Trasp.PRJNA638238.bam.bai
rm /scratch/njohnson/Trasp.PRJNA638238.depth.txt



