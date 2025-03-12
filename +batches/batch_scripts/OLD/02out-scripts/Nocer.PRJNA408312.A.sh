#!/bin/bash

mkdir ../annotations/Nocer.PRJNA408312
cd ../annotations/Nocer.PRJNA408312

echo Nocer.PRJNA408312.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nocer.PRJNA408312.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Nocer.PRJNA408312.A.bam
rm /scratch/njohnson/Nocer.PRJNA408312.A.bam



