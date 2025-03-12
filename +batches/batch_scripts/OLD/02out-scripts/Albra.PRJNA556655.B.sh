#!/bin/bash

mkdir ../annotations/Albra.PRJNA556655
cd ../annotations/Albra.PRJNA556655

echo Albra.PRJNA556655.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Albra.PRJNA556655.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Albra.PRJNA556655.B.bam
rm /scratch/njohnson/Albra.PRJNA556655.B.bam



