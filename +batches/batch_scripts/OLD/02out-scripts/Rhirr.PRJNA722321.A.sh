#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA722321
cd ../annotations/Rhirr.PRJNA722321

echo Rhirr.PRJNA722321.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA722321.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Rhirr.PRJNA722321.A.bam
rm /scratch/njohnson/Rhirr.PRJNA722321.A.bam



