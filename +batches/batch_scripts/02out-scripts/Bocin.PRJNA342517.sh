#!/bin/bash

mkdir ../annotations/Bocin.PRJNA342517
cd ../annotations/Bocin.PRJNA342517

echo Bocin.PRJNA342517


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA342517.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR4235297:A -a /scratch/njohnson/Bocin.PRJNA342517.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA342517.bam
rm /scratch/njohnson/Bocin.PRJNA342517.bam.bai
rm /scratch/njohnson/Bocin.PRJNA342517.depth.txt



