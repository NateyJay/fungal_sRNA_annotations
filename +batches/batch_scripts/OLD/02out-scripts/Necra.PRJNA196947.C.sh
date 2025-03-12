#!/bin/bash

mkdir ../annotations/Necra.PRJNA196947
cd ../annotations/Necra.PRJNA196947

echo Necra.PRJNA196947.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA196947.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Necra.PRJNA196947.C.bam
rm /scratch/njohnson/Necra.PRJNA196947.C.bam



