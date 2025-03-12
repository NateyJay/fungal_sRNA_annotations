#!/bin/bash

mkdir ../annotations/Mabru.PRJNA731035
cd ../annotations/Mabru.PRJNA731035

echo Mabru.PRJNA731035.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mabru.PRJNA731035.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Mabru.PRJNA731035.D.bam
rm /scratch/njohnson/Mabru.PRJNA731035.D.bam



