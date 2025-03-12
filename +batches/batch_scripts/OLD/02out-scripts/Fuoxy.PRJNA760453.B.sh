#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA760453
cd ../annotations/Fuoxy.PRJNA760453

echo Fuoxy.PRJNA760453.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA760453.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fuoxy.PRJNA760453.B.bam
rm /scratch/njohnson/Fuoxy.PRJNA760453.B.bam



