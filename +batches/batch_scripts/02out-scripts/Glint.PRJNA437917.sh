#!/bin/bash

mkdir ../annotations/Glint.PRJNA437917
cd ../annotations/Glint.PRJNA437917

echo Glint.PRJNA437917


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Glint.PRJNA437917.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR6825868:A SRR6825869:A SRR6825873:A -a /scratch/njohnson/Glint.PRJNA437917.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Glint.PRJNA437917.bam
rm /scratch/njohnson/Glint.PRJNA437917.bam.bai
rm /scratch/njohnson/Glint.PRJNA437917.depth.txt



