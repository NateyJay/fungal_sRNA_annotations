#!/bin/bash

mkdir ../annotations/Bocin.PRJNA253747
cd ../annotations/Bocin.PRJNA253747

echo Bocin.PRJNA253747


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA253747.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1482408:A -a /scratch/njohnson/Bocin.PRJNA253747.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA253747.bam
rm /scratch/njohnson/Bocin.PRJNA253747.bam.bai
rm /scratch/njohnson/Bocin.PRJNA253747.depth.txt



