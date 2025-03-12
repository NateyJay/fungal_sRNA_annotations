#!/bin/bash

mkdir ../annotations/Crneo.PRJNA629419
cd ../annotations/Crneo.PRJNA629419

echo Crneo.PRJNA629419.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Crneo.PRJNA629419.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Crneo.PRJNA629419.A.bam
rm /scratch/njohnson/Crneo.PRJNA629419.A.bam



