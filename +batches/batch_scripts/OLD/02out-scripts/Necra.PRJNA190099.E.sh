#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA190099.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Necra.PRJNA190099.E.bam
rm /scratch/njohnson/Necra.PRJNA190099.E.bam



