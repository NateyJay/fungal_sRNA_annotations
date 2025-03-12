#!/bin/bash

mkdir ../annotations/Pustr.PRJNA289147
cd ../annotations/Pustr.PRJNA289147

echo Pustr.PRJNA289147.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pustr.PRJNA289147.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Pustr.PRJNA289147.D.bam
rm /scratch/njohnson/Pustr.PRJNA289147.D.bam



