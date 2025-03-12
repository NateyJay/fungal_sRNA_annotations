#!/bin/bash

mkdir ../annotations/Capar.PRJNA715092
cd ../annotations/Capar.PRJNA715092

echo Capar.PRJNA715092.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Capar.PRJNA715092.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Capar.PRJNA715092.D.bam
rm /scratch/njohnson/Capar.PRJNA715092.D.bam



