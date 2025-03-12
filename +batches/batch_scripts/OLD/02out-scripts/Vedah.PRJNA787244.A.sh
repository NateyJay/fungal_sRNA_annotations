#!/bin/bash

mkdir ../annotations/Vedah.PRJNA787244
cd ../annotations/Vedah.PRJNA787244

echo Vedah.PRJNA787244.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vedah.PRJNA787244.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vedah.PRJNA787244.A.bam
rm /scratch/njohnson/Vedah.PRJNA787244.A.bam



