#!/bin/bash

mkdir ../annotations/Caalb.PRJNA715092
cd ../annotations/Caalb.PRJNA715092

echo Caalb.PRJNA715092.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Caalb.PRJNA715092.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Caalb.PRJNA715092.A.bam
rm /scratch/njohnson/Caalb.PRJNA715092.A.bam



