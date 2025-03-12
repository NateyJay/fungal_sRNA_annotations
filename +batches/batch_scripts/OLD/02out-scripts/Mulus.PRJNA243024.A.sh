#!/bin/bash

mkdir ../annotations/Mulus.PRJNA243024
cd ../annotations/Mulus.PRJNA243024

echo Mulus.PRJNA243024.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA243024.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Mulus.PRJNA243024.A.bam
rm /scratch/njohnson/Mulus.PRJNA243024.A.bam



