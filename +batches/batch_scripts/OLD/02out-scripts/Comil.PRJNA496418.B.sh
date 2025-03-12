#!/bin/bash

mkdir ../annotations/Comil.PRJNA496418
cd ../annotations/Comil.PRJNA496418

echo Comil.PRJNA496418.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Comil.PRJNA496418.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Comil.PRJNA496418.B.bam
rm /scratch/njohnson/Comil.PRJNA496418.B.bam



