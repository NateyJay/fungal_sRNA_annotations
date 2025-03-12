#!/bin/bash

mkdir ../annotations/Yalip.PRJNA964764
cd ../annotations/Yalip.PRJNA964764

echo Yalip.PRJNA964764.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Yalip.PRJNA964764.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Yalip.PRJNA964764.A.bam
rm /scratch/njohnson/Yalip.PRJNA964764.A.bam



