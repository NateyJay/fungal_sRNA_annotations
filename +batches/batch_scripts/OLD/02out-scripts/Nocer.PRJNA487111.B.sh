#!/bin/bash

mkdir ../annotations/Nocer.PRJNA487111
cd ../annotations/Nocer.PRJNA487111

echo Nocer.PRJNA487111.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nocer.PRJNA487111.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Nocer.PRJNA487111.B.bam
rm /scratch/njohnson/Nocer.PRJNA487111.B.bam



