#!/bin/bash

mkdir ../annotations/Blhor.PRJNA809109
cd ../annotations/Blhor.PRJNA809109

echo Blhor.PRJNA809109.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blhor.PRJNA809109.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Blhor.PRJNA809109.C.bam
rm /scratch/njohnson/Blhor.PRJNA809109.C.bam



