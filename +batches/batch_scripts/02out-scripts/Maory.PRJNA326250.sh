#!/bin/bash

mkdir ../annotations/Maory.PRJNA326250
cd ../annotations/Maory.PRJNA326250

echo Maory.PRJNA326250


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA326250.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR3703046:A -a /scratch/njohnson/Maory.PRJNA326250.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Maory.PRJNA326250.bam
rm /scratch/njohnson/Maory.PRJNA326250.bam.bai
rm /scratch/njohnson/Maory.PRJNA326250.depth.txt



