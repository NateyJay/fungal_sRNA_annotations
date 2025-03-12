#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA472169
cd ../annotations/Fuoxy.PRJNA472169

echo Fuoxy.PRJNA472169.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA472169.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Fuoxy.PRJNA472169.D.bam
rm /scratch/njohnson/Fuoxy.PRJNA472169.D.bam



