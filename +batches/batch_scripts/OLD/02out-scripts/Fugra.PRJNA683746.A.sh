#!/bin/bash

mkdir ../annotations/Fugra.PRJNA683746
cd ../annotations/Fugra.PRJNA683746

echo Fugra.PRJNA683746.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA683746.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fugra.PRJNA683746.A.bam
rm /scratch/njohnson/Fugra.PRJNA683746.A.bam



