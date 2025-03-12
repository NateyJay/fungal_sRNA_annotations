#!/bin/bash

mkdir ../annotations/Focan.PRJNA705837
cd ../annotations/Focan.PRJNA705837

echo Focan.PRJNA705837.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Focan.PRJNA705837.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Focan.PRJNA705837.A.bam
rm /scratch/njohnson/Focan.PRJNA705837.A.bam



