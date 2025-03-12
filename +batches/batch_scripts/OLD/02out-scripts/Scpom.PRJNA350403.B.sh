#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350403
cd ../annotations/Scpom.PRJNA350403

echo Scpom.PRJNA350403.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA350403.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scpom.PRJNA350403.B.bam
rm /scratch/njohnson/Scpom.PRJNA350403.B.bam



