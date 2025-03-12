#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.N

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.N.bam
yasma.py tradeoff -o . -n N -ac N -a /scratch/njohnson/Mulus.PRJNA903107.N.bam
rm /scratch/njohnson/Mulus.PRJNA903107.N.bam



