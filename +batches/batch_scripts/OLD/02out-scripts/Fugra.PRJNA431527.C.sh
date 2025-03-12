#!/bin/bash

mkdir ../annotations/Fugra.PRJNA431527
cd ../annotations/Fugra.PRJNA431527

echo Fugra.PRJNA431527.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA431527.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Fugra.PRJNA431527.C.bam
rm /scratch/njohnson/Fugra.PRJNA431527.C.bam



