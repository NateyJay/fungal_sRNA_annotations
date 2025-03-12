#!/bin/bash

mkdir ../annotations/Vovol.PRJNA594834
cd ../annotations/Vovol.PRJNA594834

echo Vovol.PRJNA594834.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vovol.PRJNA594834.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vovol.PRJNA594834.A.bam
rm /scratch/njohnson/Vovol.PRJNA594834.A.bam



