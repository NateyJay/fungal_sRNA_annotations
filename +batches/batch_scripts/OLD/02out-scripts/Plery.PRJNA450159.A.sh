#!/bin/bash

mkdir ../annotations/Plery.PRJNA450159
cd ../annotations/Plery.PRJNA450159

echo Plery.PRJNA450159.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plery.PRJNA450159.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Plery.PRJNA450159.A.bam
rm /scratch/njohnson/Plery.PRJNA450159.A.bam



