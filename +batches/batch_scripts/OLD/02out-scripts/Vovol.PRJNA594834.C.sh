#!/bin/bash

mkdir ../annotations/Vovol.PRJNA594834
cd ../annotations/Vovol.PRJNA594834

echo Vovol.PRJNA594834.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vovol.PRJNA594834.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Vovol.PRJNA594834.C.bam
rm /scratch/njohnson/Vovol.PRJNA594834.C.bam



