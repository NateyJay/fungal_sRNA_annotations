#!/bin/bash

mkdir ../annotations/Scpom.PRJNA369032
cd ../annotations/Scpom.PRJNA369032

echo Scpom.PRJNA369032.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA369032.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA369032.A.bam
rm /scratch/njohnson/Scpom.PRJNA369032.A.bam



