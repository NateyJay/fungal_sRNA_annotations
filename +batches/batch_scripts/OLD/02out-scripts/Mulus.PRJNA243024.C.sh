#!/bin/bash

mkdir ../annotations/Mulus.PRJNA243024
cd ../annotations/Mulus.PRJNA243024

echo Mulus.PRJNA243024.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA243024.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Mulus.PRJNA243024.C.bam
rm /scratch/njohnson/Mulus.PRJNA243024.C.bam



