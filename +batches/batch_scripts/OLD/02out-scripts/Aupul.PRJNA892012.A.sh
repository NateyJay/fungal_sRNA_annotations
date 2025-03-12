#!/bin/bash

mkdir ../annotations/Aupul.PRJNA892012
cd ../annotations/Aupul.PRJNA892012

echo Aupul.PRJNA892012.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Aupul.PRJNA892012.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Aupul.PRJNA892012.A.bam
rm /scratch/njohnson/Aupul.PRJNA892012.A.bam



