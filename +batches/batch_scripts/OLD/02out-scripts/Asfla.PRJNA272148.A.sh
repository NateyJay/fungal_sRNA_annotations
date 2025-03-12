#!/bin/bash

mkdir ../annotations/Asfla.PRJNA272148
cd ../annotations/Asfla.PRJNA272148

echo Asfla.PRJNA272148.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfla.PRJNA272148.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Asfla.PRJNA272148.A.bam
rm /scratch/njohnson/Asfla.PRJNA272148.A.bam



