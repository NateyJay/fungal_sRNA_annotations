#!/bin/bash

mkdir ../annotations/Nobom.PRJNA953616
cd ../annotations/Nobom.PRJNA953616

echo Nobom.PRJNA953616.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nobom.PRJNA953616.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Nobom.PRJNA953616.D.bam
rm /scratch/njohnson/Nobom.PRJNA953616.D.bam



