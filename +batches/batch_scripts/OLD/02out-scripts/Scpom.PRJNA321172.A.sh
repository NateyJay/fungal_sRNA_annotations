#!/bin/bash

mkdir ../annotations/Scpom.PRJNA321172
cd ../annotations/Scpom.PRJNA321172

echo Scpom.PRJNA321172.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA321172.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA321172.A.bam
rm /scratch/njohnson/Scpom.PRJNA321172.A.bam



