#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA185495.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Maory.PRJNA185495.B.bam
rm /scratch/njohnson/Maory.PRJNA185495.B.bam



