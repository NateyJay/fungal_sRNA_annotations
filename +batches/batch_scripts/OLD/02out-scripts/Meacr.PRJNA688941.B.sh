#!/bin/bash

mkdir ../annotations/Meacr.PRJNA688941
cd ../annotations/Meacr.PRJNA688941

echo Meacr.PRJNA688941.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Meacr.PRJNA688941.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Meacr.PRJNA688941.B.bam
rm /scratch/njohnson/Meacr.PRJNA688941.B.bam



