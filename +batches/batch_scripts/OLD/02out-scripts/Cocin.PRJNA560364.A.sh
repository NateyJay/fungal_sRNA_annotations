#!/bin/bash

mkdir ../annotations/Cocin.PRJNA560364
cd ../annotations/Cocin.PRJNA560364

echo Cocin.PRJNA560364.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cocin.PRJNA560364.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Cocin.PRJNA560364.A.bam
rm /scratch/njohnson/Cocin.PRJNA560364.A.bam



