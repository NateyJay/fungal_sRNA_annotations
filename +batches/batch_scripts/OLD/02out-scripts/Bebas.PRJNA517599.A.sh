#!/bin/bash

mkdir ../annotations/Bebas.PRJNA517599
cd ../annotations/Bebas.PRJNA517599

echo Bebas.PRJNA517599.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bebas.PRJNA517599.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bebas.PRJNA517599.A.bam
rm /scratch/njohnson/Bebas.PRJNA517599.A.bam



