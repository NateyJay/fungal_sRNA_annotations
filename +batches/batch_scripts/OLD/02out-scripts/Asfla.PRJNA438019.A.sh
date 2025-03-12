#!/bin/bash

mkdir ../annotations/Asfla.PRJNA438019
cd ../annotations/Asfla.PRJNA438019

echo Asfla.PRJNA438019.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfla.PRJNA438019.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Asfla.PRJNA438019.A.bam
rm /scratch/njohnson/Asfla.PRJNA438019.A.bam



