#!/bin/bash

mkdir ../annotations/Necra.PRJNA125805
cd ../annotations/Necra.PRJNA125805

echo Necra.PRJNA125805.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA125805.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Necra.PRJNA125805.A.bam
rm /scratch/njohnson/Necra.PRJNA125805.A.bam



