#!/bin/bash

mkdir ../annotations/Cocin.PRJNA477255
cd ../annotations/Cocin.PRJNA477255

echo Cocin.PRJNA477255.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cocin.PRJNA477255.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Cocin.PRJNA477255.B.bam
rm /scratch/njohnson/Cocin.PRJNA477255.B.bam



