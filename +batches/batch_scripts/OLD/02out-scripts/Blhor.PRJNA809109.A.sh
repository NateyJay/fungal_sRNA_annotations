#!/bin/bash

mkdir ../annotations/Blhor.PRJNA809109
cd ../annotations/Blhor.PRJNA809109

echo Blhor.PRJNA809109.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blhor.PRJNA809109.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Blhor.PRJNA809109.A.bam
rm /scratch/njohnson/Blhor.PRJNA809109.A.bam



