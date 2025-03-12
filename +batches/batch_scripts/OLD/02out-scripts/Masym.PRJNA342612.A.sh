#!/bin/bash

mkdir ../annotations/Masym.PRJNA342612
cd ../annotations/Masym.PRJNA342612

echo Masym.PRJNA342612.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Masym.PRJNA342612.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Masym.PRJNA342612.A.bam
rm /scratch/njohnson/Masym.PRJNA342612.A.bam



