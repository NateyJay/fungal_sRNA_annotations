#!/bin/bash

mkdir ../annotations/Fubra.PRJNA510758
cd ../annotations/Fubra.PRJNA510758

echo Fubra.PRJNA510758.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fubra.PRJNA510758.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Fubra.PRJNA510758.C.bam
rm /scratch/njohnson/Fubra.PRJNA510758.C.bam



