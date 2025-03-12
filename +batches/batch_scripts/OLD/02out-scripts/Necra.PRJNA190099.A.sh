#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA190099.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Necra.PRJNA190099.A.bam
rm /scratch/njohnson/Necra.PRJNA190099.A.bam



