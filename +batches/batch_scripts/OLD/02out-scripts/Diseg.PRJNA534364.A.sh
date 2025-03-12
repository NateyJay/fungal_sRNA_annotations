#!/bin/bash

mkdir ../annotations/Diseg.PRJNA534364
cd ../annotations/Diseg.PRJNA534364

echo Diseg.PRJNA534364.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Diseg.PRJNA534364.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Diseg.PRJNA534364.A.bam
rm /scratch/njohnson/Diseg.PRJNA534364.A.bam



