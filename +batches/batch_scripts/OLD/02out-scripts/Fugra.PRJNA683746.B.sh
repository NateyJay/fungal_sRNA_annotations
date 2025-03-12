#!/bin/bash

mkdir ../annotations/Fugra.PRJNA683746
cd ../annotations/Fugra.PRJNA683746

echo Fugra.PRJNA683746.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA683746.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fugra.PRJNA683746.B.bam
rm /scratch/njohnson/Fugra.PRJNA683746.B.bam



