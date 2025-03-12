#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193536
cd ../annotations/Bocin.PRJNA193536

echo Bocin.PRJNA193536.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193536.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Bocin.PRJNA193536.F.bam
rm /scratch/njohnson/Bocin.PRJNA193536.F.bam



