#!/bin/bash

mkdir ../annotations/Fubra.PRJNA510758
cd ../annotations/Fubra.PRJNA510758

echo Fubra.PRJNA510758.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fubra.PRJNA510758.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fubra.PRJNA510758.A.bam
rm /scratch/njohnson/Fubra.PRJNA510758.A.bam



