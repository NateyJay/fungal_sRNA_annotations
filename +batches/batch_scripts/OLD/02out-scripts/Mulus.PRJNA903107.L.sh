#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.L

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.L.bam
yasma.py tradeoff -o . -n L -ac L -a /scratch/njohnson/Mulus.PRJNA903107.L.bam
rm /scratch/njohnson/Mulus.PRJNA903107.L.bam



