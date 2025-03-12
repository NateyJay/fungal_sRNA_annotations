#!/bin/bash

mkdir ../annotations/Asfla.PRJNA816993
cd ../annotations/Asfla.PRJNA816993

echo Asfla.PRJNA816993.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfla.PRJNA816993.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Asfla.PRJNA816993.A.bam
rm /scratch/njohnson/Asfla.PRJNA816993.A.bam



