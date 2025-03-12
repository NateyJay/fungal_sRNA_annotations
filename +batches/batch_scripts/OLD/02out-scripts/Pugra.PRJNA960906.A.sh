#!/bin/bash

mkdir ../annotations/Pugra.PRJNA960906
cd ../annotations/Pugra.PRJNA960906

echo Pugra.PRJNA960906.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pugra.PRJNA960906.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Pugra.PRJNA960906.A.bam
rm /scratch/njohnson/Pugra.PRJNA960906.A.bam



