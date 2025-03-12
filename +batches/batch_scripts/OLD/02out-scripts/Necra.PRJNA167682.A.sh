#!/bin/bash

mkdir ../annotations/Necra.PRJNA167682
cd ../annotations/Necra.PRJNA167682

echo Necra.PRJNA167682.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA167682.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Necra.PRJNA167682.A.bam
rm /scratch/njohnson/Necra.PRJNA167682.A.bam



