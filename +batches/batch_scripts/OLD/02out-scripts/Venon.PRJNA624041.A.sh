#!/bin/bash

mkdir ../annotations/Venon.PRJNA624041
cd ../annotations/Venon.PRJNA624041

echo Venon.PRJNA624041.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Venon.PRJNA624041.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Venon.PRJNA624041.A.bam
rm /scratch/njohnson/Venon.PRJNA624041.A.bam



