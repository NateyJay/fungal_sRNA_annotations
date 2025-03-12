#!/bin/bash

mkdir ../annotations/Pyory.PRJNA322180
cd ../annotations/Pyory.PRJNA322180

echo Pyory.PRJNA322180.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pyory.PRJNA322180.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Pyory.PRJNA322180.A.bam
rm /scratch/njohnson/Pyory.PRJNA322180.A.bam



