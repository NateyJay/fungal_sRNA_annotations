#!/bin/bash

mkdir ../annotations/Gasin.PRJNA42807
cd ../annotations/Gasin.PRJNA42807

echo Gasin.PRJNA42807


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Gasin.PRJNA42807.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR929280:A SRR1562261:A -a /scratch/njohnson/Gasin.PRJNA42807.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Gasin.PRJNA42807.bam
rm /scratch/njohnson/Gasin.PRJNA42807.bam.bai
rm /scratch/njohnson/Gasin.PRJNA42807.depth.txt



