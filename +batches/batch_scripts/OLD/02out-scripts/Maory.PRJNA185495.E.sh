#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA185495.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Maory.PRJNA185495.E.bam
rm /scratch/njohnson/Maory.PRJNA185495.E.bam



