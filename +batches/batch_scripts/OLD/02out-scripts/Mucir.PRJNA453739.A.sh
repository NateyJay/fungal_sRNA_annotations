#!/bin/bash

mkdir ../annotations/Mucir.PRJNA453739
cd ../annotations/Mucir.PRJNA453739

echo Mucir.PRJNA453739.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mucir.PRJNA453739.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Mucir.PRJNA453739.A.bam
rm /scratch/njohnson/Mucir.PRJNA453739.A.bam



