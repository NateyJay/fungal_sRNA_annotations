#!/bin/bash

mkdir ../annotations/Asfla.PRJNA816993
cd ../annotations/Asfla.PRJNA816993

echo Asfla.PRJNA816993.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfla.PRJNA816993.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Asfla.PRJNA816993.B.bam
rm /scratch/njohnson/Asfla.PRJNA816993.B.bam



