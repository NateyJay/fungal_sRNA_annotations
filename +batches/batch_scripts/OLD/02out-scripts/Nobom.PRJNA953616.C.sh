#!/bin/bash

mkdir ../annotations/Nobom.PRJNA953616
cd ../annotations/Nobom.PRJNA953616

echo Nobom.PRJNA953616.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nobom.PRJNA953616.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Nobom.PRJNA953616.C.bam
rm /scratch/njohnson/Nobom.PRJNA953616.C.bam



