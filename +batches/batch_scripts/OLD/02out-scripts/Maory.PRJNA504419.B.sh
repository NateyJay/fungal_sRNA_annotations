#!/bin/bash

mkdir ../annotations/Maory.PRJNA504419
cd ../annotations/Maory.PRJNA504419

echo Maory.PRJNA504419.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA504419.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Maory.PRJNA504419.B.bam
rm /scratch/njohnson/Maory.PRJNA504419.B.bam



