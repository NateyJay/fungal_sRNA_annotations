#!/bin/bash

mkdir ../annotations/Trrub.PRJNA627692
cd ../annotations/Trrub.PRJNA627692

echo Trrub.PRJNA627692.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Trrub.PRJNA627692.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Trrub.PRJNA627692.A.bam
rm /scratch/njohnson/Trrub.PRJNA627692.A.bam



