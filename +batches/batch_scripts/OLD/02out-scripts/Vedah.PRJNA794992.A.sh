#!/bin/bash

mkdir ../annotations/Vedah.PRJNA794992
cd ../annotations/Vedah.PRJNA794992

echo Vedah.PRJNA794992.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vedah.PRJNA794992.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vedah.PRJNA794992.A.bam
rm /scratch/njohnson/Vedah.PRJNA794992.A.bam



