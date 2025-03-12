#!/bin/bash

mkdir ../annotations/Glint.PRJNA142331
cd ../annotations/Glint.PRJNA142331

echo Glint.PRJNA142331


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Glint.PRJNA142331.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR088874:A SRR088875:A SRR088874:B -a /scratch/njohnson/Glint.PRJNA142331.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Glint.PRJNA142331.bam
rm /scratch/njohnson/Glint.PRJNA142331.bam.bai
rm /scratch/njohnson/Glint.PRJNA142331.depth.txt



