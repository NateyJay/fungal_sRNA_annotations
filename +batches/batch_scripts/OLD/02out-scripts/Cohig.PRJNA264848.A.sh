#!/bin/bash

mkdir ../annotations/Cohig.PRJNA264848
cd ../annotations/Cohig.PRJNA264848

echo Cohig.PRJNA264848.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cohig.PRJNA264848.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Cohig.PRJNA264848.A.bam
rm /scratch/njohnson/Cohig.PRJNA264848.A.bam



