#!/bin/bash

mkdir ../annotations/Bocin.PRJNA1092616
cd ../annotations/Bocin.PRJNA1092616

echo Bocin.PRJNA1092616.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA1092616.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bocin.PRJNA1092616.A.bam
rm /scratch/njohnson/Bocin.PRJNA1092616.A.bam



