#!/bin/bash

mkdir ../annotations/Bebas.PRJNA517599
cd ../annotations/Bebas.PRJNA517599

echo Bebas.PRJNA517599.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bebas.PRJNA517599.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Bebas.PRJNA517599.C.bam
rm /scratch/njohnson/Bebas.PRJNA517599.C.bam



