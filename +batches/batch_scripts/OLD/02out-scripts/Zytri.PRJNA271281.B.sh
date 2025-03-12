#!/bin/bash

mkdir ../annotations/Zytri.PRJNA271281
cd ../annotations/Zytri.PRJNA271281

echo Zytri.PRJNA271281.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Zytri.PRJNA271281.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Zytri.PRJNA271281.B.bam
rm /scratch/njohnson/Zytri.PRJNA271281.B.bam



