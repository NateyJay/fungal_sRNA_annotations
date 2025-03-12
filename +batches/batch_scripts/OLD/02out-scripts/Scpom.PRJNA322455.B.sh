#!/bin/bash

mkdir ../annotations/Scpom.PRJNA322455
cd ../annotations/Scpom.PRJNA322455

echo Scpom.PRJNA322455.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA322455.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scpom.PRJNA322455.B.bam
rm /scratch/njohnson/Scpom.PRJNA322455.B.bam



