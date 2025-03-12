#!/bin/bash

mkdir ../annotations/Vovol.PRJNA594834
cd ../annotations/Vovol.PRJNA594834

echo Vovol.PRJNA594834.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vovol.PRJNA594834.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Vovol.PRJNA594834.B.bam
rm /scratch/njohnson/Vovol.PRJNA594834.B.bam



