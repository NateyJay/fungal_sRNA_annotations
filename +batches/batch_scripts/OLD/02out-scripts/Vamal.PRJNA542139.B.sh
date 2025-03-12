#!/bin/bash

mkdir ../annotations/Vamal.PRJNA542139
cd ../annotations/Vamal.PRJNA542139

echo Vamal.PRJNA542139.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vamal.PRJNA542139.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Vamal.PRJNA542139.B.bam
rm /scratch/njohnson/Vamal.PRJNA542139.B.bam



