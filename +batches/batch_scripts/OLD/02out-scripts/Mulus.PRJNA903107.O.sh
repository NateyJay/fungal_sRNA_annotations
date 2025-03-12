#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.O

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.O.bam
yasma.py tradeoff -o . -n O -ac O -a /scratch/njohnson/Mulus.PRJNA903107.O.bam
rm /scratch/njohnson/Mulus.PRJNA903107.O.bam



