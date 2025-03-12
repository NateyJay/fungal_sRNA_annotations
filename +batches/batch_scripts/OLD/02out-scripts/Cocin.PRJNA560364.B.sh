#!/bin/bash

mkdir ../annotations/Cocin.PRJNA560364
cd ../annotations/Cocin.PRJNA560364

echo Cocin.PRJNA560364.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cocin.PRJNA560364.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Cocin.PRJNA560364.B.bam
rm /scratch/njohnson/Cocin.PRJNA560364.B.bam



