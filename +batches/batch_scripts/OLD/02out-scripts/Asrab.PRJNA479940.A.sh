#!/bin/bash

mkdir ../annotations/Asrab.PRJNA479940
cd ../annotations/Asrab.PRJNA479940

echo Asrab.PRJNA479940.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asrab.PRJNA479940.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Asrab.PRJNA479940.A.bam
rm /scratch/njohnson/Asrab.PRJNA479940.A.bam



