#!/bin/bash

mkdir ../annotations/Coglo.PRJNA490143
cd ../annotations/Coglo.PRJNA490143

echo Coglo.PRJNA490143.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Coglo.PRJNA490143.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Coglo.PRJNA490143.A.bam
rm /scratch/njohnson/Coglo.PRJNA490143.A.bam



