#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Mulus.PRJNA903107.B.bam
rm /scratch/njohnson/Mulus.PRJNA903107.B.bam



