#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350403
cd ../annotations/Scpom.PRJNA350403

echo Scpom.PRJNA350403.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA350403.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA350403.A.bam
rm /scratch/njohnson/Scpom.PRJNA350403.A.bam



