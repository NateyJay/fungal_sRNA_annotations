#!/bin/bash

mkdir ../annotations/Rasol.PRJNA213313
cd ../annotations/Rasol.PRJNA213313

echo Rasol.PRJNA213313.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rasol.PRJNA213313.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Rasol.PRJNA213313.B.bam
rm /scratch/njohnson/Rasol.PRJNA213313.B.bam



