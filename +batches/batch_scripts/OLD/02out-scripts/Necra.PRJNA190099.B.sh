#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA190099.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Necra.PRJNA190099.B.bam
rm /scratch/njohnson/Necra.PRJNA190099.B.bam



