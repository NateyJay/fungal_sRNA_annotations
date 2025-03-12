#!/bin/bash

mkdir ../annotations/Vealb.PRJNA213313
cd ../annotations/Vealb.PRJNA213313

echo Vealb.PRJNA213313.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vealb.PRJNA213313.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vealb.PRJNA213313.A.bam
rm /scratch/njohnson/Vealb.PRJNA213313.A.bam



