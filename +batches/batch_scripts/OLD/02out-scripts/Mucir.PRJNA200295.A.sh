#!/bin/bash

mkdir ../annotations/Mucir.PRJNA200295
cd ../annotations/Mucir.PRJNA200295

echo Mucir.PRJNA200295.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mucir.PRJNA200295.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Mucir.PRJNA200295.A.bam
rm /scratch/njohnson/Mucir.PRJNA200295.A.bam



