#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350403
cd ../annotations/Scpom.PRJNA350403

echo Scpom.PRJNA350403.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA350403.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Scpom.PRJNA350403.E.bam
rm /scratch/njohnson/Scpom.PRJNA350403.E.bam



