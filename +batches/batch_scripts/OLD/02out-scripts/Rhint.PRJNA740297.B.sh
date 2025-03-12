#!/bin/bash

mkdir ../annotations/Rhint.PRJNA740297
cd ../annotations/Rhint.PRJNA740297

echo Rhint.PRJNA740297.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhint.PRJNA740297.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Rhint.PRJNA740297.B.bam
rm /scratch/njohnson/Rhint.PRJNA740297.B.bam



