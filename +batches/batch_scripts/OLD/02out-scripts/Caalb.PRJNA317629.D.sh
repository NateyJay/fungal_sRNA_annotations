#!/bin/bash

mkdir ../annotations/Caalb.PRJNA317629
cd ../annotations/Caalb.PRJNA317629

echo Caalb.PRJNA317629.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Caalb.PRJNA317629.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Caalb.PRJNA317629.D.bam
rm /scratch/njohnson/Caalb.PRJNA317629.D.bam



