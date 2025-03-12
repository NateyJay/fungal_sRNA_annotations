#!/bin/bash

mkdir ../annotations/Zytri.PRJNA480952
cd ../annotations/Zytri.PRJNA480952

echo Zytri.PRJNA480952.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Zytri.PRJNA480952.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Zytri.PRJNA480952.C.bam
rm /scratch/njohnson/Zytri.PRJNA480952.C.bam



