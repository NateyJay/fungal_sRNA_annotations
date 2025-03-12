#!/bin/bash

mkdir ../annotations/Crneo.PRJNA185599
cd ../annotations/Crneo.PRJNA185599

echo Crneo.PRJNA185599.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Crneo.PRJNA185599.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Crneo.PRJNA185599.A.bam
rm /scratch/njohnson/Crneo.PRJNA185599.A.bam



