#!/bin/bash

mkdir ../annotations/Boell.PRJNA383018
cd ../annotations/Boell.PRJNA383018

echo Boell.PRJNA383018.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Boell.PRJNA383018.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Boell.PRJNA383018.A.bam
rm /scratch/njohnson/Boell.PRJNA383018.A.bam



