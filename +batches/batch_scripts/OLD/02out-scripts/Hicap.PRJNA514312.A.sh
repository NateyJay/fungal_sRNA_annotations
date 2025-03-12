#!/bin/bash

mkdir ../annotations/Hicap.PRJNA514312
cd ../annotations/Hicap.PRJNA514312

echo Hicap.PRJNA514312.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Hicap.PRJNA514312.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Hicap.PRJNA514312.A.bam
rm /scratch/njohnson/Hicap.PRJNA514312.A.bam



