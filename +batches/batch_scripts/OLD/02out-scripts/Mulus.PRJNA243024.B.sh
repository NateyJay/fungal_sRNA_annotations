#!/bin/bash

mkdir ../annotations/Mulus.PRJNA243024
cd ../annotations/Mulus.PRJNA243024

echo Mulus.PRJNA243024.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA243024.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Mulus.PRJNA243024.B.bam
rm /scratch/njohnson/Mulus.PRJNA243024.B.bam



