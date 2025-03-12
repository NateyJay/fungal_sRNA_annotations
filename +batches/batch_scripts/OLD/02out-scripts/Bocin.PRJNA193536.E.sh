#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193536
cd ../annotations/Bocin.PRJNA193536

echo Bocin.PRJNA193536.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193536.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Bocin.PRJNA193536.E.bam
rm /scratch/njohnson/Bocin.PRJNA193536.E.bam



