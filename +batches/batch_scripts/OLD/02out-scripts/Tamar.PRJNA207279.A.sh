#!/bin/bash

mkdir ../annotations/Tamar.PRJNA207279
cd ../annotations/Tamar.PRJNA207279

echo Tamar.PRJNA207279.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Tamar.PRJNA207279.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Tamar.PRJNA207279.A.bam
rm /scratch/njohnson/Tamar.PRJNA207279.A.bam



