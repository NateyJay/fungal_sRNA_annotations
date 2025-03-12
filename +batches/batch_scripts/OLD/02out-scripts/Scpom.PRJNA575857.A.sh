#!/bin/bash

mkdir ../annotations/Scpom.PRJNA575857
cd ../annotations/Scpom.PRJNA575857

echo Scpom.PRJNA575857.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA575857.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA575857.A.bam
rm /scratch/njohnson/Scpom.PRJNA575857.A.bam



