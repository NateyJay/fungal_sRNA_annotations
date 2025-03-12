#!/bin/bash

mkdir ../annotations/Asrab.PRJNA479940
cd ../annotations/Asrab.PRJNA479940

echo Asrab.PRJNA479940.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asrab.PRJNA479940.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Asrab.PRJNA479940.B.bam
rm /scratch/njohnson/Asrab.PRJNA479940.B.bam



