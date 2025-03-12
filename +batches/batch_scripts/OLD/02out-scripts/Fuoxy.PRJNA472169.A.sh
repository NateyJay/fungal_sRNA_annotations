#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA472169
cd ../annotations/Fuoxy.PRJNA472169

echo Fuoxy.PRJNA472169.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA472169.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fuoxy.PRJNA472169.A.bam
rm /scratch/njohnson/Fuoxy.PRJNA472169.A.bam



