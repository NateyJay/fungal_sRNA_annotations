#!/bin/bash

mkdir ../annotations/Agbis.PRJNA770841
cd ../annotations/Agbis.PRJNA770841

echo Agbis.PRJNA770841.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Agbis.PRJNA770841.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Agbis.PRJNA770841.A.bam
rm /scratch/njohnson/Agbis.PRJNA770841.A.bam



