#!/bin/bash

mkdir ../annotations/Nacas.PRJNA600940
cd ../annotations/Nacas.PRJNA600940

echo Nacas.PRJNA600940.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nacas.PRJNA600940.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Nacas.PRJNA600940.B.bam
rm /scratch/njohnson/Nacas.PRJNA600940.B.bam



