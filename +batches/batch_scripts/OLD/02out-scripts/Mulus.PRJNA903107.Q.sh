#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.Q

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.Q.bam
yasma.py tradeoff -o . -n Q -ac Q -a /scratch/njohnson/Mulus.PRJNA903107.Q.bam
rm /scratch/njohnson/Mulus.PRJNA903107.Q.bam



