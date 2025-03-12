#!/bin/bash

mkdir ../annotations/Capar.PRJNA715092
cd ../annotations/Capar.PRJNA715092

echo Capar.PRJNA715092.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Capar.PRJNA715092.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Capar.PRJNA715092.F.bam
rm /scratch/njohnson/Capar.PRJNA715092.F.bam



