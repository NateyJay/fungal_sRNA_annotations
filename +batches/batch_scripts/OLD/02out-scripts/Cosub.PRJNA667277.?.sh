#!/bin/bash

mkdir ../annotations/Cosub.PRJNA667277
cd ../annotations/Cosub.PRJNA667277

echo Cosub.PRJNA667277.?

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cosub.PRJNA667277.?.bam
yasma.py tradeoff -o . -n ? -ac ? -a /scratch/njohnson/Cosub.PRJNA667277.?.bam
rm /scratch/njohnson/Cosub.PRJNA667277.?.bam



