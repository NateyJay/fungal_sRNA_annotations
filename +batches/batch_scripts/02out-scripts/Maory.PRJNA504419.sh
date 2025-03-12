#!/bin/bash

mkdir ../annotations/Maory.PRJNA504419
cd ../annotations/Maory.PRJNA504419

echo Maory.PRJNA504419


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA504419.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR8170848:A SRR8170849:A SRR8170850:B SRR8170852:B -a /scratch/njohnson/Maory.PRJNA504419.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Maory.PRJNA504419.bam
rm /scratch/njohnson/Maory.PRJNA504419.bam.bai
rm /scratch/njohnson/Maory.PRJNA504419.depth.txt



