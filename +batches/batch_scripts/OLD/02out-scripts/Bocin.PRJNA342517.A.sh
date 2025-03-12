#!/bin/bash

mkdir ../annotations/Bocin.PRJNA342517
cd ../annotations/Bocin.PRJNA342517

echo Bocin.PRJNA342517.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA342517.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bocin.PRJNA342517.A.bam
rm /scratch/njohnson/Bocin.PRJNA342517.A.bam



