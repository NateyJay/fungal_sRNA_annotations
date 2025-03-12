#!/bin/bash

mkdir ../annotations/Crgat.PRJNA368962
cd ../annotations/Crgat.PRJNA368962

echo Crgat.PRJNA368962.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Crgat.PRJNA368962.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Crgat.PRJNA368962.A.bam
rm /scratch/njohnson/Crgat.PRJNA368962.A.bam



