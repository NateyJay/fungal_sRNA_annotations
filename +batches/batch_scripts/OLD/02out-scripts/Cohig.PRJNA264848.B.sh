#!/bin/bash

mkdir ../annotations/Cohig.PRJNA264848
cd ../annotations/Cohig.PRJNA264848

echo Cohig.PRJNA264848.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cohig.PRJNA264848.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Cohig.PRJNA264848.B.bam
rm /scratch/njohnson/Cohig.PRJNA264848.B.bam



