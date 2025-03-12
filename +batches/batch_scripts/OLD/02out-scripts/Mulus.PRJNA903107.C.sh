#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Mulus.PRJNA903107.C.bam
rm /scratch/njohnson/Mulus.PRJNA903107.C.bam



