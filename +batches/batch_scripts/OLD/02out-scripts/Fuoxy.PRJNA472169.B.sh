#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA472169
cd ../annotations/Fuoxy.PRJNA472169

echo Fuoxy.PRJNA472169.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA472169.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fuoxy.PRJNA472169.B.bam
rm /scratch/njohnson/Fuoxy.PRJNA472169.B.bam



