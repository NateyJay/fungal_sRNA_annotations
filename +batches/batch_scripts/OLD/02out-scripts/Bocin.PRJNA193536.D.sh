#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193536
cd ../annotations/Bocin.PRJNA193536

echo Bocin.PRJNA193536.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193536.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Bocin.PRJNA193536.D.bam
rm /scratch/njohnson/Bocin.PRJNA193536.D.bam



