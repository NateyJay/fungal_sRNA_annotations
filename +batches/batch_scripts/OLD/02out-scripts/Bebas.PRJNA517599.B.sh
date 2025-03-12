#!/bin/bash

mkdir ../annotations/Bebas.PRJNA517599
cd ../annotations/Bebas.PRJNA517599

echo Bebas.PRJNA517599.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bebas.PRJNA517599.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Bebas.PRJNA517599.B.bam
rm /scratch/njohnson/Bebas.PRJNA517599.B.bam



