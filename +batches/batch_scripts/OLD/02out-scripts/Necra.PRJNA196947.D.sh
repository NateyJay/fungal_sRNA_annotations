#!/bin/bash

mkdir ../annotations/Necra.PRJNA196947
cd ../annotations/Necra.PRJNA196947

echo Necra.PRJNA196947.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA196947.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Necra.PRJNA196947.D.bam
rm /scratch/njohnson/Necra.PRJNA196947.D.bam



