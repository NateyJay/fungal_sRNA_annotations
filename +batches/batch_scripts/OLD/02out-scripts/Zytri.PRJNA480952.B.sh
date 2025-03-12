#!/bin/bash

mkdir ../annotations/Zytri.PRJNA480952
cd ../annotations/Zytri.PRJNA480952

echo Zytri.PRJNA480952.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Zytri.PRJNA480952.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Zytri.PRJNA480952.B.bam
rm /scratch/njohnson/Zytri.PRJNA480952.B.bam



