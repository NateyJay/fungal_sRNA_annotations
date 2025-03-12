#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Mulus.PRJNA903107.D.bam
rm /scratch/njohnson/Mulus.PRJNA903107.D.bam



