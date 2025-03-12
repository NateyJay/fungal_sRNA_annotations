#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495.G

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA185495.G.bam
yasma.py tradeoff -o . -n G -ac G -a /scratch/njohnson/Maory.PRJNA185495.G.bam
rm /scratch/njohnson/Maory.PRJNA185495.G.bam



