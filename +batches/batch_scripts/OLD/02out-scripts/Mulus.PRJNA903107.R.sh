#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.R

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.R.bam
yasma.py tradeoff -o . -n R -ac R -a /scratch/njohnson/Mulus.PRJNA903107.R.bam
rm /scratch/njohnson/Mulus.PRJNA903107.R.bam



