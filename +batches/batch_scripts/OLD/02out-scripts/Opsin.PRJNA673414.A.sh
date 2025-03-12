#!/bin/bash

mkdir ../annotations/Opsin.PRJNA673414
cd ../annotations/Opsin.PRJNA673414

echo Opsin.PRJNA673414.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Opsin.PRJNA673414.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Opsin.PRJNA673414.A.bam
rm /scratch/njohnson/Opsin.PRJNA673414.A.bam



