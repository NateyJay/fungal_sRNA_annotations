#!/bin/bash

mkdir ../annotations/Spsci.PRJNA322114
cd ../annotations/Spsci.PRJNA322114

echo Spsci.PRJNA322114.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Spsci.PRJNA322114.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Spsci.PRJNA322114.A.bam
rm /scratch/njohnson/Spsci.PRJNA322114.A.bam



