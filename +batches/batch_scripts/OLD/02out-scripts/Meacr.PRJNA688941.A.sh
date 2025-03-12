#!/bin/bash

mkdir ../annotations/Meacr.PRJNA688941
cd ../annotations/Meacr.PRJNA688941

echo Meacr.PRJNA688941.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Meacr.PRJNA688941.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Meacr.PRJNA688941.A.bam
rm /scratch/njohnson/Meacr.PRJNA688941.A.bam



