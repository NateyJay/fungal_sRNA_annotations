#!/bin/bash

mkdir ../annotations/Bocin.PRJNA978613
cd ../annotations/Bocin.PRJNA978613

echo Bocin.PRJNA978613.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA978613.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bocin.PRJNA978613.A.bam
rm /scratch/njohnson/Bocin.PRJNA978613.A.bam



