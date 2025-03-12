#!/bin/bash

mkdir ../annotations/Bocin.PRJNA325479
cd ../annotations/Bocin.PRJNA325479

echo Bocin.PRJNA325479.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA325479.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bocin.PRJNA325479.A.bam
rm /scratch/njohnson/Bocin.PRJNA325479.A.bam



