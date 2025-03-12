#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Mulus.PRJNA903107.A.bam
rm /scratch/njohnson/Mulus.PRJNA903107.A.bam



