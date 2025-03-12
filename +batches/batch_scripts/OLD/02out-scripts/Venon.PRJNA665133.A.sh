#!/bin/bash

mkdir ../annotations/Venon.PRJNA665133
cd ../annotations/Venon.PRJNA665133

echo Venon.PRJNA665133.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Venon.PRJNA665133.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Venon.PRJNA665133.A.bam
rm /scratch/njohnson/Venon.PRJNA665133.A.bam



