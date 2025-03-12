#!/bin/bash

mkdir ../annotations/Glint.PRJNA142331
cd ../annotations/Glint.PRJNA142331

echo Glint.PRJNA142331.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Glint.PRJNA142331.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Glint.PRJNA142331.B.bam
rm /scratch/njohnson/Glint.PRJNA142331.B.bam



