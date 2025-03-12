#!/bin/bash

mkdir ../annotations/Asfla.PRJNA438019
cd ../annotations/Asfla.PRJNA438019

echo Asfla.PRJNA438019.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfla.PRJNA438019.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Asfla.PRJNA438019.B.bam
rm /scratch/njohnson/Asfla.PRJNA438019.B.bam



