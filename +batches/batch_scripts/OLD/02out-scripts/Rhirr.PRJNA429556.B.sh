#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA429556
cd ../annotations/Rhirr.PRJNA429556

echo Rhirr.PRJNA429556.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA429556.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Rhirr.PRJNA429556.B.bam
rm /scratch/njohnson/Rhirr.PRJNA429556.B.bam



