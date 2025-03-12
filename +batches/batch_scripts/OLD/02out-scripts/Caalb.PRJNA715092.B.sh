#!/bin/bash

mkdir ../annotations/Caalb.PRJNA715092
cd ../annotations/Caalb.PRJNA715092

echo Caalb.PRJNA715092.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Caalb.PRJNA715092.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Caalb.PRJNA715092.B.bam
rm /scratch/njohnson/Caalb.PRJNA715092.B.bam



