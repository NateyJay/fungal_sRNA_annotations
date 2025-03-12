#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.I

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.I.bam
yasma.py tradeoff -o . -n I -ac I -a /scratch/njohnson/Mulus.PRJNA903107.I.bam
rm /scratch/njohnson/Mulus.PRJNA903107.I.bam



