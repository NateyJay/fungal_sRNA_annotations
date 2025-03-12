#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350403
cd ../annotations/Scpom.PRJNA350403

echo Scpom.PRJNA350403.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA350403.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Scpom.PRJNA350403.F.bam
rm /scratch/njohnson/Scpom.PRJNA350403.F.bam



