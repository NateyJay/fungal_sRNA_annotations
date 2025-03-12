#!/bin/bash

mkdir ../annotations/Pustr.PRJNA355964
cd ../annotations/Pustr.PRJNA355964

echo Pustr.PRJNA355964.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pustr.PRJNA355964.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Pustr.PRJNA355964.A.bam
rm /scratch/njohnson/Pustr.PRJNA355964.A.bam



