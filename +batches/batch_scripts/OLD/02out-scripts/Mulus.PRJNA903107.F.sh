#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Mulus.PRJNA903107.F.bam
rm /scratch/njohnson/Mulus.PRJNA903107.F.bam



