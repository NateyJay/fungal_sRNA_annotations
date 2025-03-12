#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA190099.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Necra.PRJNA190099.F.bam
rm /scratch/njohnson/Necra.PRJNA190099.F.bam



