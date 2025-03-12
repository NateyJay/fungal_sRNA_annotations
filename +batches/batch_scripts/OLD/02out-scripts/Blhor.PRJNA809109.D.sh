#!/bin/bash

mkdir ../annotations/Blhor.PRJNA809109
cd ../annotations/Blhor.PRJNA809109

echo Blhor.PRJNA809109.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blhor.PRJNA809109.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Blhor.PRJNA809109.D.bam
rm /scratch/njohnson/Blhor.PRJNA809109.D.bam



