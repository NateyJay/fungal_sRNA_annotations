#!/bin/bash

mkdir ../annotations/Scpom.PRJNA168300
cd ../annotations/Scpom.PRJNA168300

echo Scpom.PRJNA168300.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA168300.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA168300.A.bam
rm /scratch/njohnson/Scpom.PRJNA168300.A.bam



