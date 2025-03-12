#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.S

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.S.bam
yasma.py tradeoff -o . -n S -ac S -a /scratch/njohnson/Mulus.PRJNA903107.S.bam
rm /scratch/njohnson/Mulus.PRJNA903107.S.bam



