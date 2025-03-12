#!/bin/bash

mkdir ../annotations/Hicap.PRJNA514312
cd ../annotations/Hicap.PRJNA514312

echo Hicap.PRJNA514312.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Hicap.PRJNA514312.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Hicap.PRJNA514312.B.bam
rm /scratch/njohnson/Hicap.PRJNA514312.B.bam



