#!/bin/bash

mkdir ../annotations/Capar.PRJNA715092
cd ../annotations/Capar.PRJNA715092

echo Capar.PRJNA715092.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Capar.PRJNA715092.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Capar.PRJNA715092.C.bam
rm /scratch/njohnson/Capar.PRJNA715092.C.bam



