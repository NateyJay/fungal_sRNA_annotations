#!/bin/bash

mkdir ../annotations/Zytri.PRJNA480952
cd ../annotations/Zytri.PRJNA480952

echo Zytri.PRJNA480952.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Zytri.PRJNA480952.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Zytri.PRJNA480952.D.bam
rm /scratch/njohnson/Zytri.PRJNA480952.D.bam



