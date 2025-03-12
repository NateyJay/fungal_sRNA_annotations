#!/bin/bash

mkdir ../annotations/Scpom.PRJNA183638
cd ../annotations/Scpom.PRJNA183638

echo Scpom.PRJNA183638.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA183638.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA183638.A.bam
rm /scratch/njohnson/Scpom.PRJNA183638.A.bam



