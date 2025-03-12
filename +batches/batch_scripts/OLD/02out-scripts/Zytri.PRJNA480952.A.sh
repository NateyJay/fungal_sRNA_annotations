#!/bin/bash

mkdir ../annotations/Zytri.PRJNA480952
cd ../annotations/Zytri.PRJNA480952

echo Zytri.PRJNA480952.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Zytri.PRJNA480952.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Zytri.PRJNA480952.A.bam
rm /scratch/njohnson/Zytri.PRJNA480952.A.bam



