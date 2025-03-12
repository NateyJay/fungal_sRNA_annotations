#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259172
cd ../annotations/Scpom.PRJNA259172

echo Scpom.PRJNA259172.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA259172.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Scpom.PRJNA259172.E.bam
rm /scratch/njohnson/Scpom.PRJNA259172.E.bam



