#!/bin/bash

mkdir ../annotations/Asrab.PRJNA479940
cd ../annotations/Asrab.PRJNA479940

echo Asrab.PRJNA479940.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asrab.PRJNA479940.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Asrab.PRJNA479940.D.bam
rm /scratch/njohnson/Asrab.PRJNA479940.D.bam



