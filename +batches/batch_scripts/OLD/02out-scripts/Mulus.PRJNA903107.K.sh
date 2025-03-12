#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.K

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.K.bam
yasma.py tradeoff -o . -n K -ac K -a /scratch/njohnson/Mulus.PRJNA903107.K.bam
rm /scratch/njohnson/Mulus.PRJNA903107.K.bam



