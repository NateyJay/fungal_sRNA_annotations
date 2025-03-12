#!/bin/bash

mkdir ../annotations/Vovol.PRJNA594834
cd ../annotations/Vovol.PRJNA594834

echo Vovol.PRJNA594834.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vovol.PRJNA594834.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Vovol.PRJNA594834.D.bam
rm /scratch/njohnson/Vovol.PRJNA594834.D.bam



