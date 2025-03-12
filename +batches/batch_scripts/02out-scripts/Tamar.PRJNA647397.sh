#!/bin/bash

mkdir ../annotations/Tamar.PRJNA647397
cd ../annotations/Tamar.PRJNA647397

echo Tamar.PRJNA647397


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Tamar.PRJNA647397.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR12271078:A SRR12271079:A SRR12271080:A -a /scratch/njohnson/Tamar.PRJNA647397.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Tamar.PRJNA647397.bam
rm /scratch/njohnson/Tamar.PRJNA647397.bam.bai
rm /scratch/njohnson/Tamar.PRJNA647397.depth.txt



