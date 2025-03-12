#!/bin/bash

mkdir ../annotations/Trrub.PRJNA483837
cd ../annotations/Trrub.PRJNA483837

echo Trrub.PRJNA483837.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Trrub.PRJNA483837.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Trrub.PRJNA483837.B.bam
rm /scratch/njohnson/Trrub.PRJNA483837.B.bam



