#!/bin/bash

mkdir ../annotations/Blhor.PRJNA809109
cd ../annotations/Blhor.PRJNA809109

echo Blhor.PRJNA809109.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blhor.PRJNA809109.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Blhor.PRJNA809109.B.bam
rm /scratch/njohnson/Blhor.PRJNA809109.B.bam



