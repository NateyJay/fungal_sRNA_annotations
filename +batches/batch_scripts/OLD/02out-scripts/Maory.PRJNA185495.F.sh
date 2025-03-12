#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA185495.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Maory.PRJNA185495.F.bam
rm /scratch/njohnson/Maory.PRJNA185495.F.bam



