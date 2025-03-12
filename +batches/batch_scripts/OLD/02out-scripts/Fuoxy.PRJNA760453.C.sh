#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA760453
cd ../annotations/Fuoxy.PRJNA760453

echo Fuoxy.PRJNA760453.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA760453.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Fuoxy.PRJNA760453.C.bam
rm /scratch/njohnson/Fuoxy.PRJNA760453.C.bam



