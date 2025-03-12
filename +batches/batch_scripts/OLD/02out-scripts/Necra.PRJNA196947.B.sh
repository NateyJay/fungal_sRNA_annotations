#!/bin/bash

mkdir ../annotations/Necra.PRJNA196947
cd ../annotations/Necra.PRJNA196947

echo Necra.PRJNA196947.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA196947.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Necra.PRJNA196947.B.bam
rm /scratch/njohnson/Necra.PRJNA196947.B.bam



