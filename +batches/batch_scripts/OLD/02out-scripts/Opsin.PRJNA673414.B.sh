#!/bin/bash

mkdir ../annotations/Opsin.PRJNA673414
cd ../annotations/Opsin.PRJNA673414

echo Opsin.PRJNA673414.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Opsin.PRJNA673414.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Opsin.PRJNA673414.B.bam
rm /scratch/njohnson/Opsin.PRJNA673414.B.bam



