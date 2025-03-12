#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.P

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.P.bam
yasma.py tradeoff -o . -n P -ac P -a /scratch/njohnson/Mulus.PRJNA903107.P.bam
rm /scratch/njohnson/Mulus.PRJNA903107.P.bam



