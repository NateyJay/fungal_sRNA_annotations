#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA722321
cd ../annotations/Rhirr.PRJNA722321

echo Rhirr.PRJNA722321.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA722321.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Rhirr.PRJNA722321.B.bam
rm /scratch/njohnson/Rhirr.PRJNA722321.B.bam



