#!/bin/bash

mkdir ../annotations/Fugra.PRJNA253151
cd ../annotations/Fugra.PRJNA253151

echo Fugra.PRJNA253151


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA253151.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac B -c SRR1427175:B -a /scratch/njohnson/Fugra.PRJNA253151.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fugra.PRJNA253151.bam
rm /scratch/njohnson/Fugra.PRJNA253151.bam.bai
rm /scratch/njohnson/Fugra.PRJNA253151.depth.txt



