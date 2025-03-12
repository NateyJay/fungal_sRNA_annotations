#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193537
cd ../annotations/Bocin.PRJNA193537

echo Bocin.PRJNA193537.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193537.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bocin.PRJNA193537.A.bam
rm /scratch/njohnson/Bocin.PRJNA193537.A.bam



