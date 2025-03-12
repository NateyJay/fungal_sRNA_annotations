#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193535
cd ../annotations/Bocin.PRJNA193535

echo Bocin.PRJNA193535.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193535.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Bocin.PRJNA193535.B.bam
rm /scratch/njohnson/Bocin.PRJNA193535.B.bam



