#!/bin/bash

mkdir ../annotations/Cocin.PRJNA477255
cd ../annotations/Cocin.PRJNA477255

echo Cocin.PRJNA477255.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cocin.PRJNA477255.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Cocin.PRJNA477255.A.bam
rm /scratch/njohnson/Cocin.PRJNA477255.A.bam



