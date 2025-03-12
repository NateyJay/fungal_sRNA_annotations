#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193537
cd ../annotations/Bocin.PRJNA193537

echo Bocin.PRJNA193537.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193537.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Bocin.PRJNA193537.B.bam
rm /scratch/njohnson/Bocin.PRJNA193537.B.bam



