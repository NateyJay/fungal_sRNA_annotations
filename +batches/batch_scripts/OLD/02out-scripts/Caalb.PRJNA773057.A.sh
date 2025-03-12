#!/bin/bash

mkdir ../annotations/Caalb.PRJNA773057
cd ../annotations/Caalb.PRJNA773057

echo Caalb.PRJNA773057.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Caalb.PRJNA773057.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Caalb.PRJNA773057.A.bam
rm /scratch/njohnson/Caalb.PRJNA773057.A.bam



