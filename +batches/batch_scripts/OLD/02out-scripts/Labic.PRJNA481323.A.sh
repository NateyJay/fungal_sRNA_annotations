#!/bin/bash

mkdir ../annotations/Labic.PRJNA481323
cd ../annotations/Labic.PRJNA481323

echo Labic.PRJNA481323.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Labic.PRJNA481323.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Labic.PRJNA481323.A.bam
rm /scratch/njohnson/Labic.PRJNA481323.A.bam



