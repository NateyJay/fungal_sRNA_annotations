#!/bin/bash

mkdir ../annotations/Scpom.PRJNA301367
cd ../annotations/Scpom.PRJNA301367

echo Scpom.PRJNA301367.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA301367.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA301367.A.bam
rm /scratch/njohnson/Scpom.PRJNA301367.A.bam



