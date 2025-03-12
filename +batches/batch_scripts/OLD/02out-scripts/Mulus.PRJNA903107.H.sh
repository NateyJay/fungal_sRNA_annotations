#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.H

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.H.bam
yasma.py tradeoff -o . -n H -ac H -a /scratch/njohnson/Mulus.PRJNA903107.H.bam
rm /scratch/njohnson/Mulus.PRJNA903107.H.bam



