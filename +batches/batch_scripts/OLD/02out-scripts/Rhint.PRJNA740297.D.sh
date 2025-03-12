#!/bin/bash

mkdir ../annotations/Rhint.PRJNA740297
cd ../annotations/Rhint.PRJNA740297

echo Rhint.PRJNA740297.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhint.PRJNA740297.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Rhint.PRJNA740297.D.bam
rm /scratch/njohnson/Rhint.PRJNA740297.D.bam



