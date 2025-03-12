#!/bin/bash

mkdir ../annotations/Nobom.PRJNA953616
cd ../annotations/Nobom.PRJNA953616

echo Nobom.PRJNA953616.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nobom.PRJNA953616.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Nobom.PRJNA953616.A.bam
rm /scratch/njohnson/Nobom.PRJNA953616.A.bam



