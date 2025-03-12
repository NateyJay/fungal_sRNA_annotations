#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA472169
cd ../annotations/Fuoxy.PRJNA472169

echo Fuoxy.PRJNA472169.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA472169.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Fuoxy.PRJNA472169.C.bam
rm /scratch/njohnson/Fuoxy.PRJNA472169.C.bam



