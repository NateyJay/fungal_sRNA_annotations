#!/bin/bash

mkdir ../annotations/Nocer.PRJNA487111
cd ../annotations/Nocer.PRJNA487111

echo Nocer.PRJNA487111.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nocer.PRJNA487111.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Nocer.PRJNA487111.A.bam
rm /scratch/njohnson/Nocer.PRJNA487111.A.bam



