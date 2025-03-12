#!/bin/bash

mkdir ../annotations/Bocin.PRJNA282705
cd ../annotations/Bocin.PRJNA282705

echo Bocin.PRJNA282705


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA282705.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac C -c SRR2002963:C -a /scratch/njohnson/Bocin.PRJNA282705.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA282705.bam
rm /scratch/njohnson/Bocin.PRJNA282705.bam.bai
rm /scratch/njohnson/Bocin.PRJNA282705.depth.txt



