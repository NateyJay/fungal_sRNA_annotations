#!/bin/bash

mkdir ../annotations/Venon.PRJNA665133
cd ../annotations/Venon.PRJNA665133

echo Venon.PRJNA665133.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Venon.PRJNA665133.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Venon.PRJNA665133.B.bam
rm /scratch/njohnson/Venon.PRJNA665133.B.bam



