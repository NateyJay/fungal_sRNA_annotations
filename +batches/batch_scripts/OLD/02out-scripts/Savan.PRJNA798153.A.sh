#!/bin/bash

mkdir ../annotations/Savan.PRJNA798153
cd ../annotations/Savan.PRJNA798153

echo Savan.PRJNA798153.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Savan.PRJNA798153.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Savan.PRJNA798153.A.bam
rm /scratch/njohnson/Savan.PRJNA798153.A.bam



