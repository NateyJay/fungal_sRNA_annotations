#!/bin/bash

mkdir ../annotations/Fugra.PRJNA253153
cd ../annotations/Fugra.PRJNA253153

echo Fugra.PRJNA253153


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA253153.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1427176:A -a /scratch/njohnson/Fugra.PRJNA253153.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fugra.PRJNA253153.bam
rm /scratch/njohnson/Fugra.PRJNA253153.bam.bai
rm /scratch/njohnson/Fugra.PRJNA253153.depth.txt



