#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Mulus.PRJNA903107.E.bam
rm /scratch/njohnson/Mulus.PRJNA903107.E.bam



