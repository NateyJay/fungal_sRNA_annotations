#!/bin/bash

mkdir ../annotations/Masym.PRJNA342612
cd ../annotations/Masym.PRJNA342612

echo Masym.PRJNA342612.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Masym.PRJNA342612.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Masym.PRJNA342612.B.bam
rm /scratch/njohnson/Masym.PRJNA342612.B.bam



