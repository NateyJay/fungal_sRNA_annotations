#!/bin/bash

mkdir ../annotations/Trrub.PRJNA483837
cd ../annotations/Trrub.PRJNA483837

echo Trrub.PRJNA483837.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Trrub.PRJNA483837.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Trrub.PRJNA483837.A.bam
rm /scratch/njohnson/Trrub.PRJNA483837.A.bam



