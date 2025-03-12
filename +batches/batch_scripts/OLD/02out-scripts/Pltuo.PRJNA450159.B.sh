#!/bin/bash

mkdir ../annotations/Pltuo.PRJNA450159
cd ../annotations/Pltuo.PRJNA450159

echo Pltuo.PRJNA450159.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pltuo.PRJNA450159.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Pltuo.PRJNA450159.B.bam
rm /scratch/njohnson/Pltuo.PRJNA450159.B.bam



