#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA185495.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Maory.PRJNA185495.D.bam
rm /scratch/njohnson/Maory.PRJNA185495.D.bam



