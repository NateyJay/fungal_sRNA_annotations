#!/bin/bash

mkdir ../annotations/Savan.PRJNA798153
cd ../annotations/Savan.PRJNA798153

echo Savan.PRJNA798153.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Savan.PRJNA798153.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Savan.PRJNA798153.B.bam
rm /scratch/njohnson/Savan.PRJNA798153.B.bam



