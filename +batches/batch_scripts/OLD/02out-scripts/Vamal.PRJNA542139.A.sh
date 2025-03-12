#!/bin/bash

mkdir ../annotations/Vamal.PRJNA542139
cd ../annotations/Vamal.PRJNA542139

echo Vamal.PRJNA542139.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vamal.PRJNA542139.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vamal.PRJNA542139.A.bam
rm /scratch/njohnson/Vamal.PRJNA542139.A.bam



