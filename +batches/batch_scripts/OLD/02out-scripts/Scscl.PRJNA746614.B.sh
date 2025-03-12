#!/bin/bash

mkdir ../annotations/Scscl.PRJNA746614
cd ../annotations/Scscl.PRJNA746614

echo Scscl.PRJNA746614.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA746614.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scscl.PRJNA746614.B.bam
rm /scratch/njohnson/Scscl.PRJNA746614.B.bam



