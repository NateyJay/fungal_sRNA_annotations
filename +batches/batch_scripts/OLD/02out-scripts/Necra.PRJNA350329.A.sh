#!/bin/bash

mkdir ../annotations/Necra.PRJNA350329
cd ../annotations/Necra.PRJNA350329

echo Necra.PRJNA350329.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA350329.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Necra.PRJNA350329.A.bam
rm /scratch/njohnson/Necra.PRJNA350329.A.bam



