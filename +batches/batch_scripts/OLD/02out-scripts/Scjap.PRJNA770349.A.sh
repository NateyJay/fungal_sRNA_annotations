#!/bin/bash

mkdir ../annotations/Scjap.PRJNA770349
cd ../annotations/Scjap.PRJNA770349

echo Scjap.PRJNA770349.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scjap.PRJNA770349.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scjap.PRJNA770349.A.bam
rm /scratch/njohnson/Scjap.PRJNA770349.A.bam



