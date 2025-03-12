#!/bin/bash

mkdir ../annotations/Nobom.PRJNA953616
cd ../annotations/Nobom.PRJNA953616

echo Nobom.PRJNA953616.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nobom.PRJNA953616.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Nobom.PRJNA953616.B.bam
rm /scratch/njohnson/Nobom.PRJNA953616.B.bam



