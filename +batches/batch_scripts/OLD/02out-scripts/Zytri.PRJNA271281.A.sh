#!/bin/bash

mkdir ../annotations/Zytri.PRJNA271281
cd ../annotations/Zytri.PRJNA271281

echo Zytri.PRJNA271281.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Zytri.PRJNA271281.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Zytri.PRJNA271281.A.bam
rm /scratch/njohnson/Zytri.PRJNA271281.A.bam



