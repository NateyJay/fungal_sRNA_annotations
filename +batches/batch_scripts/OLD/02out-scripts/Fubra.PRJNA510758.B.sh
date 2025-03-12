#!/bin/bash

mkdir ../annotations/Fubra.PRJNA510758
cd ../annotations/Fubra.PRJNA510758

echo Fubra.PRJNA510758.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fubra.PRJNA510758.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fubra.PRJNA510758.B.bam
rm /scratch/njohnson/Fubra.PRJNA510758.B.bam



