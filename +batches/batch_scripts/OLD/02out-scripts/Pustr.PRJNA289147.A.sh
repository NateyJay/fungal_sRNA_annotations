#!/bin/bash

mkdir ../annotations/Pustr.PRJNA289147
cd ../annotations/Pustr.PRJNA289147

echo Pustr.PRJNA289147.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pustr.PRJNA289147.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Pustr.PRJNA289147.A.bam
rm /scratch/njohnson/Pustr.PRJNA289147.A.bam



