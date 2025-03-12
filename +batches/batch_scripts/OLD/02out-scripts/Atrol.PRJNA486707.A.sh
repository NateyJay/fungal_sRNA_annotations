#!/bin/bash

mkdir ../annotations/Atrol.PRJNA486707
cd ../annotations/Atrol.PRJNA486707

echo Atrol.PRJNA486707.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Atrol.PRJNA486707.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Atrol.PRJNA486707.A.bam
rm /scratch/njohnson/Atrol.PRJNA486707.A.bam



