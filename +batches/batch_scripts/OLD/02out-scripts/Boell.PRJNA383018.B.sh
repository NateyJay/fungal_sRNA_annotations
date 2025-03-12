#!/bin/bash

mkdir ../annotations/Boell.PRJNA383018
cd ../annotations/Boell.PRJNA383018

echo Boell.PRJNA383018.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Boell.PRJNA383018.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Boell.PRJNA383018.B.bam
rm /scratch/njohnson/Boell.PRJNA383018.B.bam



