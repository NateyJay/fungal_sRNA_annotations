#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350403
cd ../annotations/Scpom.PRJNA350403

echo Scpom.PRJNA350403.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA350403.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Scpom.PRJNA350403.D.bam
rm /scratch/njohnson/Scpom.PRJNA350403.D.bam



