#!/bin/bash

mkdir ../annotations/Asrab.PRJNA479940
cd ../annotations/Asrab.PRJNA479940

echo Asrab.PRJNA479940.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asrab.PRJNA479940.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Asrab.PRJNA479940.E.bam
rm /scratch/njohnson/Asrab.PRJNA479940.E.bam



