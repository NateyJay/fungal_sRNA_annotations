#!/bin/bash

mkdir ../annotations/Petra.PRJNA756805
cd ../annotations/Petra.PRJNA756805

echo Petra.PRJNA756805.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Petra.PRJNA756805.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Petra.PRJNA756805.A.bam
rm /scratch/njohnson/Petra.PRJNA756805.A.bam



