#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA190099.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Necra.PRJNA190099.D.bam
rm /scratch/njohnson/Necra.PRJNA190099.D.bam



