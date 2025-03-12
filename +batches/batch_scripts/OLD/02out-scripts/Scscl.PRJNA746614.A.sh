#!/bin/bash

mkdir ../annotations/Scscl.PRJNA746614
cd ../annotations/Scscl.PRJNA746614

echo Scscl.PRJNA746614.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA746614.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scscl.PRJNA746614.A.bam
rm /scratch/njohnson/Scscl.PRJNA746614.A.bam



