#!/bin/bash

mkdir ../annotations/Rhint.PRJNA740297
cd ../annotations/Rhint.PRJNA740297

echo Rhint.PRJNA740297.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhint.PRJNA740297.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Rhint.PRJNA740297.A.bam
rm /scratch/njohnson/Rhint.PRJNA740297.A.bam



