#!/bin/bash

mkdir ../annotations/Capar.PRJNA715092
cd ../annotations/Capar.PRJNA715092

echo Capar.PRJNA715092.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Capar.PRJNA715092.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Capar.PRJNA715092.E.bam
rm /scratch/njohnson/Capar.PRJNA715092.E.bam



