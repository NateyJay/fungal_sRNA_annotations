#!/bin/bash

mkdir ../annotations/Fugra.PRJNA347833
cd ../annotations/Fugra.PRJNA347833

echo Fugra.PRJNA347833.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA347833.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fugra.PRJNA347833.A.bam
rm /scratch/njohnson/Fugra.PRJNA347833.A.bam



