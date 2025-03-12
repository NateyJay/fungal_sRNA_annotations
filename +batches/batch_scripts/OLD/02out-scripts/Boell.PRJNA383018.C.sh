#!/bin/bash

mkdir ../annotations/Boell.PRJNA383018
cd ../annotations/Boell.PRJNA383018

echo Boell.PRJNA383018.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Boell.PRJNA383018.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Boell.PRJNA383018.C.bam
rm /scratch/njohnson/Boell.PRJNA383018.C.bam



