#!/bin/bash

mkdir ../annotations/Pustr.PRJNA355964
cd ../annotations/Pustr.PRJNA355964

echo Pustr.PRJNA355964


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Pustr.PRJNA355964.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR5082569:A SRR5078242:A -a /scratch/njohnson/Pustr.PRJNA355964.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Pustr.PRJNA355964.bam
rm /scratch/njohnson/Pustr.PRJNA355964.bam.bai
rm /scratch/njohnson/Pustr.PRJNA355964.depth.txt



