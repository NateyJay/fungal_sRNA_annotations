#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA185495.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Maory.PRJNA185495.A.bam
rm /scratch/njohnson/Maory.PRJNA185495.A.bam



