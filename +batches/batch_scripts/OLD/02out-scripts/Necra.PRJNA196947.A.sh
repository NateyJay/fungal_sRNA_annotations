#!/bin/bash

mkdir ../annotations/Necra.PRJNA196947
cd ../annotations/Necra.PRJNA196947

echo Necra.PRJNA196947.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA196947.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Necra.PRJNA196947.A.bam
rm /scratch/njohnson/Necra.PRJNA196947.A.bam



